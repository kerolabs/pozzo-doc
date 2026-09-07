$ErrorActionPreference = 'Stop'

$env:Path = [System.Environment]::GetEnvironmentVariable('Path', 'Machine') +
            ';' +
            [System.Environment]::GetEnvironmentVariable('Path', 'User')

$dependencies = @(
    [pscustomobject]@{
        Name     = 'Pandoc'
        Command  = 'pandoc'
        WingetId = 'JohnMacFarlane.Pandoc'
        Purpose  = 'converts Markdown to LaTeX'
        Size     = '~150 MB'
    }
    [pscustomobject]@{
        Name     = 'MiKTeX (XeLaTeX)'
        Command  = 'xelatex'
        WingetId = 'MiKTeX.MiKTeX'
        Purpose  = 'compiles LaTeX into the final PDF'
        Size     = '~250 MB, grows as it downloads LaTeX packages'
    }
)

$latexPackages = @(
    [pscustomobject]@{
        Name    = 'TeX Gyre Termes font'
        Package = 'tex-gyre'
        File    = 'texgyretermes-regular.otf'
        Purpose = 'the Times clone required by APA 7'
        Size    = '~10 MB'
    }
)

function Test-Dependency {
    param([string]$Command)
    $found = Get-Command $Command -ErrorAction SilentlyContinue
    if ($null -eq $found) { return $null }
    return $found.Source
}

function Test-LatexFile {
    param([string]$File)
    if ($null -eq (Get-Command kpsewhich -ErrorAction SilentlyContinue)) { return $null }
    $path = kpsewhich $File
    if ([string]::IsNullOrWhiteSpace($path)) { return $null }
    return $path.Trim()
}

Write-Host ''
Write-Host 'Configuring git hooks...' -ForegroundColor Cyan

$repo = Split-Path $PSScriptRoot -Parent
if (Test-Path (Join-Path $repo '.githooks')) {
    Push-Location $repo
    git config core.hooksPath .githooks
    Pop-Location
    Write-Host '  core.hooksPath -> .githooks' -ForegroundColor Green
}
else {
    Write-Host '  .githooks not found, skipped' -ForegroundColor Yellow
}

Write-Host ''
Write-Host 'Checking build dependencies...' -ForegroundColor Cyan
Write-Host ''

$missingTools = @()
$missingPackages = @()

foreach ($dep in $dependencies) {
    $path = Test-Dependency -Command $dep.Command
    if ($null -ne $path) {
        Write-Host ('  [OK]      {0} is already installed' -f $dep.Name) -ForegroundColor Green
        Write-Host ('            {0}' -f $path) -ForegroundColor DarkGray
    }
    else {
        Write-Host ('  [MISSING] {0} - {1}' -f $dep.Name, $dep.Purpose) -ForegroundColor Yellow
        $missingTools += $dep
    }
}

foreach ($pkg in $latexPackages) {
    $path = Test-LatexFile -File $pkg.File
    if ($null -ne $path) {
        Write-Host ('  [OK]      {0} is already installed' -f $pkg.Name) -ForegroundColor Green
        Write-Host ('            {0}' -f $path) -ForegroundColor DarkGray
    }
    else {
        Write-Host ('  [MISSING] {0} - {1}' -f $pkg.Name, $pkg.Purpose) -ForegroundColor Yellow
        $missingPackages += $pkg
    }
}

Write-Host ''

if ($missingTools.Count -eq 0 -and $missingPackages.Count -eq 0) {
    Write-Host 'All dependencies are already installed. Nothing to do.' -ForegroundColor Green
    Write-Host 'You can build the report with:  .\scripts\build.ps1 tb1'
    Write-Host ''
    exit 0
}

if ($missingTools.Count -gt 0 -and $null -eq (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host 'winget is not available on this machine, so this script cannot install anything.' -ForegroundColor Red
    Write-Host 'Install the missing tools manually:'
    Write-Host '  Pandoc  ->  https://pandoc.org/installing.html'
    Write-Host '  MiKTeX  ->  https://miktex.org/download'
    Write-Host ''
    exit 1
}

$total = $missingTools.Count + $missingPackages.Count
if ($total -eq 1) { $word = 'item needs' } else { $word = 'items need' }

Write-Host ('The following {0} to be installed:' -f $word)
Write-Host ''
foreach ($dep in $missingTools)    { Write-Host ('  - {0}  ({1})' -f $dep.Name, $dep.Size) }
foreach ($pkg in $missingPackages) { Write-Host ('  - {0}  ({1})' -f $pkg.Name, $pkg.Size) }
Write-Host ''
Write-Host 'This will download and install software on your computer.' -ForegroundColor Yellow

$answer = Read-Host 'Install now? [y/N]'

if ($answer -notmatch '^(y|yes)$') {
    Write-Host ''
    Write-Host 'Cancelled. Nothing was installed.' -ForegroundColor Yellow
    Write-Host ''
    exit 0
}

Write-Host ''

foreach ($dep in $missingTools) {
    Write-Host ('Installing {0}...' -f $dep.Name) -ForegroundColor Cyan

    winget install --id $dep.WingetId --exact --silent --accept-package-agreements --accept-source-agreements

    if ($LASTEXITCODE -ne 0) {
        Write-Host ('  Installation of {0} failed (winget exit code {1}).' -f $dep.Name, $LASTEXITCODE) -ForegroundColor Red
        Write-Host '  Try running it by hand:'
        Write-Host ('    winget install --id {0} --exact' -f $dep.WingetId)
        exit 1
    }

    Write-Host ('  {0} installed.' -f $dep.Name) -ForegroundColor Green
    Write-Host ''
}

$env:Path = [System.Environment]::GetEnvironmentVariable('Path', 'Machine') +
            ';' +
            [System.Environment]::GetEnvironmentVariable('Path', 'User')

if ($null -ne (Get-Command initexmf -ErrorAction SilentlyContinue)) {
    Write-Host 'Configuring MiKTeX to auto-install missing LaTeX packages...' -ForegroundColor Cyan
    try {
        initexmf --set-config-value '[MPM]AutoInstall=1'
        Write-Host '  Done.' -ForegroundColor Green
    }
    catch {
        Write-Host '  Could not set it automatically.' -ForegroundColor Yellow
        Write-Host '  Open the MiKTeX Console and enable "Always install missing packages on the fly".'
    }
    Write-Host ''
}

if ($missingPackages.Count -gt 0) {
    if ($null -eq (Get-Command mpm -ErrorAction SilentlyContinue)) {
        Write-Host 'mpm (the MiKTeX package manager) is not visible in this window.' -ForegroundColor Yellow
        Write-Host 'Open a new terminal and run this script again to finish installing:'
        foreach ($pkg in $missingPackages) { Write-Host ('  - {0}' -f $pkg.Name) }
        Write-Host ''
    }
    else {
        foreach ($pkg in $missingPackages) {
            Write-Host ('Installing {0} (LaTeX package {1})...' -f $pkg.Name, $pkg.Package) -ForegroundColor Cyan

            mpm --install=$($pkg.Package)

            if ($LASTEXITCODE -ne 0) {
                Write-Host ('  Installation of {0} failed (mpm exit code {1}).' -f $pkg.Package, $LASTEXITCODE) -ForegroundColor Red
                Write-Host '  Try running it by hand:'
                Write-Host ('    mpm --install={0}' -f $pkg.Package)
                exit 1
            }

            Write-Host ('  {0} installed.' -f $pkg.Name) -ForegroundColor Green
            Write-Host ''
        }
    }
}

Write-Host 'Verifying...' -ForegroundColor Cyan
Write-Host ''

$stillMissing = @()

foreach ($dep in $dependencies) {
    if ($null -ne (Test-Dependency -Command $dep.Command)) {
        Write-Host ('  [OK]      {0}' -f $dep.Name) -ForegroundColor Green
    }
    else {
        Write-Host ('  [PENDING] {0}' -f $dep.Name) -ForegroundColor Yellow
        $stillMissing += $dep.Name
    }
}

foreach ($pkg in $latexPackages) {
    if ($null -ne (Test-LatexFile -File $pkg.File)) {
        Write-Host ('  [OK]      {0}' -f $pkg.Name) -ForegroundColor Green
    }
    else {
        Write-Host ('  [PENDING] {0}' -f $pkg.Name) -ForegroundColor Yellow
        $stillMissing += $pkg.Name
    }
}

Write-Host ''

if ($stillMissing.Count -gt 0) {
    Write-Host 'Some items are not visible in this window yet.' -ForegroundColor Yellow
    Write-Host 'Close this terminal, open a new one, and run this script again to confirm.'
}
else {
    Write-Host 'All set. Build the report with:  .\scripts\build.ps1 tb1' -ForegroundColor Green
}

Write-Host ''

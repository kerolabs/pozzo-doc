$ErrorActionPreference = 'Stop'

$env:Path = [System.Environment]::GetEnvironmentVariable('Path', 'Machine') +
            ';' +
            [System.Environment]::GetEnvironmentVariable('Path', 'User')

$dependencies = @(
    [pscustomobject]@{
        Name     = 'Pandoc'
        Command  = 'pandoc'
        WingetId = 'JohnMacFarlane.Pandoc'
        Purpose  = 'converts Markdown to a Word document'
        Size     = '~150 MB'
    }
)

function Test-Dependency {
    param([string]$Command)
    $found = Get-Command $Command -ErrorAction SilentlyContinue
    if ($null -eq $found) { return $null }
    return $found.Source
}

# Word no se instala desde aqui: viene con Microsoft 365. Sin el, el build igual
# genera el .docx, pero no puede llenar el indice ni exportar el PDF.
function Test-Word {
    try {
        $word = New-Object -ComObject Word.Application -ErrorAction Stop
        $word.Quit()
        [System.Runtime.InteropServices.Marshal]::ReleaseComObject($word) | Out-Null
        return $true
    }
    catch {
        return $false
    }
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

if (Test-Word) {
    Write-Host '  [OK]      Microsoft Word is installed' -ForegroundColor Green
}
else {
    Write-Host '  [MISSING] Microsoft Word - fills in the table of contents and exports the PDF' -ForegroundColor Yellow
    Write-Host '            Install it with Microsoft 365. Without it the build still writes the .docx.' -ForegroundColor DarkGray
}

Write-Host ''

if ($missingTools.Count -eq 0) {
    Write-Host 'Pandoc is installed. Nothing to do.' -ForegroundColor Green
    Write-Host 'You can build the report with:  .\scripts\build.ps1 tb1'
    Write-Host ''
    exit 0
}

if ($null -eq (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host 'winget is not available on this machine, so this script cannot install anything.' -ForegroundColor Red
    Write-Host 'Install Pandoc manually:  https://pandoc.org/installing.html'
    Write-Host ''
    exit 1
}

Write-Host 'The following needs to be installed:'
Write-Host ''
foreach ($dep in $missingTools) { Write-Host ('  - {0}  ({1})' -f $dep.Name, $dep.Size) }
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

if ($null -ne (Test-Dependency -Command 'pandoc')) {
    Write-Host 'All set. Build the report with:  .\scripts\build.ps1 tb1' -ForegroundColor Green
}
else {
    Write-Host 'Pandoc is not visible in this window yet.' -ForegroundColor Yellow
    Write-Host 'Close this terminal, open a new one, and run this script again to confirm.'
}

Write-Host ''

param(
    [string]$Repository
)

$ErrorActionPreference = 'Stop'

$Branches = @('main', 'develop')
$RequiredCheck = 'no-ai-authorship'

function Show-Usage {
    Write-Host ''
    Write-Host 'Usage:  .\scripts\protect.ps1 <owner/repo>' -ForegroundColor Yellow
    Write-Host ''
    Write-Host '  Applies branch protection to main and develop:'
    Write-Host ('    - the "{0}" status check must pass' -f $RequiredCheck)
    Write-Host '    - no direct pushes, no force pushes, no branch deletion'
    Write-Host '    - the rules apply to admins too'
    Write-Host ''
    Write-Host '  Example:  .\scripts\protect.ps1 my-org/my-report'
    Write-Host ''
    Write-Host '  Branch protection is repository settings, not repository content,'
    Write-Host '  so it is not copied when you create a new repo from this one.'
    Write-Host ''
}

if ([string]::IsNullOrWhiteSpace($Repository)) {
    Write-Host ''
    Write-Host 'ERROR: no repository given.' -ForegroundColor Red
    Show-Usage
    exit 1
}

$Repository = $Repository.Trim()

if ($Repository -notmatch '^[^/\s]+/[^/\s]+$') {
    Write-Host ''
    Write-Host ("ERROR: '{0}' is not in owner/repo format." -f $Repository) -ForegroundColor Red
    Show-Usage
    exit 1
}

$env:Path = [System.Environment]::GetEnvironmentVariable('Path', 'Machine') +
            ';' +
            [System.Environment]::GetEnvironmentVariable('Path', 'User')

if ($null -eq (Get-Command gh -ErrorAction SilentlyContinue)) {
    Write-Host ''
    Write-Host 'ERROR: the GitHub CLI (gh) is not installed.' -ForegroundColor Red
    Write-Host 'Install it with:  winget install GitHub.cli'
    Write-Host ''
    exit 1
}

gh auth status 2>&1 | Out-Null
if ($LASTEXITCODE -ne 0) {
    Write-Host ''
    Write-Host 'ERROR: the GitHub CLI is not authenticated.' -ForegroundColor Red
    Write-Host 'Run:  gh auth login'
    Write-Host ''
    exit 1
}

$rules = @{
    required_status_checks = @{
        strict   = $false
        contexts = @($RequiredCheck)
    }
    enforce_admins                = $true
    required_pull_request_reviews = $null
    restrictions                  = $null
    allow_force_pushes            = $false
    allow_deletions               = $false
}

$payload = $rules | ConvertTo-Json -Depth 5
$payloadFile = Join-Path ([System.IO.Path]::GetTempPath()) 'branch-protection.json'

# Sin BOM: gh no puede parsear el JSON si el archivo lo lleva.
[System.IO.File]::WriteAllText($payloadFile, $payload, (New-Object System.Text.UTF8Encoding($false)))

Write-Host ''
Write-Host ('Protecting branches on {0}...' -f $Repository) -ForegroundColor Cyan
Write-Host ''

$failed = @()

foreach ($branch in $Branches) {
    Write-Host ('  {0} ... ' -f $branch) -NoNewline

    gh api -X PUT "repos/$Repository/branches/$branch/protection" `
        -H 'Accept: application/vnd.github+json' `
        --input $payloadFile | Out-Null

    if ($LASTEXITCODE -eq 0) {
        Write-Host 'protected' -ForegroundColor Green
    }
    else {
        Write-Host 'failed' -ForegroundColor Red
        $failed += $branch
    }
}

Remove-Item $payloadFile -ErrorAction SilentlyContinue

Write-Host ''

if ($failed.Count -gt 0) {
    Write-Host ('Could not protect: {0}' -f ($failed -join ', ')) -ForegroundColor Red
    Write-Host ''
    Write-Host 'Common causes:'
    Write-Host '  - the branch does not exist yet on the remote'
    Write-Host ('  - the "{0}" check has never run, so GitHub does not know it' -f $RequiredCheck)
    Write-Host '  - your account is not an admin of the repository'
    Write-Host ''
    exit 1
}

Write-Host 'Done. Direct pushes to these branches are now rejected.' -ForegroundColor Green
Write-Host ''

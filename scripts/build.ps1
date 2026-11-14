param(
    [string]$Delivery
)

$ErrorActionPreference = 'Stop'

$Period     = '202620'
$CourseCode = '1acc0238'
$Nrc        = '13980'
$Startup    = 'Kerolabs'

$Deliveries = @('av1', 'tb1', 'av2', 'tb2')

$ChaptersByDelivery = @{
    'av1' = @(
        'README.md'
        'docs/chapter_1.md'
        'docs/chapter_2.md'
        'docs/closing.md'
    )
    'tb1' = @(
        'README.md'
        'docs/chapter_1.md'
        'docs/chapter_2.md'
        'docs/chapter_3.md'
        'docs/chapter_4.md'
        'docs/closing.md'
    )
    'av2' = @(
        'README.md'
        'docs/chapter_1.md'
        'docs/chapter_2.md'
        'docs/chapter_3.md'
        'docs/chapter_4.md'
        'docs/closing.md'
    )
    'tb2' = @(
        'README.md'
        'docs/chapter_1.md'
        'docs/chapter_2.md'
        'docs/chapter_3.md'
        'docs/chapter_4.md'
        'docs/closing.md'
    )
}

$ConfigFiles = @(
    'config/format.yaml'
    'config/html-tables.lua'
    'config/pdf-only.lua'
    'config/bib-categories.lua'
    'config/docx.lua'
    'config/apa.csl'
    'config/reference.docx'
    'references.bib'
)

function Show-Usage {
    Write-Host ''
    Write-Host 'Usage:  .\scripts\build.ps1 <delivery>' -ForegroundColor Yellow
    Write-Host ''
    Write-Host ('  <delivery> must be one of: {0}' -f ($Deliveries -join ', '))
    Write-Host '  It becomes the last part of the file names.'
    Write-Host ''
    Write-Host '  Builds the report as a Word document. If Microsoft Word is installed,'
    Write-Host '  it also fills in the table of contents and exports the PDF from Word.'
    Write-Host ''
    Write-Host '  Example:  .\scripts\build.ps1 tb1'
    Write-Host ('  Produces: upc-pre-{0}-{1}-{2}-{3}-report-tb1.docx (and .pdf)' -f $Period, $CourseCode, $Nrc, $Startup)
    Write-Host ''
}

if ([string]::IsNullOrWhiteSpace($Delivery)) {
    Write-Host ''
    Write-Host 'ERROR: no delivery given.' -ForegroundColor Red
    Show-Usage
    exit 1
}

$Delivery = $Delivery.Trim().ToLower()

if ($Deliveries -notcontains $Delivery) {
    Write-Host ''
    Write-Host ("ERROR: '{0}' is not a valid delivery." -f $Delivery) -ForegroundColor Red
    Show-Usage
    exit 1
}

$Chapters = $ChaptersByDelivery[$Delivery]

$repo = Split-Path $PSScriptRoot -Parent
Set-Location $repo

$OnWindows = ($null -eq $IsWindows) -or $IsWindows

if ($OnWindows) {
    $env:Path = [System.Environment]::GetEnvironmentVariable('Path', 'Machine') +
                ';' +
                [System.Environment]::GetEnvironmentVariable('Path', 'User')
    $ResourcePath = '.;docs'
}
else {
    $ResourcePath = '.:docs'
}

if ($null -eq (Get-Command pandoc -ErrorAction SilentlyContinue)) {
    Write-Host ''
    Write-Host 'ERROR: pandoc is not installed.' -ForegroundColor Red
    Write-Host 'Run this first:  .\scripts\dependencies.ps1'
    Write-Host ''
    exit 1
}

$missing = @()
foreach ($file in ($Chapters + $ConfigFiles)) {
    if (-not (Test-Path $file)) { $missing += $file }
}

if ($missing.Count -gt 0) {
    Write-Host ''
    Write-Host 'ERROR: these files are missing:' -ForegroundColor Red
    foreach ($file in $missing) { Write-Host ('  - {0}' -f $file) }
    Write-Host ''
    exit 1
}

# Los [[PENDIENTE: ...]] marcan huecos que hay que rellenar antes de entregar.
# Se compila igual, porque el documento sirve para revisar el avance, pero el aviso
# sale en cada build para que ninguno llegue a la entrega sin que nadie lo vea.
$pending = Select-String -Path $Chapters -Pattern '\[\[PENDIENTE' -ErrorAction SilentlyContinue

if ($pending) {
    Write-Host ''
    Write-Host ('AVISO: {0} marcador(es) PENDIENTE sin rellenar.' -f $pending.Count) -ForegroundColor Yellow
    foreach ($hit in $pending) {
        Write-Host ('  {0}:{1}' -f $hit.Path.Replace((Get-Location).Path + '\', ''), $hit.LineNumber) -ForegroundColor DarkYellow
    }
    Write-Host '  El documento se genera igual, pero no lo entregues asi.' -ForegroundColor DarkYellow
}

if (-not (Test-Path 'dist')) { New-Item -ItemType Directory 'dist' | Out-Null }

$docx = "dist/upc-pre-$Period-$CourseCode-$Nrc-$Startup-report-$Delivery.docx"

# Los estilos APA 7 vienen de config/reference.docx (lo genera
# scripts/reference-docx.py) y config/docx.lua arma la caratula, el indice, los
# rotulos de tablas y figuras y los titulos de cuarto y quinto nivel. Las tablas
# HTML pasan por html-tables.lua, y pdf-only.lua decide que partes del README
# entran al documento.

Write-Host ''
Write-Host ('Building {0} from {1} files...' -f $Delivery, $Chapters.Count) -ForegroundColor Cyan
foreach ($file in $Chapters) { Write-Host ('  {0}' -f $file) -ForegroundColor DarkGray }
Write-Host ''

$ErrorActionPreference = 'Continue'
pandoc $Chapters `
    --from=markdown-yaml_metadata_block `
    --metadata-file=config/format.yaml `
    "--metadata=entrega:$Delivery" `
    --reference-doc=config/reference.docx `
    --lua-filter=config/html-tables.lua `
    --lua-filter=config/pdf-only.lua `
    --citeproc `
    --lua-filter=config/bib-categories.lua `
    --lua-filter=config/docx.lua `
    --csl=config/apa.csl `
    --bibliography=references.bib `
    "--resource-path=$ResourcePath" `
    --syntax-highlighting=tango `
    -o $docx
$ErrorActionPreference = 'Stop'

if ($LASTEXITCODE -ne 0) {
    Write-Host ''
    Write-Host 'Build failed. Read the pandoc error above.' -ForegroundColor Red
    Write-Host ''
    exit 1
}

Write-Host ('Done -> {0}  ({1} KB)' -f $docx, [math]::Round((Get-Item $docx).Length / 1KB)) -ForegroundColor Green

# Pandoc deja el indice como un campo vacio: solo Word sabe en que pagina
# cae cada titulo. Si Word esta instalado, se abre el documento, se
# actualizan los campos, se guarda y se exporta el PDF desde Word.
$wordApp = $null
try { $wordApp = New-Object -ComObject Word.Application -ErrorAction Stop } catch {}

if ($null -eq $wordApp) {
    Write-Host ''
    Write-Host 'Microsoft Word not found: the table of contents stays empty until you' -ForegroundColor Yellow
    Write-Host 'open the .docx and update it (right-click > Update Field).' -ForegroundColor Yellow
    Write-Host ''
    exit 0
}

$docxPath = (Resolve-Path $docx).Path
$pdfPath = [System.IO.Path]::ChangeExtension($docxPath, '.pdf')

# Word a veces rechaza una llamada ("Command failed") mientras termina de
# cerrarse la instancia anterior; un segundo intento con otra instancia pasa.
for ($attempt = 1; $attempt -le 2; $attempt++) {
    if ($null -eq $wordApp) { $wordApp = New-Object -ComObject Word.Application }
    try {
        $wordApp.Visible = $false
        $wordApp.DisplayAlerts = 0
        $document = $wordApp.Documents.Open($docxPath)
        foreach ($toc in $document.TablesOfContents) { $toc.Update() }
        $document.Fields.Update() | Out-Null
        $document.Save()
        # 17 = wdFormatPDF. ExportAsFixedFormat no falla pero tampoco escribe
        # nada cuando se llama desde PowerShell; SaveAs2 si exporta.
        $document.SaveAs2([ref]$pdfPath, [ref]17)
        $document.Close([ref]$false)
        $attempt = 3
    }
    catch {
        if ($attempt -ge 2) { throw }
        Write-Host ('Word failed ({0}); retrying...' -f $_.Exception.Message) -ForegroundColor Yellow
    }
    finally {
        $wordApp.Quit()
        [System.Runtime.InteropServices.Marshal]::ReleaseComObject($wordApp) | Out-Null
        $wordApp = $null
    }
}

Write-Host ('Done -> {0}  ({1} KB)' -f $pdfPath, [math]::Round((Get-Item $pdfPath).Length / 1KB)) -ForegroundColor Green
Write-Host ''

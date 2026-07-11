<#
  Download Kie.ai result images (from generate.py's results.json) to a folder.
  Runs on the user's machine (locally, or via the Desktop Commander MCP) because
  the sandbox is firewalled off the image CDN.

  Usage:
    powershell -NoProfile -ExecutionPolicy Bypass -File download_images.ps1 `
      -ResultsJson "C:\path\results.json" -OutDir "C:\path\out" [-Ext jpg]

  Accepts either shape:
    { "name": "https://.../image.png", ... }              (approved map, one URL)
    { "name": ["https://.../a.png", "https://.../b.png"] } (raw results, a list)
  One URL  -> saved as <name>.<Ext>.
  Several  -> saved as <name>-1.<Ext>, <name>-2.<Ext>, ...
  Best practice: preview first and pass an approved map with one URL per name.
#>
param(
  [Parameter(Mandatory = $true)][string]$ResultsJson,
  [Parameter(Mandatory = $true)][string]$OutDir,
  [string]$Ext = "jpg"
)

$ErrorActionPreference = "Stop"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

if (-not (Test-Path $ResultsJson)) { Write-Host "results.json not found: $ResultsJson"; exit 1 }
New-Item -ItemType Directory -Force -Path $OutDir | Out-Null

$map = Get-Content -Raw -Path $ResultsJson | ConvertFrom-Json
$ok = 0; $total = 0
foreach ($p in $map.PSObject.Properties) {
  $urls = @($p.Value)   # normalize: string -> 1-element array; array stays
  $single = $urls.Count -le 1
  for ($i = 0; $i -lt $urls.Count; $i++) {
    $total++
    $fname = if ($single) { $p.Name } else { "$($p.Name)-$($i + 1)" }
    $dest = Join-Path $OutDir ($fname + "." + $Ext)
    try {
      Invoke-WebRequest -Uri $urls[$i] -OutFile $dest -UseBasicParsing
      Write-Host ("  [OK]  {0}.{1}" -f $fname, $Ext) -ForegroundColor Green
      $ok++
    } catch {
      Write-Host ("  [FAIL] {0} : {1}" -f $fname, $_.Exception.Message) -ForegroundColor Red
    }
  }
}
Write-Host ""
Write-Host "$ok of $total downloaded to $OutDir" -ForegroundColor Cyan

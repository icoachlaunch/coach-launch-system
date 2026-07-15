# =====================================================================
#  Coach Launch - Download the six agent headshots into assets/agents images/
#  These are the exact photos generated on 2026-07-11 (Kie.ai nano-banana).
#  No API key needed. Right-click this file -> Run with PowerShell.
#  NOTE: the source links are temporary - run this soon. If a link has
#  expired, use generate_agent_photos.ps1 instead to make fresh ones.
# =====================================================================

$ErrorActionPreference = 'Stop'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# repo root = this script's parent folder
$root   = Split-Path -Parent $PSScriptRoot
$outDir = Join-Path $root 'assets\agents images'
if (-not (Test-Path $outDir)) { New-Item -ItemType Directory -Path $outDir | Out-Null }

$photos = [ordered]@{
  'maya'   = 'https://tempfile.aiquickdraw.com/p/ed4d6cdaad8f9182fad5e0b6eff70a98_1_1783731561_6585.png'
  'leo'    = 'https://tempfile.aiquickdraw.com/p/0ad8268d4b58ee7461d3c53fb5494583_1_1783731562_3225.png'
  'sofia'  = 'https://tempfile.aiquickdraw.com/p/0181e38c13c73f3fdc3115ec87bfe768_1_1783731569_9571.png'
  'marcus' = 'https://tempfile.aiquickdraw.com/p/2f19248af34a89faf29ffefa7c6b9cb0_1_1783731563_8477.png'
  'priya'  = 'https://tempfile.aiquickdraw.com/p/519d77ee62db421ed19ae52d6b014de3_1_1783731564_1866.png'
  'jack'   = 'https://tempfile.aiquickdraw.com/p/4dad4af812158f734caf112af2109565_1_1783731564_9100.png'
}

Write-Host "Saving 6 agent photos to: $outDir" -ForegroundColor Cyan
$ok = 0
foreach ($name in $photos.Keys) {
  $dest = Join-Path $outDir "$name.jpg"
  try {
    Invoke-WebRequest -Uri $photos[$name] -OutFile $dest -UseBasicParsing
    Write-Host ("  [OK]  {0,-7} -> {1}" -f $name, "$name.jpg") -ForegroundColor Green
    $ok++
  } catch {
    Write-Host ("  [FAIL] {0,-7} : {1}" -f $name, $_.Exception.Message) -ForegroundColor Red
  }
}
Write-Host ""
Write-Host "$ok of 6 downloaded. Refresh dashboard.html to see them." -ForegroundColor Cyan
Read-Host "Press Enter to close"

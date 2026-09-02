# kie_generate.ps1 - generate images via the Kie.ai jobs API and download them locally.
#
# WHY THIS EXISTS: the global kie-image-gen skill generates with scripts/generate.py, and this
# host has no real Python (MS-Store stub only). This is the PowerShell equivalent. It also
# collapses the skill's two-machine flow (generate in sandbox -> download via Desktop Commander)
# into one pass, because api.kie.ai AND the image CDN are both reachable from this machine.
#
# THE KEY IS NEVER WRITTEN ANYWHERE. It is read from a file outside the repo at run time and
# held in memory only. Default: %USERPROFILE%\.kie_key  (one line, the key, nothing else).
# Never pass it on the command line - that puts it in shell history.
#
# USAGE
#   powershell -File scripts/kie_generate.ps1 -Spec <spec.json> -OutDir <folder> [-KeyFile <path>] [-DryRun]
#
# SPEC FORMAT (same shape as the skill's spec.example.json)
#   {
#     "model": "google/nano-banana",
#     "aspect_ratio": "16:9",
#     "images": [ { "name": "hero-stage", "prompt": "...", "aspect_ratio": "16:9" } ]
#   }
#   Per-image aspect_ratio overrides the global one. Names become filenames.
#
# NOTE ON REVIEW: this script downloads everything it generates. Look at the files before you
# use them - an image that reads fine as a thumbnail can fall apart at 1600x900 on a projector.

[CmdletBinding()]
param(
  [Parameter(Mandatory=$true)][string]$Spec,
  [Parameter(Mandatory=$true)][string]$OutDir,
  [string]$KeyFile = (Join-Path $env:USERPROFILE '.kie_key'),
  [int]$TimeoutSec = 300,
  [switch]$DryRun
)

$ErrorActionPreference = 'Stop'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

if (-not (Test-Path $Spec))   { throw "Spec not found: $Spec" }
$specObj = [IO.File]::ReadAllText($Spec) | ConvertFrom-Json
$model   = if ($specObj.model) { $specObj.model } else { 'google/nano-banana' }
$defAR   = if ($specObj.aspect_ratio) { $specObj.aspect_ratio } else { '16:9' }
if (-not $specObj.images -or $specObj.images.Count -eq 0) { throw 'Spec has no images.' }

Write-Output ("model        : $model")
Write-Output ("images       : " + $specObj.images.Count)
Write-Output ("destination  : $OutDir")

if ($DryRun) {
  Write-Output ''
  Write-Output '--- DRY RUN: prompts that would be submitted ---'
  foreach ($img in $specObj.images) {
    $ar = if ($img.aspect_ratio) { $img.aspect_ratio } else { $defAR }
    Write-Output ("[{0}]  ({1})" -f $img.name, $ar)
    Write-Output ("    " + $img.prompt)
  }
  Write-Output '--- no API calls made, no key read ---'
  return
}

if (-not (Test-Path $KeyFile)) {
  throw "No key file at $KeyFile. Save your Kie.ai API key there as a single line. Do NOT put it in the repo or on the command line."
}
$key = ([IO.File]::ReadAllText($KeyFile)).Trim()
if ([string]::IsNullOrWhiteSpace($key)) { throw "Key file $KeyFile is empty." }
$headers = @{ 'Authorization' = "Bearer $key"; 'Content-Type' = 'application/json' }

New-Item -ItemType Directory -Force -Path $OutDir | Out-Null

# ---- submit ----
$jobs = @()
foreach ($img in $specObj.images) {
  $ar = if ($img.aspect_ratio) { $img.aspect_ratio } else { $defAR }
  $body = @{ model = $model; input = @{ prompt = $img.prompt; aspect_ratio = $ar } } | ConvertTo-Json -Depth 6 -Compress
  try {
    $r = Invoke-RestMethod -Uri 'https://api.kie.ai/api/v1/jobs/createTask' -Method POST -Headers $headers -Body $body -TimeoutSec 60
  } catch {
    Write-Output ("  SUBMIT FAILED [{0}]: {1}" -f $img.name, $_.Exception.Message); continue
  }
  if ($r.code -ne 200) { Write-Output ("  SUBMIT REJECTED [{0}]: code {1} - {2}" -f $img.name, $r.code, $r.msg); continue }
  $jobs += [pscustomobject]@{ name = $img.name; taskId = $r.data.taskId; state = 'submitted'; url = $null }
  Write-Output ("  submitted   {0}  ->  {1}" -f $img.name, $r.data.taskId)
}
if ($jobs.Count -eq 0) { throw 'Nothing submitted.' }

# ---- poll ----
Write-Output ''
Write-Output 'polling...'
$deadline = (Get-Date).AddSeconds($TimeoutSec)
while ((Get-Date) -lt $deadline) {
  $pending = @($jobs | Where-Object { $_.state -notin @('success','fail') })
  if ($pending.Count -eq 0) { break }
  Start-Sleep -Seconds 5
  foreach ($j in $pending) {
    try {
      $r = Invoke-RestMethod -Uri ("https://api.kie.ai/api/v1/jobs/recordInfo?taskId=" + $j.taskId) -Method GET -Headers $headers -TimeoutSec 30
    } catch { continue }
    $st = $r.data.state
    if ($st -eq 'success') {
      $j.state = 'success'
      try { $j.url = ($r.data.resultJson | ConvertFrom-Json).resultUrls[0] } catch { $j.state = 'fail' }
      Write-Output ("  done        " + $j.name)
    } elseif ($st -eq 'fail') {
      $j.state = 'fail'
      Write-Output ("  FAILED      {0}: {1}" -f $j.name, $r.data.failMsg)
    }
  }
}

# ---- download ----
Write-Output ''
$ok = 0; $bad = 0
foreach ($j in $jobs) {
  if ($j.state -ne 'success' -or -not $j.url) { $bad++; continue }
  $ext = [IO.Path]::GetExtension(($j.url -split '\?')[0]); if (-not $ext) { $ext = '.png' }
  $dest = Join-Path $OutDir ($j.name + $ext)
  try {
    Invoke-WebRequest -Uri $j.url -OutFile $dest -TimeoutSec 120 -UseBasicParsing
    $size = (Get-Item $dest).Length
    # a few bytes means an error page, not an image
    if ($size -lt 10240) { Write-Output ("  SUSPECT     {0} is only {1} bytes - check it" -f $j.name, $size); $bad++ }
    else { Write-Output ("  saved       {0}  ({1} KB)" -f (Split-Path $dest -Leaf), [math]::Round($size/1KB,1)); $ok++ }
  } catch {
    Write-Output ("  DOWNLOAD FAILED {0}: {1}" -f $j.name, $_.Exception.Message); $bad++
  }
}

Write-Output ''
Write-Output ("saved: $ok   failed/suspect: $bad")
$key = $null
if ($bad -gt 0) { Write-Output 'Some images did not land. Re-run with a spec containing only those names.' }

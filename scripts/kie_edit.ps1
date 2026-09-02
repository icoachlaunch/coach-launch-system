# kie_edit.ps1 - image-to-image editing via Kie.ai (google/nano-banana-edit).
#
# Uploads a LOCAL image to Kie's own file host, gets a downloadUrl, runs the edit model
# against it, and downloads the result. Three steps in one command.
#
# WHY THE UPLOAD STEP: nano-banana-edit takes `image_urls` and fetches them. It rejects
# base64 data URIs ("image_urls file type not supported"). Kie exposes its own upload
# endpoint, so the image goes to the service doing the work rather than being published
# anywhere public.
#
# THE KEY IS NEVER WRITTEN ANYWHERE. Read at run time from a file outside the repo,
# held in memory, nulled after. Never passed on the command line.
#
# USAGE
#   powershell -File scripts/kie_edit.ps1 -In <image> -Out <image> -Prompt "..." [-KeyFile <path>]
#
# ON EDITING PHOTOGRAPHS OF REAL PEOPLE
#   This model regenerates the image; it does not retouch it. Faces come back subtly
#   changed - jawline, eyes, skin. For a founder slide, where the room meets the person
#   afterwards, that is a real cost. Prefer a crop and a background key on the original
#   wherever it will do. If you do run it, say "preserve the exact facial features" in
#   the prompt and compare the result against the original at full size before using it.

[CmdletBinding()]
param(
  [Parameter(Mandatory=$true)][string]$In,
  [Parameter(Mandatory=$true)][string]$Out,
  [Parameter(Mandatory=$true)][string]$Prompt,
  [string]$KeyFile = (Join-Path $env:USERPROFILE '.kie_key.txt'),
  [string]$Model = 'google/nano-banana-edit',
  [string]$AspectRatio = '',
  [int]$TimeoutSec = 300
)

$ErrorActionPreference = 'Stop'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

if (-not (Test-Path $In)) { throw "Input image not found: $In" }
if (-not (Test-Path $KeyFile)) { throw "No key file at $KeyFile" }
$key = ([IO.File]::ReadAllText($KeyFile)).Trim()
if ([string]::IsNullOrWhiteSpace($key)) { throw "Key file is empty: $KeyFile" }
$headers = @{ 'Authorization' = "Bearer $key"; 'Content-Type' = 'application/json' }

$srcInfo = Get-Item $In
Write-Output ("input   : " + $srcInfo.Name + "  (" + [math]::Round($srcInfo.Length/1KB,0) + " KB)")

# ---- 1. upload ----
$ext  = ([IO.Path]::GetExtension($In)).TrimStart('.').ToLower()
$mime = if ($ext -eq 'jpg' -or $ext -eq 'jpeg') { 'image/jpeg' } elseif ($ext -eq 'webp') { 'image/webp' } else { 'image/png' }
$b64  = [Convert]::ToBase64String([IO.File]::ReadAllBytes($In))
$upBody = @{
  base64Data = "data:$mime;base64,$b64"
  uploadPath = 'images/user-uploads'
  fileName   = $srcInfo.Name
} | ConvertTo-Json -Depth 4 -Compress

$up = Invoke-RestMethod -Uri 'https://kieai.redpandaai.co/api/file-base64-upload' -Method POST -Headers $headers -Body $upBody -TimeoutSec 120
if (-not $up.success) { throw ("Upload failed: " + ($up | ConvertTo-Json -Depth 4 -Compress)) }
$srcUrl = $up.data.downloadUrl
Write-Output ("uploaded: " + $srcUrl)

# ---- 2. submit the edit ----
$input = @{ prompt = $Prompt; image_urls = @($srcUrl) }
if ($AspectRatio) { $input.aspect_ratio = $AspectRatio }
$taskBody = @{ model = $Model; input = $input } | ConvertTo-Json -Depth 6 -Compress
$task = Invoke-RestMethod -Uri 'https://api.kie.ai/api/v1/jobs/createTask' -Method POST -Headers $headers -Body $taskBody -TimeoutSec 60
if ($task.code -ne 200) { throw ("Submit rejected: code " + $task.code + " - " + $task.msg) }
$taskId = $task.data.taskId
Write-Output ("task    : $taskId")

# ---- 3. poll ----
$deadline = (Get-Date).AddSeconds($TimeoutSec)
$state = 'waiting'; $url = $null
while ((Get-Date) -lt $deadline) {
  Start-Sleep -Seconds 5
  try { $r = Invoke-RestMethod -Uri ("https://api.kie.ai/api/v1/jobs/recordInfo?taskId=$taskId") -Method GET -Headers $headers -TimeoutSec 30 }
  catch { continue }
  $state = $r.data.state
  if ($state -eq 'success') { $url = ($r.data.resultJson | ConvertFrom-Json).resultUrls[0]; break }
  if ($state -eq 'fail')    { throw ("Generation failed: " + $r.data.failMsg) }
}
if (-not $url) { throw "Timed out after $TimeoutSec seconds (last state: $state)" }

# ---- 4. download ----
Invoke-WebRequest -Uri $url -OutFile $Out -TimeoutSec 180 -UseBasicParsing
$size = (Get-Item $Out).Length
if ($size -lt 10240) { Write-Output ("WARNING: output is only $size bytes - check it, that may be an error page") }
Write-Output ("output  : " + (Split-Path $Out -Leaf) + "  (" + [math]::Round($size/1KB,0) + " KB)")
Write-Output ""
Write-Output "Compare it against the original at full size before you use it."
$key = $null

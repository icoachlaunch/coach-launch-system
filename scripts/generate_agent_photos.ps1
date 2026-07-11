<#
  Coach Launch — Agent Headshot Generator (Kie.ai)
  --------------------------------------------------
  Generates FRESH versions of the 6 agent profile photos and saves them into
  ..\assets\agents\ so the Training Portal (dashboard.html) picks them up.

  Use this if you want to regenerate the team (new faces) or if the quick
  download_agent_photos.ps1 links have expired.

  HOW TO RUN (Windows):
    1. Open the "scripts" folder in File Explorer.
    2. Right-click this file  ->  "Run with PowerShell".
       (If blocked, open PowerShell and run:
          powershell -ExecutionPolicy Bypass -File "generate_agent_photos.ps1")
    3. Paste your Kie.ai API key when asked.
    4. Wait ~1 min. Six .jpg files appear in assets\agents\. Refresh the dashboard.

  Model: google/nano-banana (imagen4 was returning 500s as of 2026-07-11).
  Your API key is NOT stored — it is only held in memory while the script runs.
#>

$ErrorActionPreference = "Stop"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$key = Read-Host "Paste your Kie.ai API key"
if ([string]::IsNullOrWhiteSpace($key)) { Write-Host "No key entered. Exiting."; exit 1 }

$base   = "https://api.kie.ai"
$outDir = Join-Path $PSScriptRoot "..\assets\agents"
New-Item -ItemType Directory -Force -Path $outDir | Out-Null

# Shared studio style — keeps all six a matched set.
$style = "Professional corporate studio headshot, photorealistic, soft even studio lighting, clean seamless light-gray background with a subtle warm pink tint, shallow depth of field, sharp focus on the face, friendly approachable expression, looking directly at camera, centered square composition, head and shoulders, high detail, natural skin texture, no text, no watermark."

# name -> subject description (matches each agent's character)
$subjects = [ordered]@{
  maya   = "A warm, friendly woman in her late 20s with a confident natural smile, shoulder-length dark wavy hair, wearing a business-casual blazer."
  leo    = "A friendly man in his early 30s with an easy smile, short brown hair and light stubble, wearing a smart casual button-down shirt."
  sofia  = "A confident, poised woman in her mid 30s with straight shoulder-length brown hair, wearing a professional blouse and blazer."
  marcus = "A sharp, focused man in his late 30s with a slight confident smile, short dark hair and a neatly groomed beard, wearing a dark blazer over a shirt."
  priya  = "A warm, intelligent South Asian woman in her early 30s with a friendly smile, long dark hair and subtle thin-framed glasses, wearing an elegant professional blouse."
  jack   = "An approachable man in his 40s with a warm smile, short salt-and-pepper hair, clean-shaven, wearing a smart casual shirt."
}

$authHeader = @{ Authorization = "Bearer $key" }

foreach ($name in $subjects.Keys) {
  Write-Host ""
  Write-Host "[$name] requesting image..."
  $bodyObj = @{
    model = "google/nano-banana"
    input = @{
      prompt       = "$($subjects[$name]) $style"
      aspect_ratio = "1:1"
    }
  }
  $body = $bodyObj | ConvertTo-Json -Depth 8
  $create = Invoke-RestMethod -Uri "$base/api/v1/jobs/createTask" -Method Post -Headers $authHeader -ContentType "application/json" -Body $body
  $taskId = $create.data.taskId
  if (-not $taskId) { Write-Host "  ! No task id returned: $($create | ConvertTo-Json -Depth 5)"; continue }

  $url = $null
  for ($i = 0; $i -lt 60; $i++) {
    Start-Sleep -Seconds 4
    $q = Invoke-RestMethod -Uri "$base/api/v1/jobs/recordInfo?taskId=$taskId" -Method Get -Headers $authHeader
    switch ($q.data.state) {
      "success" { $url = ($q.data.resultJson | ConvertFrom-Json).resultUrls[0]; break }
      "fail"    { throw "[$name] generation failed: $($q.data.failMsg)" }
      default   { Write-Host "  ...$($q.data.state)" }
    }
    if ($url) { break }
  }
  if (-not $url) { Write-Host "  ! [$name] timed out — skipping."; continue }

  $dest = Join-Path $outDir "$name.jpg"
  Invoke-WebRequest -Uri $url -OutFile $dest -UseBasicParsing
  Write-Host "  saved -> assets\agents\$name.jpg"
}

Write-Host ""
Write-Host "Done. Open (or refresh) dashboard.html to see the team photos."
Read-Host "Press Enter to close"

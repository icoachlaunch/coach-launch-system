$u = "https://icoachlaunch.github.io/coach-launch-system/skills/presentation-engine/SKILL.md"
Start-Sleep -Seconds 20
try {
  $r = Invoke-WebRequest -Uri $u -UseBasicParsing -TimeoutSec 25
  Write-Output ("SKILL " + $r.StatusCode + " bytes=" + $r.Content.Length)
} catch {
  $resp = $_.Exception.Response
  if ($resp) { Write-Output ("SKILL http " + [int]$resp.StatusCode) } else { Write-Output ("SKILL error " + $_.Exception.Message) }
}
Remove-Item -Force -ErrorAction SilentlyContinue "scripts\_chk2.ps1"

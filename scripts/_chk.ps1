$base = "https://icoachlaunch.github.io/coach-launch-system/"
$paths = @("dashboard.html","skills/presentation-engine/SKILL.md","slide-viewer.html","guides/presentation-engine-guide.html")
Start-Sleep -Seconds 6
foreach ($p in $paths) {
  try { $r = Invoke-WebRequest -Uri ($base + $p) -Method Head -UseBasicParsing -TimeoutSec 20; Write-Output ($r.StatusCode.ToString() + "  " + $p) }
  catch { Write-Output ((($_.Exception.Response.StatusCode.value__)) + "  " + $p + "  (not live yet)") }
}
Remove-Item -Force -ErrorAction SilentlyContinue "scripts\_chk.ps1"

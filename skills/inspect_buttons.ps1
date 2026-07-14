$ErrorActionPreference = "Stop"
$p = "C:\Users\Focus Account\Documents\Coach Launch Builder Prompts\dashboard.html"
$utf8 = New-Object System.Text.UTF8Encoding($false)
$html = [System.IO.File]::ReadAllText($p, $utf8)
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host "=== label counts ==="
foreach ($lbl in @('Open','Download','Copy prompt','Copy','Download .md','Download guide','data-copy','data-dl','data-guide')) {
  $c = ([regex]::Matches($html, [regex]::Escape($lbl))).Count
  Write-Host ("  {0,-16} {1}" -f $lbl, $c)
}
Write-Host ""
Write-Host "=== slice around first data-copy button ==="
$i = $html.IndexOf('data-copy')
if ($i -ge 0) { Write-Host $html.Substring([Math]::Max(0, $i - 900), 1400) }

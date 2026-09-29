# set_portal_code.ps1 - set (or rotate) the Training Portal access code.
#
# USAGE
#   powershell -File scripts/set_portal_code.ps1                 # picks a random 6-digit code and prints it
#   powershell -File scripts/set_portal_code.ps1 -Code 123456    # uses the code you give (6 to 12 digits)
#   powershell -File scripts/set_portal_code.ps1 -Verify 123456  # tells you if a code matches, changes nothing
#
# WHAT IT DOES: derives a PBKDF2-SHA256 hash of the code with a fresh random salt and stamps
# salt + hash + iterations + digit count into assets/gate.js. The code itself is printed to the
# console ONCE and written nowhere. The repo is public - never put the code in any file.
# Rotating the code signs every remembered browser out (its stored key no longer matches).
#
# The browser side (assets/gate.js) derives the same PBKDF2-SHA256 through Web Crypto, so the
# two must agree byte for byte: UTF-8 password, 16-byte salt, 32-byte output.

[CmdletBinding()]
param(
  [string]$Code,
  [string]$Verify,
  [int]$Iterations = 300000
)

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$gatePath = Join-Path $root 'assets\gate.js'
if (-not (Test-Path $gatePath)) { throw "gate.js not found at $gatePath" }

$utf8 = New-Object Text.UTF8Encoding($false)
$js = [IO.File]::ReadAllText($gatePath)

$pattern = "var GATE = \{ salt: '([0-9a-f]*)', hash: '([0-9a-f]*)', iterations: (\d+), digits: (\d+) \};"
$m = [regex]::Match($js, $pattern)
if (-not $m.Success) { throw 'Could not find the GATE line in assets/gate.js' }

function Get-Hex([byte[]]$b) { ($b | ForEach-Object { $_.ToString('x2') }) -join '' }
function Get-Bytes([string]$hex) {
  $out = New-Object byte[] ($hex.Length / 2)
  for ($i = 0; $i -lt $out.Length; $i++) { $out[$i] = [Convert]::ToByte($hex.Substring($i * 2, 2), 16) }
  ,$out
}
function Derive([string]$code, [byte[]]$salt, [int]$iter) {
  $k = New-Object Security.Cryptography.Rfc2898DeriveBytes($code, $salt, $iter, [Security.Cryptography.HashAlgorithmName]::SHA256)
  try { Get-Hex $k.GetBytes(32) } finally { $k.Dispose() }
}

if ($Verify) {
  if ($m.Groups[2].Value -eq '') { throw 'No code has been set yet - run without -Verify first' }
  $h = Derive $Verify (Get-Bytes $m.Groups[1].Value) ([int]$m.Groups[3].Value)
  if ($h -eq $m.Groups[2].Value) { Write-Host 'MATCH - that is the current portal code' }
  else { Write-Host 'NO MATCH - that is not the current portal code' }
  exit 0
}

if (-not $Code) {
  $rng = [Security.Cryptography.RandomNumberGenerator]::Create()
  $b = New-Object byte[] 4
  $rng.GetBytes($b)
  $Code = ([BitConverter]::ToUInt32($b, 0) % 1000000).ToString('000000')
}
if ($Code -notmatch '^\d{6,12}$') { throw 'The code must be 6 to 12 digits and nothing else' }

$salt = New-Object byte[] 16
[Security.Cryptography.RandomNumberGenerator]::Create().GetBytes($salt)
$hash = Derive $Code $salt $Iterations

$line = "var GATE = { salt: '$(Get-Hex $salt)', hash: '$hash', iterations: $Iterations, digits: $($Code.Length) };"
$js = $js.Substring(0, $m.Index) + $line + $js.Substring($m.Index + $m.Length)
[IO.File]::WriteAllText($gatePath, $js, $utf8)

Write-Host ''
Write-Host "Portal access code:  $Code"
Write-Host ''
Write-Host 'Stamped into assets/gate.js (salt + hash only). Save the code somewhere safe - it lives nowhere in the repo.'
Write-Host 'Every browser that remembered the old code is now signed out.'

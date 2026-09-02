# build_slide_kit.ps1 - Coach Launch . Sniper Presentation(TM) Slides
#
# Builds the two shipped files of the slide kit from their sources:
#
#   coach-launch-molds.src.html   -> coach-launch-molds.html    (20 slide molds)
#   coach-launch-themes.src.html  -> coach-launch-themes.html   (6 themes + previews)
#
# THE TWO LAYERS
#   A MOLD is structure: which boxes are on the slide, and which data-slot each fills.
#   A THEME is skin: colour, type, corner treatment - a set of CSS custom properties.
#   They meet at the CL-THEME-TOKENS block, which is the ONLY thing a theme swap rewrites.
#
# WHY A BUILD STEP: every mold must be a COMPLETE standalone document (the Slide Viewer
# renders each one in its own sandboxed iframe srcdoc, so molds cannot share a stylesheet).
# That means the token block and the font link repeat in all 20. Maintaining 20 copies by
# hand guarantees drift, so the sources keep ONE copy behind markers and this script stamps
# them in.
#
# SINGLE SOURCE OF TRUTH: every theme - including the default - is defined ONCE, in
# coach-launch-themes.src.html. This script reads them from there. Do not define tokens here.
#
# MARKERS
#   /*CLBASE*/      in a mold  -> default theme tokens + the shared base CSS
#   <!--CLFONTS-->  in a mold  -> the default theme's Google Fonts link
#   <!--CLBASECSS-->in themes  -> the shared base CSS (tokens excluded; each theme brings its own)
#   <!--CLMOLDS-->  in themes  -> the raw preview molds, markers intact, for JS composition
#
# Edit the SOURCES, never the built files. Then re-run:
#   powershell -File scripts/build_slide_kit.ps1

$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
$dir  = Join-Path $root 'modules\2-money-magnet\sniper-presentation-slides'

$moldSrc   = Join-Path $dir 'coach-launch-molds.src.html'
$moldOut   = Join-Path $dir 'coach-launch-molds.html'
$themeSrc  = Join-Path $dir 'coach-launch-themes.src.html'
$themeOut  = Join-Path $dir 'coach-launch-themes.html'

foreach ($f in @($moldSrc, $themeSrc)) { if (-not (Test-Path $f)) { throw "Source not found: $f" } }

$DEFAULT_THEME  = 'crimson'
$PREVIEW_MOLDS  = @('03-promise','11-split-compare','15-stat')
$utf8           = New-Object Text.UTF8Encoding($false)

# -- the shared base CSS. Structure and proportion only: every colour, font, radius and
#    tracking value here resolves through a token that the active theme supplies. --
$baseCss = @'
*{box-sizing:border-box;margin:0;padding:0}
html,body{height:100%;background:var(--canvas);color:var(--ink);font-family:var(--font-body);overflow:hidden}
.s{position:relative;height:100%;display:flex;flex-direction:column;justify-content:center;align-items:center;text-align:center;padding:7vh 6vw}
.eyebrow{font-family:var(--font-display);font-weight:var(--weight);letter-spacing:var(--eyebrow-track);text-transform:uppercase;color:var(--accent);font-size:clamp(13px,1.15vw,17px);margin-bottom:.75em}
h1{font-family:var(--font-display);font-weight:var(--weight);font-size:clamp(32px,3.6vw,56px);line-height:1.1;letter-spacing:var(--track)}
h1 .hl{color:var(--accent)}
.sup{font-size:clamp(17px,1.5vw,24px);line-height:1.55;color:var(--ink-soft);margin:.9em auto 0;max-width:46ch}
.mark{position:absolute;bottom:3vh;right:3vw;font-family:var(--font-display);font-size:clamp(11px,.9vw,14px);font-weight:700;letter-spacing:.12em;text-transform:uppercase;color:var(--ink-faint);z-index:2}
.mark b{color:var(--ink)}
/* Optional background layer. EVERY mold carries one so any slide can take an image.
   Delete the element when no image is supplied - it must never render as an empty box.
   The veil is a theme token, so a background works under light text as well as dark. */
.bg{position:absolute;inset:0;z-index:0;background:center/cover no-repeat}
.bg::after{content:"";position:absolute;inset:0;background:var(--bg-veil)}
.s > *:not(.mark):not(.bg){position:relative;z-index:1}
'@

# ---------- read the themes ----------
$themeText = [IO.File]::ReadAllText($themeSrc)
$rxTheme = [regex]'(?s)<script type="text/plain" data-theme="([^"]+)" data-fonts="([^"]+)">(.*?)</script>'
$themes = @{}
$order  = @()
foreach ($m in $rxTheme.Matches($themeText)) {
  $k = $m.Groups[1].Value
  $themes[$k] = @{ fonts = $m.Groups[2].Value; tokens = $m.Groups[3].Value.Trim() }
  $order += $k
}
if ($themes.Count -eq 0) { throw 'No themes found in the themes source.' }
if (-not $themes.ContainsKey($DEFAULT_THEME)) { throw "Default theme '$DEFAULT_THEME' not defined." }

# every theme must declare the full token contract
$required = @('--brand','--canvas','--ink','--ink-soft','--ink-faint','--line','--panel','--pos',
              '--font-display','--font-body','--r-lg','--r-md','--r-xs','--r-pill',
              '--track','--eyebrow-track','--weight')
foreach ($k in $order) {
  $tok = $themes[$k].tokens
  foreach ($r in $required) { if ($tok -notmatch [regex]::Escape($r + ':')) { throw "Theme '$k' is missing $r" } }
  foreach ($s in @('[data-surface=D]','[data-surface=A]')) { if (-not $tok.Contains($s)) { throw "Theme '$k' is missing $s" } }
}

# ---------- build the molds ----------
$moldText = [IO.File]::ReadAllText($moldSrc)
$defTokens = $themes[$DEFAULT_THEME].tokens
$defFonts  = $themes[$DEFAULT_THEME].fonts

$block = "/* == CL-THEME-TOKENS == a theme swap rewrites ONLY this block == */`r`n" +
         $defTokens + "`r`n" +
         "/* == END CL-THEME-TOKENS == */`r`n" +
         $baseCss

$moldBuilt = $moldText.Replace('/*CLBASE*/', $block)
$moldBuilt = $moldBuilt.Replace('<!--CLFONTS-->', ('<link href="' + $defFonts + '" rel="stylesheet">'))
$moldBuilt = "<!-- BUILT FILE - do not edit. Edit coach-launch-molds.src.html and re-run scripts/build_slide_kit.ps1 -->`r`n" + $moldBuilt
[IO.File]::WriteAllText($moldOut, $moldBuilt, $utf8)

# ---------- build the themes page ----------
# pull the preview molds RAW (markers intact) so the page composes them exactly as the builder does
$rxMold = [regex]'(?s)<script type="text/plain" data-type="([^"]+)">(.*?)</script>'
$moldMap = @{}
foreach ($m in $rxMold.Matches($moldText)) { $moldMap[$m.Groups[1].Value] = $m.Groups[2].Value.Trim() }

$sb = New-Object Text.StringBuilder
foreach ($name in $PREVIEW_MOLDS) {
  if (-not $moldMap.ContainsKey($name)) { throw "Preview mold '$name' not found in the mold source." }
  [void]$sb.AppendLine('<script type="text/plain" data-mold="' + $name + '">')
  [void]$sb.AppendLine($moldMap[$name])
  [void]$sb.AppendLine('</script>')
}

$themeBuilt = $themeText.Replace('<!--CLBASECSS-->', $baseCss)
$themeBuilt = $themeBuilt.Replace('<!--CLMOLDS-->', $sb.ToString().TrimEnd())
$themeBuilt = "<!-- BUILT FILE - do not edit. Edit coach-launch-themes.src.html and re-run scripts/build_slide_kit.ps1 -->`r`n" + $themeBuilt
[IO.File]::WriteAllText($themeOut, $themeBuilt, $utf8)

# ---------- verify ----------
$m2 = [IO.File]::ReadAllText($moldOut)
$t2 = [IO.File]::ReadAllText($themeOut)
$molds     = ([regex]::Matches($m2, 'script type="text/plain" data-type=')).Count
$moldLeft  = ([regex]::Matches($m2, [regex]::Escape('/*CLBASE*/'))).Count + ([regex]::Matches($m2, [regex]::Escape('<!--CLFONTS-->'))).Count
$themeLeft = ([regex]::Matches($t2, [regex]::Escape('<!--CLBASECSS-->'))).Count + ([regex]::Matches($t2, [regex]::Escape('<!--CLMOLDS-->'))).Count
$nul       = ([regex]::Matches($m2, "`0")).Count + ([regex]::Matches($t2, "`0")).Count
$prevMolds = ([regex]::Matches($t2, 'data-mold=')).Count

Write-Output ("themes defined : " + $themes.Count + "  [" + ($order -join ', ') + "]")
Write-Output ("default theme  : " + $DEFAULT_THEME)
Write-Output ("molds built    : $molds  (expected 20)")
Write-Output ("mold markers   : $moldLeft  (expected 0)")
Write-Output ("theme markers  : $themeLeft  (expected 0)")
Write-Output ("preview molds  : $prevMolds  (expected " + $PREVIEW_MOLDS.Count + ")")
Write-Output ("NUL bytes      : $nul  (expected 0)")
Write-Output ("-> " + $moldOut)
Write-Output ("-> " + $themeOut)

if ($molds -ne 20 -or $moldLeft -ne 0 -or $themeLeft -ne 0 -or $nul -ne 0 -or $prevMolds -ne $PREVIEW_MOLDS.Count) {
  throw 'Verification FAILED.'
}
Write-Output 'OK'

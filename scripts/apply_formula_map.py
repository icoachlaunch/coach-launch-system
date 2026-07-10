#!/usr/bin/env python3
"""
apply_formula_map.py — Coach Launch guide standard.

Stamps the standard 3-Pillar / 9-Step formula MAP (with a crimson
"You are here" marker on the current step) into a Formula-step guide,
directly under the hero <header>.

This is the SINGLE SOURCE OF TRUTH for the map's HTML. The map's CSS
lives in assets/coach-launch-guide.css (shared by every guide).

Idempotent: if a map block already exists in the file it is REPLACED,
so re-running never duplicates it. Also strips stray trailing NUL bytes.

Usage:
    python3 apply_formula_map.py path/to/<name>-guide.html [--step N]
                                 [--asset "Display Name"] [--intro "..."]

If --step is omitted, the step is inferred from the filename (see STEP_BY_FILE).
"""
import sys, os, re, argparse

# ---- CANON (never change without updating PROGRESS.md) --------------------
PILLARS = [
    ("1", "Offer",   "Offer Matrix™"),
    ("2", "Money",   "Money Magnet™"),
    ("3", "Clients", "Client Flywheel™"),
]
# step number -> (name, tagline)
STEPS = {
    1: ("$Million Story™",    "Be the voice in their head"),
    2: ("Magic Formula™",     "Make competition irrelevant"),
    3: ("Red Diamond Offer™", "Offers they can't say no to"),
    4: ("The Sniper Close™",  "The audience closes themselves"),
    5: ("Cash Flow Engine™",  "Profit before anyone shows up"),
    6: ("Genie X Converter™", "Close sales while you sleep"),
    7: ("Goliath Content™",   "10X output, zero overwhelm"),
    8: ("Pixie Dust Social™", "Premium buyers for $5 a day"),
    9: ("Dragon Fire Ads™",   "Fill every event on demand"),
}
STEP_ORDINAL = {1:"first",2:"second",3:"third",4:"fourth",5:"fifth",
                6:"sixth",7:"seventh",8:"eighth",9:"ninth"}
PILLAR_OF_STEP = {1:0,2:0,3:0,4:1,5:1,6:1,7:2,8:2,9:2}
PILLAR_ORDINAL = ["first","second","third"]

# filename stem (without -guide.html) -> step number
STEP_BY_FILE = {
    "million-story":1, "million-promise":1, "golden-avatar":1, "million-moment":1,
    "magic-formula":2,
    "money-model":3, "score-card":3, "enrollment-doc":3, "event-magnet":3,
    "sniper-close":4, "the-sniper-close":4,
    "cash-flow-engine":5, "cashflow-engine":5,
    "genie-x-converter":6, "genie-x":6,
    "goliath-content":7,
    "pixie-dust-social":8, "pixie-dust":8,
    "dragon-fire-ads":9, "dragon-fire":9,
}
# nice display names for the known sub-part guides (else defaults to step name)
ASSET_BY_FILE = {
    "million-story":"$Million Story™", "million-promise":"$Million Promise™",
    "golden-avatar":"Golden Avatar™", "million-moment":"$Million Moment™",
    "magic-formula":"Magic Formula™",
    "money-model":"Money Model", "score-card":"SCORE™ Card",
    "enrollment-doc":"Enrollment Doc", "event-magnet":"Event Magnet™",
}

MAP_START = "  <!-- ============ THE MAP (3 PILLARS / 9 STEPS) ============ -->"
# region to replace = MAP_START comment ... first </section> after it
MAP_REGION_RE = re.compile(
    r"[ \t]*<!-- =+ THE MAP \(3 PILLARS / 9 STEPS\) =+ -->.*?</section>\n?",
    re.DOTALL)

def build_map(step, asset, intro):
    name, _ = STEPS[step]
    if intro is None:
        pil = PILLAR_OF_STEP[step]
        place = (f"the {STEP_ORDINAL[step]} step of the {PILLARS[pil][2]}, "
                 f"the {PILLAR_ORDINAL[pil]} pillar")
        if asset.strip() == name.strip():
            intro = (f"Here's the whole system at a glance. Your <strong>{asset}</strong> "
                     f"is Step {step} — {place}.")
        else:
            intro = (f"Here's the whole system at a glance. Your <strong>{asset}</strong> "
                     f"is built inside Step {step}, the {name} — {place}.")
    out = []
    out.append(MAP_START)
    out.append("  <section>")
    out.append('    <p class="cl-eyebrow" style="text-align:center;">The $100K Day Formula™ · 3 Pillars · 9 Steps</p>')
    out.append(f'    <p class="map-intro">{intro}</p>')
    out.append('    <div class="map">')
    out.append('      <div class="map-grid">')
    for pi,(cnum,cword,bar) in enumerate(PILLARS):
        out.append('')
        out.append('        <div class="pillar">')
        out.append(f'          <div class="pillar-cat"><span class="cnum">{cnum}</span><span class="cword">{cword}</span></div>')
        out.append(f'          <div class="pillar-bar">{bar}</div>')
        for s in range(pi*3+1, pi*3+4):
            sname, stag = STEPS[s]
            if s == step:
                out.append(f'          <div class="step here"><span class="snum">{s}</span><span class="here-tag">You are here</span><div class="sname">{sname}</div><span class="stag">{stag}</span></div>')
            else:
                out.append(f'          <div class="step"><span class="snum">{s}</span><div class="sname">{sname}</div><span class="stag">{stag}</span></div>')
        out.append('        </div>')
    out.append('')
    out.append('      </div>')
    out.append('    </div>')
    out.append('  </section>')
    return "\n".join(out)

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("file")
    ap.add_argument("--step", type=int, default=None)
    ap.add_argument("--asset", default=None)
    ap.add_argument("--intro", default=None)
    a = ap.parse_args()

    stem = os.path.basename(a.file)
    for suf in ("-guide.html",".html"):
        if stem.endswith(suf): stem = stem[:-len(suf)]; break

    step = a.step or STEP_BY_FILE.get(stem)
    if step not in STEPS:
        sys.exit(f"ERROR: could not determine step for '{a.file}'. "
                 f"Pass --step N (1-9). Known files: {sorted(STEP_BY_FILE)}")
    asset = a.asset or ASSET_BY_FILE.get(stem) or STEPS[step][0]

    with open(a.file, "rb") as f:
        raw = f.read()
    text = raw.replace(b"\x00", b"").decode("utf-8")   # strip stray NULs

    block = build_map(step, asset, a.intro)

    if MAP_REGION_RE.search(text):
        text = MAP_REGION_RE.sub(block + "\n", text, count=1)
        action = "replaced existing map"
    else:
        m = re.search(r"[ \t]*</header>\n", text)
        if not m:
            sys.exit("ERROR: no </header> found; cannot place map.")
        insert_at = m.end()
        text = text[:insert_at] + "\n" + block + "\n" + text[insert_at:]
        action = "inserted new map"

    with open(a.file, "w", encoding="utf-8") as f:
        f.write(text)
    print(f"OK ({action}): {a.file}  ->  Step {step} '{asset}' marked 'You are here'")

if __name__ == "__main__":
    main()

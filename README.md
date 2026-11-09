# Coach Launch — System Library

The single source of truth for Coach Launch builder prompts, companion guides, and the brand style system. Everything here is on-brand by default.

Brand: **Coach Launch** · System: **The $100K Day Engine™** + **The $100K Day Accelerator™**

---

## What's in here

```
coach-launch-system/
├── modules/                      Every module = its own folder (prompt + guide + extras), grouped by pillar
│   ├── 0-foundations/            The five Foundations + the $100K Day AI Workspace starter kit (built by scripts/build_workspace_kit.ps1)
│   ├── 1-offer-matrix/           Pillar 1 · Steps 1–3 — Million Story, Magic Formula, Red Diamond Offer (9 modules)
│   ├── 2-money-magnet/           Pillar 2 · Step 4+ — sniper-close, sniper-presentation (+ bits/), sniper-presentation-slides, cash-flow-engine, authority-detonator
│   └── 3-client-flywheel/        Pillar 3 · Step 7+ — goliath-content-map, program-module-specs, program-module-visual (Steps 8–9 not built yet)
├── assets/
│   ├── coach-launch-guide.css    The locked stylesheet every guide links to
│   └── agents images/            Agent headshots used on the portal
├── scripts/                      apply_formula_map.py (stamps the 3-pillar/9-step map onto guides) + helpers
├── dashboard.html                The Training Portal — the single entry point to every guide + prompt
├── PROGRESS.md                   The "now" file — read this FIRST (internal, never published)
├── PROGRESS-archive.md           Every old session log, word for word — searched, never read whole (internal)
└── NOTES.md                      Beside each module (+ NOTES-portal.md here): its decisions + history (internal)
```

**Live portal:** <https://icoachlaunch.github.io/coach-launch-system/dashboard.html>

## Where it lives and how it goes live

```
G:\Shared drives\CLIENT ENGINE\product-development\cl-engine-builder-prompts   ← edit here (no .git)
        │  scripts\publish.ps1 — run by hand
        ▼
C:\Users\Focus Account\coach-launch-system                                    ← git lives here; never edit
        ▼
github.com/icoachlaunch/coach-launch-system  →  the live portal
```

Git never lives on Google Drive (Drive corrupts `.git` folders). Nothing goes live until it's published:

- `powershell -ExecutionPolicy Bypass -File scripts\publish.ps1` — **dry run** (the default): lists what would go live. Commits nothing.
- `… scripts\publish.ps1 -Go -Message "what changed"` — commits and pushes. Live a minute or two later.
- `… scripts\publish.ps1 -FromGitHub` — brings changes pushed straight to GitHub (e.g. by `publish_funnel_demo.ps1`) back into Drive. A file changed in both places is listed, never overwritten.

The live portal sits behind a 6-digit access code (`assets/gate.js`). Set, rotate or check it with `powershell -File scripts/set_portal_code.ps1` — only a salted hash is stored; the code itself is never written into this (public) repo. Add `?lock` to the portal URL to sign a browser out.

## The one rule

Never restyle a guide by hand. The look lives in **one** stylesheet (`assets/coach-launch-guide.css`). To build a new guide, copy an existing module guide, keep the CSS link exactly (`../../../assets/coach-launch-guide.css`), and fill in only the content. It's on-brand the moment it's created.

## Brand quick reference

| | |
|---|---|
| Primary color | Crimson Pink `#db0063` (the only accent) |
| Background | White `#ffffff` — light theme |
| Text | Charcoal `#26272b` / near-black `#111111` for headings |
| Display font | Montserrat (700 / 800) |
| Body font | Lato |
| Feel | Clean, bold, premium, high-contrast, zero clutter |

## Naming + layout

Each module is its own folder under its pillar:
`modules/<pillar>/<module>/<module>-guide.html` + `<module>-prompt.md` (plus any related files). The only grouping level is the pillar. Engine-step guides carry the shared CSS + the 3-pillar/9-step map (stamped by `scripts/apply_formula_map.py`).

## How to view

Open `dashboard.html` in a browser (works offline — prompts are embedded), or visit the live portal above.

# CLAUDE.md — Coach Launch System · working map

The single source of truth for Coach Launch builder prompts, companion guides, and the
brand system. Brand: **Coach Launch** · System: **The $100K Day Engine™**. This file is the
router — where things live and which skill to reach for. It loads every session, so it stays
lean and points into the detailed docs instead of repeating them.

## Read-first (the source of truth beats this file)

1. **`PROGRESS.md`** — the build log + standing rules. **Read it first every session**; it says
   where the build is up to and what's next. Update it the moment anything changes.
2. **`README.md`** — the repo structure, the brand quick-reference, and "the one rule".

## Folder map

```
modules/                     the deliverables — one folder per module, grouped by pillar
├── 0-foundations/           the five Foundations (Brand Profile · Visual Style · Brand Voice · Products & Pricing · Competitive Landscape) + the AI Workspace starter kit
│   └── visual-style/brand-kit/   ★ THE DESIGN SYSTEM — six themes every visual thing reads from
│       ├── tokens/<name>.css     Layer 1 · colour, type, corners, shadows. The ONLY place hexes live
│       ├── blocks.css            Layer 2 · buttons, cards, lists, quotes, prices — zero hardcoded colour
│       ├── surfaces/             Layer 3 · page.css · slide.css · social.css (one per medium)
│       └── brand-kit.html        the client-facing "pick your look" gallery
│   └── 100k-day-ai-workspace/    ★ the client STARTER KIT source (root docs · Reference/ · Client Engine/ · skills/).
│                                 The zip is BUILT by scripts/build_workspace_kit.ps1 — never hand-edited
├── 1-offer-matrix/          Pillar 1 · Steps 1–3 (9 module folders: million-promise, golden-avatar,
│                            million-moment, magic-formula, score-card, money-model, enrollment-doc,
│                            event-magnet, cash-flow-max)
└── 2-money-magnet/          Pillar 2 · Step 4+ (sniper-close, sniper-presentation,
                             sniper-presentation-slides [delivered skill], cash-flow-engine)
assets/coach-launch-guide.css  the ONE locked stylesheet every guide links to
assets/agents images/          agent headshots for the portal (space in path → %20 in HTML)
scripts/                     apply_formula_map.py (stamps the 3-pillar/9-step map) + helpers
dashboard.html               the client Training Portal — the single entry point
```

Each module = its own self-contained folder: `modules/<pillar>/<module>/<module>-prompt.md`
(+ its `<module>-guide.html`). The only grouping level is the pillar — no module-inside-module.

## Skills — two classes, two homes

There are two different kinds of "skill" here. Keep them separate.

**1. Author skills** — *your* tooling for building the deliverables. Auto-discovered by Claude.
   - **Global toolbox** `~/.claude/skills/` (reused across every project, not in this repo's git):
     - `coach-launch-design` — brand tokens, logos, fonts, colors (`#db0063`, Montserrat/Lato)
     - `humanizer` — strip AI-writing patterns from copy; use when drafting/editing prose
     - `kie-image-gen` — generate images/headshots/avatars via Kie.ai (its `pack_skill.ps1`
       packager travels inside the skill folder)
   - **This repo** `.claude/skills/` (versioned in git, ships with the repo):
     - `frontend-design` — distinctive, anti-templated visual design for new UI / marketing pages
     - `theme-factory` — quick pre-set themes for artifacts (optional fallback)

**2. Delivered skills** — client packages that ship *with* their builder prompt as one unit.
   They live inside their module (NOT `.claude/skills/`), so they stay part of the package a
   client receives. They don't auto-fire — this file's router tells Claude when to open them.
   - `modules/2-money-magnet/sniper-presentation-slides/SKILL.md` — turns a finished Sniper
     Presentation™ into an on-brand HTML slide deck (ships with the presentation module).

**Adding a new skill:** a skill is just a folder with a `SKILL.md` (frontmatter `name` +
`description`, then instructions). Place it by class: portable author tool → `~/.claude/skills/`;
repo-versioned author tool → `.claude/skills/`; client deliverable → inside its module.

**Pulling in an external skill** (e.g. `github.com/blader/humanizer`):
- `npx skills add <owner>/<repo>` — installs into a skills dir, or
- copy the repo's `SKILL.md` (+ any support files it references) into a new skill folder.
Decide its class first, then drop it in the matching home.

## Task → where to go / what to use

| Working on… | Go here / use |
|---|---|
| **Anything a client will SEE** (slides, funnel, ads, social, collateral) | **Start at the Brand Kit** — `modules/0-foundations/visual-style/brand-kit/`. Load `tokens/<theme>.css` + `blocks.css` + the right `surfaces/*.css`. Never type a hex code outside a token file. |
| Changing a brand colour, font, corner or shadow | Edit the six `brand-kit/tokens/*.css` — **all six**, so the contract holds. Then `powershell -File scripts/build_slide_kit.ps1` to restamp the 20 molds. |
| Adding a new component (a badge, a table, a form) | `brand-kit/blocks.css`, written against tokens only. Not into one page. |
| A new medium (email, print, a 16:10 deck) | A new `brand-kit/surfaces/<medium>.css`. Layout + `--fs-base` only. |
| A builder prompt or its companion guide | `modules/<pillar>/<module>/` |
| Restyling / branding a guide | **Never by hand** — edit `assets/coach-launch-guide.css` (the one stylesheet); pull tokens from `coach-launch-design` |
| A brand-new UI / marketing page from scratch | `frontend-design` skill (+ `theme-factory` for a quick theme) |
| Cash Flow Engine™ funnel pages (Step 5) | `modules/2-money-magnet/cash-flow-engine/SKILL.md` — the Funnel Builder. It reads the client's `BRAND KIT:` block and skins the phase templates in it (RULE 4: the Kit is the only look source). The 28 templates under `Funnel-templates/PHASE-*/` (Launch 6 · Execute 6 · Growth 7 · Mastery 9) are structural references and still carry their own hex — the skill does the skinning. A companion **setup guide per phase** (`phase-*-guide.html`) + the `funnel-examples.html` gallery sit alongside; all are surfaced in the dashboard's Step 5 (`#cashflow`). See memory `cash-flow-engine-funnel-approach` |
| Magic Formula™ visual (Step 2) | `modules/1-offer-matrix/magic-formula-visual/` — templates take `{{BRAND_KIT_TOKENS}}` + `{{SURFACE}}` (`L`/`D`). Never a hex, never a font name |
| A slide deck from a Sniper Presentation™ | `modules/2-money-magnet/sniper-presentation-slides/SKILL.md` |
| The $100K Day AI Workspace starter kit (the client zip) | Edit the source at `modules/0-foundations/100k-day-ai-workspace/` (root docs, folder READMEs, stubs), then `powershell -File scripts/build_workspace_kit.ps1` — it copies the Brand Kit layers + the three delivered skills in, rewrites their relative links to live URLs, verifies, and zips. Never hand-edit the zip. Folder names are canon: `Reference/` (the five Foundations + `brand-kit/`), `Client Engine/` (one folder per asset), `skills/`. Builder prompts do NOT ship in the kit (they update in the portal) |
| Generating images / headshots / avatars | `kie-image-gen` skill |
| Making copy read human / removing AI tells | `humanizer` skill |
| Any new/renamed prompt + guide | also wire it into `dashboard.html` **the same session** (standing rule, see `PROGRESS.md`) |

## Standing conventions (always apply — full detail in the linked source)

- **Local-first drafts.** Build drafts/wireframes locally and let Matthew review BEFORE you
  commit or push — the repo publishes to GitHub Pages, so pushed files go live. (memory
  `local-first-drafts`)
- **One design system.** Everything a client sees reads from the **Brand Kit**
  (`modules/0-foundations/visual-style/brand-kit/`) — three layers: theme tokens → blocks →
  surface. The client picks their theme ONCE, in the Visual Style Guide, and its output carries a
  `BRAND KIT: <name>` block that every downstream builder reads. **Never type a hex code, font
  name or radius outside a token file**; the moment one page hand-picks a colour it starts
  drifting from the rest. Companion guides still use `assets/coach-launch-guide.css` (Coach
  Launch's own brand, not the client's) — that stays as it is. (`README.md` — "the one rule")
- **Contrast is part of the contract.** `--ink-on-brand` is never assumed to be white: white on
  gold is 2.9:1 and on cyan 1.8:1. Sovereign, Voltage and Meadow ship dark text on their hero.
  When you change a `--brand`, re-check it.
- **Dashboard sync.** Every new/renamed prompt+guide must be surfaced in `dashboard.html` the
  same session (guide card + prompt buttons + embedded prompt JSON). The embedded JSON drifts
  silently — run `powershell -File scripts/sync_dashboard_prompts.ps1` to check, `-Apply` to fix.
  (`PROGRESS.md` standing rule)
- **Engine map.** Every Engine-step (1–9) guide carries the 3-pillar/9-step map, stamped by
  `scripts/apply_formula_map.py`. Foundations guides do not. (`PROGRESS.md` standing rule)
- **Big-file editing.** `dashboard.html` is large + minified — edit via Python/.NET UTF-8
  (`UTF8Encoding($false)`), then verify ™ counts and 0 NUL bytes. This host has no real Python
  (MS-Store stub only) → prefer PowerShell + `[IO.File]`. (`PROGRESS.md` lessons)
- **Golden rule.** Never invent frameworks/steps/prices/stats — ask. Never use legacy or
  other-brand terms (Fletcher, MDM, etc.). (`PROGRESS.md` canon)

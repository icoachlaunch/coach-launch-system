# CLAUDE.md — Coach Launch System · working map

The single source of truth for Coach Launch builder prompts, companion guides, and the
brand system. Brand: **Coach Launch** · System: **The $100K Day Formula™**. This file is the
router — where things live and which skill to reach for. It loads every session, so it stays
lean and points into the detailed docs instead of repeating them.

## Read-first (the source of truth beats this file)

1. **`PROGRESS.md`** — the build log + standing rules. **Read it first every session**; it says
   where the build is up to and what's next. Update it the moment anything changes.
2. **`README.md`** — the repo structure, the brand quick-reference, and "the one rule".

## Folder map

```
modules/                     the deliverables — one folder per module, grouped by pillar
├── 0-foundations/           Brand Profile · Visual Style · Brand Voice (built before the Formula)
├── 1-offer-matrix/          Pillar 1 · Steps 1–3 (9 module folders: million-promise, golden-avatar,
│                            million-moment, magic-formula, score-card, money-model, enrollment-doc,
│                            event-magnet, cash-flow-max)
└── 2-money-magnet/          Pillar 2 · Step 4+ (sniper-close, sniper-presentation,
                             sniper-presentation-slides [delivered skill], cash-flow-engine)
assets/coach-launch-guide.css  the ONE locked stylesheet every guide links to
assets/agents images/          agent headshots for the portal (space in path → %20 in HTML)
scripts/                     apply_formula_map.py (stamps the 3-pillar/9-step map) + helpers
dashboard.html               the client Training Portal — the single entry point
guides/                      legacy demo pages only
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
| A builder prompt or its companion guide | `modules/<pillar>/<module>/` |
| Restyling / branding a guide | **Never by hand** — edit `assets/coach-launch-guide.css` (the one stylesheet); pull tokens from `coach-launch-design` |
| A brand-new UI / marketing page from scratch | `frontend-design` skill (+ `theme-factory` for a quick theme) |
| Cash Flow Engine™ funnel pages (Step 5) | `modules/2-money-magnet/cash-flow-engine/page-templates/`; `frontend-design`; see memory `cash-flow-engine-funnel-approach` |
| A slide deck from a Sniper Presentation™ | `modules/2-money-magnet/sniper-presentation-slides/SKILL.md` |
| Generating images / headshots / avatars | `kie-image-gen` skill |
| Making copy read human / removing AI tells | `humanizer` skill |
| Any new/renamed prompt + guide | also wire it into `dashboard.html` **the same session** (standing rule, see `PROGRESS.md`) |

## Standing conventions (always apply — full detail in the linked source)

- **Local-first drafts.** Build drafts/wireframes locally and let Matthew review BEFORE you
  commit or push — the repo publishes to GitHub Pages, so pushed files go live. (memory
  `local-first-drafts`)
- **One stylesheet.** The look lives once in `assets/coach-launch-guide.css`. Copy an existing
  guide, keep the CSS link exactly, fill in only content. (`README.md` — "the one rule")
- **Dashboard sync.** Every new/renamed prompt+guide must be surfaced in `dashboard.html` the
  same session (guide card + prompt buttons + embedded prompt JSON). (`PROGRESS.md` standing rule)
- **Formula map.** Every Formula-step (1–9) guide carries the 3-pillar/9-step map, stamped by
  `scripts/apply_formula_map.py`. Foundations guides do not. (`PROGRESS.md` standing rule)
- **Big-file editing.** `dashboard.html` is large + minified — edit via Python/.NET UTF-8
  (`UTF8Encoding($false)`), then verify ™ counts and 0 NUL bytes. This host has no real Python
  (MS-Store stub only) → prefer PowerShell + `[IO.File]`. (`PROGRESS.md` lessons)
- **Golden rule.** Never invent frameworks/steps/prices/stats — ask. Never use legacy or
  other-brand terms (Fletcher, MDM, etc.). (`PROGRESS.md` canon)

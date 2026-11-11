---
name: cl-cash-flow-funnel-builder
description: Cash Flow Engine™ Funnel Builder V3 — builds a coaching client's complete event funnel (Phase 1 Launch, 2 Execute, 3 Growth or 4 Mastery recipes, or a custom page order; free or paid entry; workshop, masterclass or challenge) as standalone HTML pages in their Brand Kit, from their own assets (CONTEXT.md, Event Magnet™, Magic Formula™, Money Model, SCORE™ Card, Brand Profile, photos). Claude fills the page templates directly, page by page with approval, with the approved V3 pieces (hero, animated panels, product shot, icons, video-led paid registration, simple upsell headers, one-click checkouts, video thumbnails, one hosts section), and always ends on the client's Design board for review before anything goes to AI Studio. Operator-run by Matthew or the Coach Launch team. Use whenever someone wants to build, draft, edit or redo a client's funnel pages, registration/VIP/PASS/membership/deposit pages, or says "build [client]'s Phase N funnel".
---

# Cash Flow Engine™ Funnel Builder · V3

> **Live since 2026-11-11** (Matthew: "The V3 skill needs to overwrite the V2 skill"). V2 — the Python engine — is
> archived in `_superseded/2026-11-11-v2/` (its SKILL, `v2/`, `cfe-engine.zip`); never run it unless Matthew asks.
> Still being proven: the AI Studio publish (Step 8). First full builds: Coach Launch's and Holly's Phase 3 funnels.

## Where you're running

- **Claude Code** (the CLIENT ENGINE workspace or a client's project folder): read and write the client's files
  directly. This skill's own files are in `G:\Shared drives\CLIENT ENGINE\skills\cl-cash-flow-funnel-builder\`.
- **A claude.ai project** (this skill installed from the skill library): this skill's files sit beside this SKILL.md
  (`templates/`, `kit/`, `reference/`, `samples/`). The client's files come from the project's knowledge, from the
  operator's uploads, or — with the device connector — through `device_list_dir` / `device_stage_files` (read) and
  `device_commit_files` (save back); the G: drive does not mount in `device_bash`. Hand pages back as files the
  operator can save when you can't write to their folder.

You build one client's whole funnel for one Accelerator phase: every page as **one self-contained HTML file** (Brand
Kit, copy, photos, scripts inside), ready for AI Studio to clone, plus a short build report — and **always a Design
board of every page for the operator to view and edit before anything is published** (Step 7). The page designs, section
order, fixed copy and VIP visuals are in the templates. **You fill them from the client's own files — page by page,
each one approved — following the written rules. No scripts.** This runs in any Claude chat, so clients can later
build their own.

The operator is Matthew or his team (later, the client). Work in their language; ask them, one question at a time.

## What's in this folder

| Path | What |
|---|---|
| `templates/<page id>.html` | the 16 page templates, V3 pieces built in (never edit them in a build — work on a copy) |
| `kit/` | Brand Kit token files, `blocks.css`, `surfaces/` (incl. `v3-addons.css`, `v3-pages.css`), `funnel.js`, `v3-anim.js`, `to-dc.ps1` (board artboards) |
| `reference/recipes.md` | the flow questions, the four phase recipes worked out (file names, links, lanes), which pages get video |
| `reference/build-rules.md` | how a template becomes a finished page — the exact order of operations |
| `reference/v3-pieces.md` | the hero, panels, product shot, icons, hosts, headers, thumbnails, the Design board rules |
| `reference/pre-show-check.md` | the checks every page passes before the operator sees it, incl. the no-example-left scan |
| `reference/slot-index.md` | every slot and the pages it appears on |
| `samples/*.values.json` | a fictional client's filled values (Dana Cole) — SHAPE AND LENGTH ONLY, never a word of it |

Source of the templates (skill-building only, in the workspace): `v3-wip/make-v3-templates.ps1` turns the page
library in `v3-wip/source-templates/` into `templates/`. A design change goes into the source or the script, then rerun
it — don't hand-edit `templates/`.

## Step 1 · Setup check

1. **Which client** — read their `CONTEXT.md` first (it says which assets are complete and where each file is).
   Coach Launch's own funnels: `G:\Shared drives\CLIENT ENGINE\`.
2. **The Brand Kit** — the BRAND KIT block at the end of their Visual Style Guide → the token file
   (`Reference/brand-kit/tokens/<kit>.css`) and its OVERRIDES. Never ask for a colour or font.
3. **The flow questions** (`reference/recipes.md`, one at a time): phase recipe · free or paid · event type · which
   offers follow page 1 · the close. The Money Model usually answers them — confirm, don't re-ask.

## Step 2 · Read the client's files (read, never edit)

| Their file | Feeds |
|---|---|
| `CONTEXT.md`, `Reference/business-brand-profile.md` | HOST_NAME, HOST_FIRST_NAME, COMPANY, COMPANY_INITIALS, HOST_BIO, AUTHORITY_MARKER_*, location / time zone, SUPPORT_EMAIL; co-host (COHOST_*, HOSTS_*) |
| Visual Style Guide → BRAND KIT block | the kit (step 11 of the build rules) |
| `Client Engine/Offer Matrix/event-magnet/` (Spec + visual) | EVENT_MAGNET_NAME, EVENT_MAGNET_PROMISE, **HERO_HOOK / HERO_SUB / HERO_TAG** (the tool's own RESULT promise), problems, deliverables; MEDIA `event-magnet-tool` + `event-magnet` = the finished tool IMAGE (png/jpg/webp, latest version, never the .html) |
| `Client Engine/Offer Matrix/magic-formula/` (+ visual) | SYSTEM_NAME, stages, the hot step, **the three panels**; MEDIA `system-diagram` |
| `million-promise/`, `golden-avatar/`, `score-card/` | BIG_PROMISE, AUDIENCE_QUALIFIER (short — it's the pill), avatar name for the product-shot phone, before/after, objections |
| `money-model/` (+ cash-flow-max, enrollment-doc) | every price and value — ONE ticket price, no early-bird |
| `Client Engine/Money Magnet/pass-instrument/` | PASS_* |
| Authority Detonator™ / Ticket Sales Detonator™ scripts | the video links once recorded; letter and story copy |
| Photos in their folder | `host-hero` (upper body, room above the head — the V3 hero + laptop), `host` / `host-avatar` (headshot), `host-action`, `logo`, `hosts` (both together, if a co-host), testimonial faces only with their testimonial |

**All copy is written with the `cl-score-framework` skill — load it before you write a single slot.** Rules for every
slot: never invent (prices, numbers, results, testimonials, credentials, guarantees, scarcity) · the client's words and
voice, their coined names as they write them · sell the result, never the how · the host in the third person except
the "from the desk of" letter · every promise a RESULT, never the pain.

## Step 3 · Read back, then ONE list of what's missing

Tell the operator in a few lines what you're building from: client · phase recipe (pages in order) · free/paid ·
event · close · kit · the hero promise you'll use (the tool's result) · photos found. Then ONE list of every fact or
file that's missing (required first). Wait for answers or "build with gaps".

## Step 4 · The three panels first

Before any page, show the three animated panels for "the problems we solve" — one per part of the client's system
(`reference/v3-pieces.md` §2), each with its type, title, badge and rows in the client's words. The operator keeps,
rewords or kills each.

## Step 5 · Build the pages, one at a time, each approved

For each page in the recipe's order (`reference/recipes.md`):
1. Copy the template; apply `reference/build-rules.md` steps 1–11 in order.
2. Build the V3 pieces this page needs (registration: panels, product shot, icons — `reference/v3-pieces.md`).
3. Run `reference/pre-show-check.md` A–D. Fix what the client's files settle; list the rest.
4. Show the operator a one-line-per-section summary + anything to supply, and the page itself. Wait for approval
   before the next page.

## Step 6 · Save and report

Save to the client's `Client Engine/Money Magnet/cash-flow-engine/phase-<N>-<name>/` (`phase-1-launch`,
`phase-2-execute`, `phase-3-growth`, `phase-4-mastery`): every page `.html`, `index.html` (the page map: order, files,
each offer's Yes redirect for AI Studio), `values.json` (every slot you filled — the record of the build) and
`BUILD-REPORT.md` (what's still to supply, sections dropped, check findings). Overwrite on rebuild, never `-v2`.
Update the client's `CONTEXT.md` (Cash Flow Engine™ row, date, `next:`).

## Step 7 · The Design board — ALWAYS, before anything is published (Matthew, 2026-11-11)

Every build ends on a Claude Design board the operator views and edits. Nothing goes to AI Studio until they've
reviewed it there.

1. **Find the client's board for this phase first** — `Artifact` action `list`, look for "<Client> — Phase N funnel"
   (e.g. "Coach Launch — Phase 3 funnel", "Holly Baskin — Phase 3 funnel"). **Update it in place** (same link) —
   one board per client per phase. Create a new one (from the Design type
   https://claude.ai/artifact/QKN21svewxgyPb6SYRqWnd, titled "<Client> — Phase N funnel") ONLY when none exists.
2. **Before replacing anything, read the board back** (every artboard) and compare its words with `values.json`. Any
   hand edit that isn't in the values is carried in FIRST (into `values.json` and the pages) — board edits win. Tell the
   operator what you carried in.
3. One artboard per page, in the recipe's order (the first one `Main.dc.html`), titled "n · Page name". Follow
   `reference/v3-pieces.md` §9: static, full height (measure each page; never cap at 8,000), no lazy images, images
   uploaded once as board assets. Keep the board's own notes and titles.
4. Give the operator the board link and stop. When they've finished editing, read it back again and carry every edit
   into `values.json` and the page files before Step 8.

## Step 8 · Publish (PLAN-V3 Step 6 — being proven)

Only after the operator has reviewed and edited the board (Step 7) and every board edit is in the files.
Pages + images to `icoachlaunch/funnel-previews` (`<client>/<phase>/`, GitHub Pages) → AI Studio clones each page →
the order forms and one-click upsell blocks go into their spots → a test purchase twice (once yes, once no thanks).
Until Step 6 is signed off, stop after Step 6 and hand over the files.

## Rules

- **Client isolation** — one client per build; nothing from another client, the samples or the board examples.
  The pre-show no-example-left scan must be clean.
- **Change only what's asked** on a rebuild.
- **Keys** — never write an API key or password anywhere.
- **Improving the builder** (templates, kit, pieces) is skill work, not a client build: change the source in
  `v3-wip/` (workspace copy), rerun `make-v3-templates.ps1`, log it in `STATUS.md`, then refresh the skill-library
  upload (the zip below).

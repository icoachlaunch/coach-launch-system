# CHANGELOG — Coach Launch builder prompts

**INTERNAL. Not a client deliverable.** Version history lives here, NOT inside the builder prompts —
a client pasting a prompt into Claude or ChatGPT should never be carrying our release notes.

Each builder prompt shows only its version on the header line (e.g. `BUILDER — V2`). Look the
version up here to see what changed.

**Rules**
- Bump the version on the prompt's header line AND add the entry here, in the same session.
- Never put a version number, changelog, or release note in client-facing output (see PROGRESS.md).
- Newest version first, within each module.

---

## Money Magnet™ · Step 4 · Part 2 — The Sniper Presentation™
File: `modules/2-money-magnet/sniper-presentation/sniper-presentation-prompt.md`

V2 (2026-08-21): Hallucination guard + canon rename. FIXED: the tool could ask the user to supply a
  "Signature Talk" - a term that does not exist in this system, naming the very thing this tool builds.
  Added (a) WHITELIST-FIRST enforcement - the Framework Whitelist is the COMPLETE list of assets that
  exist, anything unlisted is banned by default even if it is standard coaching vocabulary; (b) a
  NEVER SUBSTITUTE block in the Prerequisite Gate - if an asset is missing, name it and STOP, never
  swap in a similar-sounding one; (c) "THIS TOOL'S OUTPUT IS NOT AN INPUT". CANON: Enrollment Close
  renamed to The Expert Close. STRUCTURE: reframed as Step 4 Part 2 of 3 (handoff now goes to Part 3,
  the Slides, before Step 5); resolved the Sniper Close contradiction; Phase 1 now has TWO story-bit
  slots (it carries two SCORE acts); the VIP Hour at the START is now actually built.
  HOW TO TELL WHICH COPY YOU HAVE (INTERNAL CHECK - the version is never shown to the client): read the
  version on the header line above, or search the prompt text for "NEVER SUBSTITUTE". If it reads V1, or
  that phrase is missing, it is the old copy - replace it and START A NEW CHAT. Never surface the version
  number in anything the client sees.
V1 (2026-07): First release. Coach Launch build of Step 4 — the tool that turns the
  locked SCORE™ Card into a LIVE masterclass pitch: the Sniper Presentation™, ending in
  the Sniper Close™. Built in Matthew White's voice on Matthew's own one-page Sniper Close
  framework (5 acts = the SCORE™ arc, grouped into 4 phases: WHO / WHAT / WHY / WHEN) and
  his masterclass content blueprint. External references (a live-workshop builder + a
  long-form video-sales-letter builder) were studied for STRUCTURE ONLY and rebuilt
  original in canon — all legacy terms stripped (they appear ONLY in the TERMS NEVER TO
  USE block). Two flex axes: FORMAT (Masterclass single-day / Challenge 3-day) and CLOSE
  (Expert / Strategy [free or paid] / Deposit). Story is the driver — every act has a
  speaker-bit slot pulled from the bits/ library. Validation is a qualitative pass/fail
  gate (the Sniper Presentation™ Ready Check) — NO /25 — same precedent as the SCORE™ Card,
  the Enrollment Doc, the Event Magnet™, and Cash Flow Max™, because it ASSEMBLES from
  upstream assets that are already scored and locked. No fabricated results or stats —
  only Matthew's $24M / $5.2M as credentials, and only the user's true stories.

---

## Money Magnet™ · Step 4 · Part 1 — The Strategy Close
File: `modules/2-money-magnet/sniper-close/pass-calibration-prompt.md`

V1 (2026-08-21): First release. The PASS™ Calibration Builder — turns a coach's locked
  Magic Formula™ (3 stages, 9 steps) into the PASS™ Instrument: the diagnostic they run in every
  Paid Audit Strategy Session. Per step it captures a Step Currency, a type (objective / subjective /
  both), 1-3 spoken diagnostic questions, and scoring anchors at 5 and 1. Nine steps x 5 = a session
  scored out of 45. Full A-J architecture, one step per turn, gated on the Magic Formula™ only.
  Validation is a pass/fail PASS™ Instrument Ready Check (NO /25) — same precedent as the SCORE™
  Card, the Enrollment Doc, the Event Magnet™, and Cash Flow Max™, because it builds on an asset
  that was already scored and locked. Carries the whitelist-first hallucination guard, the NEVER
  SUBSTITUTE block (15 ban lines), and the licence header. KEY DESIGN: RULE 2 — "the coach is the
  expert, not you" — the AI may suggest question wording but may never decide a currency, write a
  question unilaterally, or invent an anchor or a niche benchmark. The coach's expertise is the
  product; an instrument built from AI guesswork produces a generic audit and gives their client no
  reason to hire them. NAMING: Step Currency (per Magic Formula™ step) is deliberately distinguished
  from Core Currency (the single  Promise™ outcome) — same idea, different scale, flagged
  in-prompt so they are never conflated. "Instrument" is a plain descriptor and carries no ™, matching
  the SCORE™ Card pattern; it is NOT called a card, to avoid colliding with the SCORE™ Card itself.
  External references were studied for STRUCTURE ONLY and rebuilt original in canon — all legacy
  terms stripped and confined to the TERMS NEVER TO USE block.

---
## Other modules

Their history has not been migrated yet — 12 other builder prompts still carry an inline
`# CHANGELOG` block. Move each one here when you next touch it, then delete the inline block.
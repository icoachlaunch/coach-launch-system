---
name: cl-program-module-visual
description: >
  Step 2 of 2 for your Program Modules. Turns your confirmed Module Specs (from cl-program-module-specs) plus
  your BRAND KIT block and headshot into the finished, printable module pages in your own brand — one page
  per spec, on a design canvas you can edit by hand (or as print-ready HTML/PDF files). Use whenever you
  want to build, design, render or redo the pages, worksheets or PDFs for your program modules, or say
  "build my module pages" / "build the page for Module 3".
---

# Program Module Visual (step 2 of 2)

**cl-program-module-specs** writes the Module Specs: what is on each page and the teach that goes with it.
This skill builds the pages from those specs, in your Brand Kit, one module at a time. It designs, builds
and hands you a page you can perfect by hand or by asking — and when you edit by hand, it keeps your edits.

It does not write or rewrite the module's content. A content change (a row name, a struggle, the promise)
goes back into the spec first, so the two stay in step; the skill will offer to make that edit for you.

## How this skill is laid out

- `references/page-build.md` — the procedure: the eight zones, layouts and structures, the Kit, writing the
  artboard, publishing (canvas or standalone files)
- `references/panels.md` — the page design system: the design layer, word budgets, fit rules, the Kits
- `assets/templates/` — one worked template per layout (fictional businesses; structure and classes only,
  never their copy), plus `assets/kits.json` and `assets/tokens.json`
- `scripts/standalone_html.py` — turns a page into a self-contained HTML file that prints to PDF

## What to have ready

| Input | Status | What it gives the build |
|---|---|---|
| **Module Spec(s)** (`module-0N-[slug].md`) | Required | Everything on the page: Part A (A1–A10) and, from Part B, the struggles (B1), Done when (B4) and proof (B5) |
| **BRAND KIT block** (`BRAND KIT: <kit>` · `OVERRIDES:` from your Visual Style Guide) | Required for the final look | Your Kit (Crimson · Ink · Ember · Sovereign · Voltage · Meadow) and any hero-colour or font overrides |
| **Your headshot** (a square-ish photo) | Required | The round photo in every module's banner. Missing → a `[PHOTO]` circle until you supply one |
| Your country | One question, once | Sets the print size (Letter in the US, A4 elsewhere) — never shown on the page |

- **No spec:** the skill stops and names **cl-program-module-specs** as where it comes from. It never designs
  a page from a description: the panels, rows and bands are the spec's job.
- **No BRAND KIT block:** it builds in a neutral Kit (Ink for serious or high-ticket programs, Meadow for
  wellness or calm, Crimson otherwise), says which, and flags it. The Kit can be switched in one click.
- **One program per canvas.** Only your specs and your Kit. Nothing from the template examples.

## Fixed rules

1. **The spec's words.** Copy is tightened only to the word budgets in `references/panels.md`; never a
   changed name, number, price or claim. Your spec is verified content and is used as written. Any
   `[MISSING CONTENT — …]` in a spec stays visible on the page, naming what is missing, until you supply it;
   a missing headshot shows as the `[PHOTO]` circle.
2. **The module's name is the step's name**, exactly as the spec writes it. Never shortened: a long title
   drops in size before anything else.
3. **No offer on the page.** The closing bar is the belief line, the commitment lines and one **Next**
   button. No price, no booking, no QR, no second button.
4. **Never name a paper size** on anything a member sees — no "A3", "A4" or "Letter" in board titles, file
   names or page copy. Board titles read `Module 0N · [Step name]`.
5. **Never invent.** No proof, numbers, quotes, links or program features that aren't in the spec.
6. **Your Kit, your photo, your names** — and nothing from the fictional template businesses.

---

# The flow — one page at a time

## Stage 1 · Read and confirm (one message)

The skill reads every spec supplied and the BRAND KIT block, then shows one short message:

- which modules it has (and any missing from the nine), each with its Layout and Structure from the spec;
- the Kit it will use, any overrides and which roles your colour will take;
- whether it has your photo;
- the print size it will set from your country, and one question if it doesn't know it;
- whether a Design canvas is available in your account, or the pages will be delivered as HTML/PDF files.

Reply "go", or correct anything first.

## Stage 2 · Build, one page at a time

For each module, in step order:

1. **Build** the page from its spec, following `references/page-build.md`: map the spec to the eight zones,
   take the layout template and the structure, apply the design layer, set the Kit, write the artboard,
   publish it to the canvas (or convert it to a standalone file).
2. **Show it** and say in one line what was built: layout, structure, Kit, anything cut to fit, and the
   placeholders left on the page.
3. **Your pass.** Edit anything on the canvas by hand, or ask for changes. Before every change the skill
   re-reads the page and keeps your edits. A content change goes back into the spec (the skill offers to
   do it) and then onto the page.
4. **Next.** "Next" builds the following module; "all" builds the rest in one pass and reports after.

## Stage 3 · Deliver

When the pages are done:

- One line per module: name · layout · structure.
- **Missing content:** every `[MISSING CONTENT — …]` and `[PHOTO]` still on a page, and anything cut to
  budget (with what was cut).
- **Export:** each page as a PDF (prints on Letter or A4) for your member pack or course platform. On the
  canvas: select the board and export. From standalone files: open the HTML in any browser and print to
  PDF, or use the PDFs the skill produced.
- Offer a Kit check (one page in a second Kit) if you want to compare.

---

# What this skill never does

- Writes or rewrites a module's content, names or promise — that is the spec's job.
- Puts an offer, price, booking link, QR or second button on a page.
- Mixes programs, or uses the template examples' copy, colours or icons.
- Uses a marker, script or novelty display face: headlines are always the Kit's display font.
- Shrinks type below the floors to make copy fit — it cuts copy to the budgets and says so.
- Names a paper size on anything a member sees.

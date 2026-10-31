# Reference — the truth about your business

Everything in this folder is a fact about your business that every builder, skill and session reads
and never asks you twice. Five documents, one Brand Kit, one notes file, and room for your own.

## The five Foundations

| # | Document | File | What it captures |
|---|---|---|---|
| 1 | Business Brand Profile | `business-brand-profile.md` | What you believe, why you exist, where you're headed, where you operate |
| 2 | Visual Style Guide | `visual-style-guide.md` + your Kit in `brand-kit/` | Your look — the one Brand Kit everything reads |
| 3 | Brand Voice | `brand-voice.md` | How you write and speak |
| 4 | Products & Pricing | `products-and-pricing.md` | What you sell at three levels — membership · accelerator · proximity — with price points |
| 5 | Competitive Landscape | `competitive-landscape.md` | The alternatives your buyer weighs, the gaps, your edge against each, where your prices sit |

Build them in that order; each makes the next builder sharper. Each has its own builder in
**Coach Launch Academy™** — download it from your Training Portal, paste it into a fresh chat, answer
one question at a time, and save the result over the matching stub here. A stub starts with
`status: empty` in its frontmatter; a finished document says `status: complete`.

## Every document starts like this

```
---
document: [Document Name]
version: 1
last_updated: [date]
status: empty | complete
---

## Revision History
| Version | Date | Changes |
|---------|------|---------|
| 1 | [date] | Initial build |
```

One canonical file per document, revised in place. The Revision History says *what* changed; the notes
below say *why*.

## brand-kit/

Your ONE installed Brand Kit — the look every slide, page, ad and post reads from. `tokens/` holds
exactly one file: the Kit you chose in your Visual Style Guide. `brand-kit/README.md` has the how-to.

## Memory — `Reference/NOTES.md`

The five documents are files, not folders, so they share one notes file: `NOTES.md`, here beside them,
with a heading per document. It holds what `CONTEXT.md` must not — the reasoning. Why you chose that
lane and not the other. The positioning you tried and dropped. The price you're still deciding. The
Kit you nearly picked. Claude makes the file the first time a Foundation is saved, reads the heading
for the document it's about to touch, and adds to it after. Only the status row and the one-line facts
go in `CONTEXT.md`.

```
# Notes — Reference

> Working memory for the five Foundations (and any document of your own). One heading per document.

## Business Brand Profile
- Decisions · [date] — [what] — because [why]
- Rejected · [date] — [what] — [why not]
- Open · [what's unresolved]
- Log · [date] — [what happened, in a line]

## Visual Style Guide
...
```

## Adding your own business information

Not everything about your business fits the five. Certifications, team bios, policies, a guarantee,
a client list, your origin story in long form — anything that is **true about the business** and
that the AI should know every session — goes here as a new document beside the five:

- One `.md` per topic, named in lowercase with hyphens (`team.md`, `guarantee.md`, `credentials.md`).
- Start it with the same frontmatter as the five (`document` · `version` · `last_updated` · `status`).
- Claude adds a row for it in `CONTEXT.md`'s Reference table, so every session knows it exists, and a
  heading for it in `NOTES.md`.

Keep the line clean: **Reference is what's true about the business. Client Engine™ is what's built
from it.** A podcast, a book or a case-study library is an asset — it belongs in `Client Engine/`, in
the pillar it serves (the README there says how).

## Keeping it current

When the business changes — a new price, a refined positioning, a new team member — update the
Reference document, bump its version, add a revision-history row, and note the why in `NOTES.md`. Then
Claude updates the one line that changed in `CONTEXT.md`.

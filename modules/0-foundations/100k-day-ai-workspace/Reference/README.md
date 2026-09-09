# Reference — the truth about your business

Everything in this folder is a fact about your business that every builder, skill and session reads
and never asks you twice. Five documents, one Brand Kit, and room for your own.

## The five Foundations

| # | Document | File | What it captures |
|---|---|---|---|
| 1 | Business Brand Profile | `business-brand-profile.md` | What you believe, why you exist, where you're headed, where you operate |
| 2 | Visual Style Guide | `visual-style-guide.md` + your Kit in `brand-kit/` | Your look — the one Brand Kit everything reads |
| 3 | Brand Voice | `brand-voice.md` | How you write and speak |
| 4 | Products & Pricing | `products-and-pricing.md` | What you sell, prices, delivery, your Accelerator phase |
| 5 | Competitive Landscape | `competitive-landscape.md` | Your market, competitors, and edge |

Build them in that order; each makes the next builder sharper. Each has its own builder in
**Coach Launch Academy™** — download it from your Training Portal, paste it into a fresh chat, answer
one question at a time, and save the result over the matching stub here. A stub starts with
`status: empty` in its frontmatter; a finished document says `status: complete`.

## brand-kit/

Your ONE installed Brand Kit — the look every slide, page, ad and post reads from. `tokens/` holds
exactly one file: the Kit you chose in your Visual Style Guide. `brand-kit/README.md` has the how-to.

## Adding your own business information

Not everything about your business fits the five. Certifications, team bios, policies, a guarantee,
a client list, your origin story in long form — anything that is **true about the business** and
that the AI should know every session — goes here as a new document beside the five:

- One `.md` per topic, named in lowercase with hyphens (`team.md`, `guarantee.md`, `credentials.md`).
- Start it with the same frontmatter as the five (`document` · `version` · `last_updated` · `status`).
- Claude adds a row for it in `CONTEXT.md`'s Reference table, so every session knows it exists.

Keep the line clean: **Reference is what's true about the business. Client Engine™ is what's built
from it.** A podcast, a book or a case-study library is an asset — it belongs in `Client Engine/`, in
the pillar it serves (the README there says how).

## Keeping it current

When the business changes — a new price, a refined positioning, a new team member — update the
Reference document, bump its version, add a revision-history row. Then Claude updates `CONTEXT.md`.

---
name: cl-dragon-fire-ads
description: "Dragon Fire Ads™ Builder — builds a complete paid ad pack (Facebook/Instagram) for Coach Launch or a coaching client from the assets already in the system: the Goliath Content™ Map's Slingshot Hooks™ (required gate), SCORE™ Card, Event Magnet™ Spec + Visual, $Million Promise™, Golden Avatar™, Brand Voice, Brand Kit and Money Model. One run hands back the campaign brief, five SCORE™-shaped ad angles with hooks, primary text, headlines and CTAs, finished static creatives on a Claude Design canvas built around the Event Magnet™ tool in the business's Brand Kit, video/reel ad scripts, and the campaign setup. Destination is chosen per run (default: the virtual event's registration page; also click-to-message, Event Magnet™ opt-in, retargeting). Always asks Guided or Fast. Use whenever someone wants ads, ad copy, ad creative, a Meta/Facebook/Instagram campaign, reel ads, retargeting ads or 'Dragon Fire Ads' for Coach Launch or a client — even if they just say \"do [client]'s ads\"."
---

# Dragon Fire Ads™ Builder

Coach Launch · The $100K Day Engine™ · Client Flywheel™ · Step 9 · Dragon Fire Ads™

This skill builds the paid traffic that fills a virtual event. It writes nothing new from thin air: by
the time a business reaches Step 9, the system already holds everything an ad needs — the promise, the
avatar's own words, five acts of proven copy, 210+ market-tested hooks, a visual tool that stops the
scroll, and a funnel to send people to. The job here is to **select, assemble and shape** that material
into ads that convert, and to build the creatives in the business's own brand.

> Same message. Different front doors. The Goliath Content™ Map already wrote the front doors — the ads
> walk people through them.

It runs for **Coach Launch's own ads** and for **any client's ads**. The operator (Matthew or the team)
or the client can run it; both go through it step by step when they choose Guided.

## How this file is laid out

The workflow is here. The detail lives in references — read each one when the workflow points to it:

- `references/sources.md` — the gate, every input, where it lives, what it feeds. **Every run, first.**
- `references/angles-and-hooks.md` — the five angles, how hooks are pulled from the map and adapted.
- `references/copy-and-compliance.md` — placements, character limits, CTA buttons per destination, Meta
  ad-policy rules for coaches. Before writing any copy.
- `references/creatives.md` — the five creative concepts, sizes, safe zones, how to build them on a Design
  canvas around the Event Magnet™ tool. Before building any visual.
- `references/video-ads.md` — the three video/reel ad scripts. Before writing video.
- `references/campaign-setup.md` — campaign structure per destination, testing plan, naming, UTMs.
- `references/ad-pack-template.md` — the output contract. When writing the file.
- `scripts/ad_check.py` — run on the finished ad pack before delivery.

## 0 · Load the foundation

1. **Load `cl-score-framework`** and read its reference once. Every ad is a persuasive piece: all five acts,
   in order, at ad depth (one line or one beat each), one big idea, one action. This skill's delivery format
   wins over the Framework skill's default; the Framework's rules win for the copy itself.
2. **Ask: Guided or Fast?** Always ask, for clients, Matthew and the team alike — never assume Fast.
   - **Guided** — one stage per turn, waiting for a "go" or edits at each checkpoint below. Creatives are
     shown one at a time.
   - **Fast** — read everything, make the calls, build the whole pack, then deliver it for perfecting.
     Note every assumption in the chat.
3. **Ask: who is this for — Coach Launch or a client (which one)?** Then **ask the destination**
   (`references/sources.md` §4) with the default pre-selected: *the virtual event's registration page*.
   Ask both in the same message as Guided/Fast, so it's one reply.

## 1 · Client isolation and brand — non-negotiable

- One business per run, per file, per canvas. Use only that business's documents. Never carry a name,
  hook, story, result, price, colour, icon or phrase from another client, from the examples in this skill,
  or (for a client) from Coach Launch's own material.
- **A client's ads wear the client's Brand Kit** (their BRAND KIT block from their Visual Style Guide),
  never Coach Launch's branding, fonts, hand-drawn icons or credentials. Matthew's figures ($24.6 Million /
  $5.2 Million) appear only in Coach Launch's own ads.
- **Coach Launch's ads** wear Coach Launch's own brand kit (`CLIENT ENGINE\Reference\brand-kit\`), and may
  use the hand-drawn icon house style and Matthew's credentials.

## 2 · The client's documents are verified — the only flag is missing content

Everything in the business's folder is their own information and counts as verified. Use it as written;
never ask anyone to confirm it. The one flag this skill writes is **`[MISSING CONTENT — …]`**, naming
exactly what the documents don't contain (a real client result for the proof ad, the ad budget, the
registration link). Never invent proof, numbers, prices, deadlines, testimonials, links or audiences'
behaviour. Retired markers (`[PROOF NEEDED]`, `[CHECK WITH CLIENT]`, `[PROVISIONAL]`, `[VERIFY]`) are
never written. In-session decisions by the operator override the documents and are used everywhere.

## 3 · The rules that make the ads convert

- **Sell the dream outcome — the tool is the scroll-stopper, never the product.** The Event Magnet™ is on
  the creative because a real, visual thing opens a curiosity loop. The copy sells what it gets them: the
  $Million Promise™'s currency, the R-3 life, the R-4 want. A line that says what the tool *is* without
  what it *does for them* gets rewritten. Weak: "Get my free scorecard." Strong: "Find the one leak
  costing you clients — and fill next month's calendar without discounting."
- **The result is the driving force.** The $Million Promise™'s core result (Coach Launch: "3–5 high-ticket
  clients from their next virtual event") stands out in every ad: in the headline under the creative, in the
  promise line, and as the main headline of at least two creatives ("How coaches close 3–5 high-ticket clients
  from their next virtual event", "How we close 3–5 high-ticket clients in our virtual events").
- **Never name the signature system in an ad.** Cold and warm audiences don't know the business yet; the ads
  hook with the Event Magnet™ tool (the curiosity piece) and the result. The signature system (the Magic
  Formula™ name — Coach Launch's $100K Day Engine®) is introduced inside the virtual event. Pass its name to
  the checker with `--system`.
- **A link in the text, with a pointing finger.** People read, then want to click where they are. Every
  primary text carries the call to action with the registration URL on its own line: `👉 Grab your $27 seat
  here: <URL>` — at the end of the short text, and at the end of the first and last paragraphs of the long
  text — as well as the button. No URL yet → `[MISSING CONTENT — registration link]`, listed in section 10.
- **Every hook comes from the Goliath Content™ Map.** Pull the Slingshot Hook™ (and the Stone or Flagship
  title behind an angle) from the map, cite its section and row, then adapt it to the placement. Never
  write a hook the map doesn't support — if the map is thin for an angle, say so and use the nearest row.
  The map is the reason the ads sound like the business and not like ads.
- **One ad, one big idea, one action.** Each angle is one idea from one act; the CTA is one button to one
  destination. No second link, no "or book a call".
- **Call out the avatar at the top of every ad — in varied words.** The first line — inside the first 125
  characters of the short primary text and the first paragraph of the long one — names who it's for, built on
  the $Million Promise™'s Ideal Audience (the who + the qualifier, e.g. coaches, consultants and experts + an
  offer of $3,000 or more). With an open Advantage+ audience, that callout is what teaches the algorithm who to
  find; the map hook follows straight after it. The callout isn't one fixed line: write **3–5 callout
  variants** in different shapes — the statement ("If you're a coach, consultant or expert with an offer of
  $3,000 or more…"), the question ("Are you a coach or expert with a $3K+ offer?"), the gate ("This is only for
  coaches, consultants and experts with offers of $3,000 or more"), the direct address ("Coaches and experts
  with a proven $3K+ offer:") — and spread them across the ads so the callout is tested too. Winners are kept;
  more variants come as the content grows. Call out the group and the business, never a personal attribute
  (policy check 1).
- **The $Million Promise™ is in every ad.** The full promise, word for word, sits in the long primary text
  (Opportunity or Execution); the short text and the headline carry its core — the audience plus the Core
  Currency and Metric ("…close 3–5 high-ticket clients from your next live virtual event"). The promise drives
  results; the hook only opens the door to it. The promise is the business's locked wording — never edited, and
  exempt from the copy checks (if it says "live event", it stays).
- **Congruency — the ad and the page make the same promise.** The registration page's headline carries the
  same promise as the ads, in the same words. Before writing, put the locked promise beside the page headline
  in the brief: match ✔, or ✗. A ✗ is fixed one of two ways — the page is updated to the promise (a hand-off
  to `cl-cash-flow-funnel-builder`), or the ad set is a **declared promise test**: each promise variant gets its
  own page variant, a direct line from ad to page. When a test has a winner, that promise is locked — in the Ad
  System Map, every ad, and the page — and the losers come down.
- **Never a bare "event" or "room".** Say virtual event, or the format (masterclass, workshop, challenge,
  launch, webinar), and virtual room. Cold audiences must know in the first line it's online and live.
- **No "the" in front of a system or tool name** ("Client Pulse Map", never "The Client Pulse Map" or
  "the Client Pulse Map") — in copy, creatives and scripts alike. Write around it: "Get your Client Pulse
  Map", "with Client Pulse Map".
- **Evergreen by default.** Events run on repeat; an ad with a date goes stale and gets killed early. No
  date, weekday or time in the copy or creative unless the operator asks for a dated campaign — then the
  date lives in the copy only, never baked into the creative.
- **Free virtual events: nothing is promised that isn't delivered.** No recording or replay offered (it's
  gated for VIPs). Nothing — the tool included — is released before the day: the tool is handed over live
  ("join live and get your [tool name]"). The only exception is a standalone Event Magnet™ opt-in funnel
  that doesn't feed a virtual event (sources.md §4).
- **Prices:** a free virtual event says "free". A paid ticket may state its price in the copy (Money Model
  only). Never a price on the tool image, and never the core offer's price in an ad.
- **Brand Voice.** Read it in full; every line sounds like the business. "I" only for the host's own
  story and credentials, "we" for the virtual event and the method, "you/they" for the people helped.
- **Results are reported, never promised.** Income and results are told from I, we, they, them, us, ours —
  "this is how our clients made $30,000 in the last 60 days", "last month I made $30,000 from this one
  campaign". Never "you will / you'll / you can make", never "your $10K", never "guaranteed". "You" calls out
  the avatar and their situation; it never owns a result.
- **Compliance is part of conversion.** A disapproved ad converts no one. Run the Meta policy check in
  `references/copy-and-compliance.md` on every line — personal-attribute callouts and income claims are
  the usual killers for coaches.
- **Australian spelling** unless the business writes otherwise.

## 4 · The workflow

### Stage 1 · Read, gate and brief (checkpoint)

Read `references/sources.md`, then every supplied or folder asset in full. **Gate first:** no Goliath
Content™ Map (or a map with no Slingshot Hooks™) → stop, name `cl-goliath-content-map` as the step that
makes it, and say the ads are built from it. The same for the other required assets listed there. Then show,
compactly:

1. **What I pulled** — business, $Million Promise™ verbatim, avatar in one line + 2–3 of their phrases,
   system, the Event Magnet™ (name, Tool Promise, layout, canvas link), the virtual event (format, free or
   paid, ticket price if any), the destination and its URL, proof available (real results, named), genuine
   scarcity (or none), Brand Kit, map version and how many sections/hooks it holds.
2. **The brief** in four lines (SCORE™ §4): mode marketing · format + temperature (cold for prospecting,
   warm/hot for retargeting) · **the big idea of the campaign** in one sentence, built on the dream outcome
   · the one action.
3. **Gaps** — every `[MISSING CONTENT — …]` the pack will carry.

Guided: wait. Fast: carry on.

### Stage 2 · The Angle Map (checkpoint)

Read `references/angles-and-hooks.md`. Choose **five angles, one led by each SCORE™ act**, drawn from the
map's Event Magnet™ section first and the hot step's section second. For each: the angle name, its one-line
idea, the map rows it draws from, **three candidate hooks** (map rows, adapted, each labelled with its hook
type), and the creative concept it pairs with. Say which angle you'd launch first and why.

Guided: the operator picks or edits hooks. Fast: take the first hook of each as the lead, keep the other two
as test variants.

### Stage 3 · The ad copy (checkpoint)

Read `references/copy-and-compliance.md`. For each angle write: the three hooks as first lines · primary text
**short** (≤ 125 characters, the whole ad above "See more") · primary text **long** (all five acts, one line
or one short paragraph each, 60–180 words) · headline (≤ 40) · description (≤ 30) · CTA button · destination.
Draft every opening line several times and keep the one no other business could have written. Run the
SCORE™ five-act check and score each long primary text /25 (floor rule: any act at 2 or below doesn't
ship). Run the compliance check. Show the copy with act labels in the chat only — the file carries clean copy.

### Stage 4 · The creatives (checkpoint — one at a time in Guided)

Read `references/creatives.md`. Build on the business's own Dragon Fire Ads™ canvas (never the Event Magnet™ canvas; `cl-dragon-fire-ads-statics` owns this step): **five 4:5 statics** (one per concept,
each wearing its angle's lead hook), plus **9:16 and 1:1 versions of the lead angle's creative**. The Event
Magnet™ tool page is the hero of every concept. **Read the canvas back before every publish** — the
operator's hand edits win and get carried into the next boards. Guided: build the lead creative first, show
it, get a "go", then the next. Fast: build all, then show the canvas. No BRAND KIT block for a client →
creatives wait (copy carries on); name the visual-style-prompt in `CLIENT ENGINE\Builder Prompts` as where
it comes from.

### Stage 5 · The video ads (checkpoint)

Read `references/video-ads.md`. Write three scripts: **V1 Hook Reel** (15–30 s), **V2 Host to Camera**
(45–75 s), **V3 Tool Demo** (30–60 s). Each opens on a map hook in the first three seconds, holds the tool
up on camera, sells the outcome and ends on the one action said out loud and shown on screen.

### Stage 6 · Setup, retargeting, message flows

Read `references/campaign-setup.md`. Write the campaign structure for the destination, the testing plan,
naming and UTMs. Add the retargeting set when the destination includes it (or offer it as the next pack),
and the click-to-message greeting + ice breakers when the destination is Messenger/WhatsApp.

### Check and deliver

1. Assemble the pack with `references/ad-pack-template.md` exactly — the headings are a contract the
   checker reads.
2. Run `python3 scripts/ad_check.py ad-pack-<slug>.md --client "<Business>" --tool "<Tool name>"
   --system "<signature system name>" --map goliath-content-map.csv` (use `--coach-launch` instead of `--client` for Coach Launch's own pack). Fix every FAIL; read every WARN and fix the real ones. Re-run until PASS.
3. Save: `Client Engine/Client Flywheel/dragon-fire-ads/ad-pack-<slug>.md` in the business's folder (Coach
   Launch's own: the same path in `CLIENT ENGINE`). One canonical file per campaign — never a `-v2`; a change
   bumps `version` and adds a Revision History row. If the session is attached to the business's claude.ai
   Project, save it there too. Update the business's `CONTEXT.md` (Dragon Fire Ads™ row, `last_updated`).
4. In the chat, keep it short: the campaign's big idea, the lead angle, the canvas link, the scores (per ad
   /25), and the **missing content list** — every `[MISSING CONTENT — …]`, each naming what's needed. Don't
   paste the pack into the chat as well as the file. Mention export: each creative exports as a PNG
   from the canvas for Ads Manager.

### Perfect — the loop

The operator pushes back ad by ad. Rewrite only what they flag; adopt their rewrites verbatim (fix only
spelling and punctuation; raise at most one claim the policy or the proof can't support). Re-run the checks
on what changed, re-save the same file, re-publish only the changed boards (read the canvas back first —
their hand edits win). **Winners from a live test** come back as a new angle round: keep the winning hook,
write new variants of it from neighbouring map rows.

## 5 · Boundaries

- Writes the ads, the creatives, the video scripts and the setup. It does **not** write the landing pages
  (`cl-cash-flow-funnel-builder`), the show-up or VIP videos (`cl-authority-detonator`), the content
  roadmap (`cl-goliath-content-map`), the 8-touch message conversation after a click-to-message ad, or
  emails (Genie X Converter™). Name the right tool in one line.
- No funnel maths. No predicted CPL, CTR, ROAS or show rates — the numbers come from running the ads and
  the targets come from the Money Model. Budgets are the operator's or the Money Model's, else
  `[MISSING CONTENT — daily ad budget]`.
- Doesn't launch or edit live campaigns in Ads Manager.
- Asked for a hook the map doesn't hold → "The ads are built from the map. Add the angle to the Goliath
  Content™ Map first, or pick the nearest row." Then offer the nearest row.

# Challenge-Funnel Landing Page — Replication Prompt

Use this prompt in your vibe-coding tool alongside the wireframe (`Challenge Funnel Wireframe.dc.html`). Fill in the variables, paste, and go.

---

## THE PROMPT

Build a single-page, long-form challenge-registration landing page following the 21-section direct-response funnel framework below. Every section stacks vertically, full-width, mobile-responsive. The single conversion goal is registration via an opt-in popup (name, email, optional phone) — every CTA button on the page opens that same popup.

### STYLING — MATCH THE TEMPLATE EXACTLY (non-negotiable)
Replicate the reference template's styling identically. Do NOT invent your own theme, do NOT make the page dark, do NOT change button colors.
- **Page theme: LIGHT.** Base background `#f2f1ed`; alternate sections `#f8f7f3`; body text `#17150f`; muted text `#5c584e`. Only THREE dark inversion sections (near-black `#17150f` with white text): Big Reveal, Tangible Symbol, and Footer. Everything else stays light.
- **Font: Lato** (Google Fonts, weights 400/700/900) for ALL text — headlines, body, buttons. Monospace only for countdown digits.
- **Buttons: GREEN, never orange.** Every CTA button: solid `#1e9e46` background, white text, 15px border-radius, no border, padding ~14px 38px, subtle green glow shadow (`0 8px 20px -8px rgba(30,158,70,.55)`). Two-line buttons: bold main line + small lighter logistics line.
- **Accent orange `#f14e1c`** is used ONLY for: headline emphasis (italic key phrase with a translucent orange highlight-marker underline), "FREE!"/value callouts in the value stack, and small labels. NEVER on buttons or backgrounds.
- **Cards:** white background, 1px hairline border `rgba(0,0,0,.09)`, 16px border-radius, soft shadow.
- **Countdown timers:** dark near-black pills (`#17150f`) with white digits, rounded ~9px.
- **Image placeholders: REQUIRED.** Every image slot in the section spec below must be rendered as a visible labeled placeholder block (light diagonal-stripe background, 1px dashed border `#c9c5ba`, 14px radius, centered small mono label describing what goes there, e.g. "HERO IMAGE — host or avatar moment") until real assets are supplied. Do not skip or substitute them.
- Generous whitespace; very large headlines with the ONE key phrase italicized + orange-highlighted.

### Variables (fill these in first)
- {EVENT_NAME}: name of the challenge, e.g. "One Comma Club Challenge"
- {EVENT_TYPE}: "Challenge" / "Bootcamp" / "Workshop"
- {HOST_NAME} + {CREDIBILITY_LINE}: who's teaching and why they're qualified
- {MECHANISM}: the vehicle, e.g. "AI + Funnels"
- {MILESTONE}: the concrete first win, e.g. "your first $1,000 online"
- {AFTER_IDENTITY}: the belief quote, e.g. "I can actually do this!"
- {TIMEFRAME} + {DAILY_COMMITMENT}: e.g. "5 days" + "90 minutes a day"
- {EVENT_DATES} + {EVENT_TIME}
- {AVATARS}: 3–4 audience segments to call out
- {N_DAYS} day-by-day agenda: per day a Title, Theme, Paradigm-shift quote, Pain-addressed quote
- {STACK_ITEMS} + dollar values, {TOTAL_VALUE}, {ANCHOR_PRICE}
- {FREE_BONUS} + {BONUS_VALUE}
- {WHY_FREE_STORY}: mission-driven reason the event is free
- {COMPANY}, {ADDRESS}, legal links, {EARNINGS_DISCLAIMER}

### Section-by-section spec
1. **Announcement bar** — sticky dark strip: "● LIVE — Join the {EVENT_NAME} for FREE! Dates: {EVENT_DATES}".
2. **Hero** — eyebrow line, giant headline "{MECHANISM} can be used to create {MILESTONE}" with the mechanism italicized/underlined; objection-killer subhead ("No product. No audience. No experience."); 16:9 VSL video embed above the fold ("turn on your sound"); "HURRY! Starts in" + live countdown timer; primary CTA button with two lines (big promise + small logistics line).
3. **Opt-in popup** — triggered by every CTA: urgency header, mini countdown, Full Name / Email / Phone (optional) fields, notification consent note, submit button, full compliance fine print (contact consent, Terms, Privacy).
4. **Qualifier** — call out the avatar: "For anyone {struggling} but still hasn't {result}… You're {TIMEFRAME} away from going from '{before identity}' to '{AFTER_IDENTITY}!'" + hero image.
5. **Offer teaser** — restate promise, countdown, CTA, then "PLUS!" bonus reveal: {FREE_BONUS} (${BONUS_VALUE} value) FREE, with product image.
6. **Shortest-path claim** — "shortest path" headline restating the promise, CTA (the VSL video lives in the hero).
7. **Sales letter** — "You don't need another {webinar/course/tutorial}… What you need is {PROOF}!" then a long-form letter: "From: {HOST_NAME} / Dear friend," — short punchy one-line paragraphs, pain narrative, the world-change agitation, pivot to "you need your first win", ending "That's why I created the…". Sprinkle 2–3 supporting/proof images.
8. **Big reveal** — dark full-bleed section: icon, giant "{EVENT_NAME}!" title, tagline, restated promise with {DAILY_COMMITMENT}, CTA.
9. **Who this is for** — playful dismissal of already-successful readers, then bullet list of {AVATARS}, closing "…then this is made specifically for YOU!"
10. **What it's NOT + authority** — ❌ bullet list of things NOT taught ("they're all distractions"), then host photo + {CREDIBILITY_LINE} + mission statement + famous proof artifact.
11. **Milestone reframe** — why the FIRST win matters more than the big win: certainty / confidence / stop doubting / see the scalability bullets. CTA.
12. **Agenda** — one card per day (Day 0…{N_DAYS}): Day title, THEME, PARADIGM SHIFT quote, PAIN ADDRESSED quote, illustration, CTA under every card. Close: "No theory. No fluff. Just {real skill}."
13. **Tangible symbol** — dark section, award/trophy imagery: "You deserve something you can hold… '{AFTER_IDENTITY}.'"
14. **Before/After** — two columns: 5–6 pain bullets (BEFORE) mirrored by 5–6 result bullets (AFTER). CTA.
15. **"What's my investment?"** — price anchor (${ANCHOR_PRICE}+ value) → it's FREE → {WHY_FREE_STORY} → honest expectation ("can't guarantee results, but some of you will hit {MILESTONE} during the event").
16. **Final urgency** — "So what are you waiting for?! Register now for FREE!" + permission-to-win close + warm welcome line.
17. **Value stack** — itemized list, each row bolded item + "FREE! (${value})" in CTA color; "Normally ${TOTAL_VALUE} → Today's Price: FREE!"; CTA.
18. **Logistics** — three cards: WHAT (format + promise), WHEN (dates/times + calendar note), WHY (the belief payoff).
19. **Imagine close** — "Imagine your life in {TIMEFRAME}…", final CTA, sign-off "See you in the {EVENT_TYPE}, {HOST_NAME}", and a P.S. that recaps the entire offer in one paragraph for skimmers.
20. **FAQ accordion** — 8–10 questions: replays? cost? why free/what's the catch? how fast are results (expectation-setting)? who's it for? no {prerequisite}? tech skills? daily time? what do I get? where do I register? Each answer re-sells. CTA after.
21. **Footer** — logo, {COMPANY} © {YEAR}, address, Terms/Privacy/Support links, full earnings disclaimer in small gray text.

### Rules
- Every CTA is the SAME action (open the opt-in popup) and the same button style; repeat it after roughly every other section (~10 total).
- Countdown timers are live and consistent (hero, popup, teaser).
- Headline rhythm: alternate huge H1 claims with supporting H2s; italicize/underline the ONE key phrase per headline.
- Keep paragraphs 1–2 sentences; long-form letter uses one-line paragraphs.
- Max 2 background colors (light + dark inversion sections at big reveal, tangible symbol, footer).
- All imagery as labeled placeholders until real assets are supplied (see STYLING block — placeholders are mandatory, one per image slot named in the spec).
- Final check before delivering: page is LIGHT, font is Lato, every button is GREEN #1e9e46 with 15px radius, orange appears only as accent, every image slot has a labeled placeholder.

---

Section numbers here match the numbered tags on the wireframe, so you can reference both together ("make section 13 cards horizontal", etc.).

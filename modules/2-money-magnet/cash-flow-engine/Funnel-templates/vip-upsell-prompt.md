# VIP Upsell Page (Step 2) — Replication Prompt

Use with `VIP Upsell Wireframe.dc.html` / `vip-upsell-wireframe-standalone.html`. This is the post-registration upsell: visitor just opted in on the challenge page, lands here as STEP 2 of 3, and is pitched a paid VIP upgrade ($97, one-time). No free trials. Checkout cart sits at the bottom of the page; every CTA scrolls to it.

---

## THE PROMPT

Build a single-page VIP upsell / one-time-offer page following the 15-section framework below. Single conversion goal: submit the checkout form at the bottom (#checkout anchor). No nav, no exits except the "no thanks" downsell link.

### STYLING — MATCH THE TEMPLATE EXACTLY (non-negotiable)
Replicate the reference template's styling identically. Do NOT invent your own theme, do NOT make the page dark, do NOT change button colors.
- **Page theme: LIGHT.** Base background `#f2f1ed`; alternate sections `#f8f7f3`; checkout section `#eceae4`; body text `#17150f`; muted text `#5c584e`. Only TWO dark inversion sections (near-black `#17150f` with white text): The Pitch (section 6) and the Footer. Everything else stays light.
- **Font: Lato** (Google Fonts, weights 400/700/900) for ALL text — headlines, body, buttons, form fields. Monospace only for countdown digits.
- **Buttons: GREEN, never orange.** Every CTA button: solid `#1e9e46` background, white text, 15px border-radius, no border, padding ~14px 38px, subtle green glow shadow (`0 8px 20px -8px rgba(30,158,70,.55)`).
- **Accent orange `#f14e1c`** ONLY for: italic key-phrase emphasis with translucent orange highlight-marker, value-stack callouts, small labels. NEVER on buttons or backgrounds.
- **Cards/checkout:** white background, 1px hairline border `rgba(0,0,0,.09)`, 16px radius, soft shadow. Order bumps: dashed amber border `#d9a441` on cream `#fffdf6`. Inputs: white, 1px border `#d8d5cc`, 10px radius.
- **Countdown timers:** dark near-black pills (`#17150f`) with white digits.
- **Image placeholders: REQUIRED.** Every image slot named in the spec (hero video, celebration image, each benefit's side image, bump thumbnails) renders as a visible labeled placeholder block (light diagonal-stripe background, dashed border `#c9c5ba`, 14px radius, small mono label) until real assets are supplied. Benefit images alternate sides: 7 right, 8 left, 9 right, 10 left.
- "No thanks" links: small, muted gray, underlined plain text.

### Variables
- {VIP_OFFER_NAME}: e.g. "VIP Backstage Pass"
- VIP price: $97 one-time; {VIP_ANCHOR_PRICE}: the crossed-out "normally" price
- {HOST_NAME} / {HOST_FIRST_NAME}, {EVENT_TYPE}, {EVENT_NAME} (from page 1)
- {TOOL_NAME}: the software whose access is included with VIP (no trial, no recurring-billing language)
- {BENEFIT_1..4}: VIP benefits (exclusive access, extended access, mechanism training, tool trial) with anchors ({BENEFIT_1_ANCHOR} e.g. $25,000+)
- {TRAINING_BULLET_1..5}: what the bonus training covers
- {STACK_1..6} + values, {TOTAL_VALUE}
- {BUMP_1_NAME/PRICE/PITCH}, {BUMP_2_NAME/PRICE/PITCH}: order bumps in the cart
- {DEADLINE_MINUTES}: evaporating countdown (e.g. 15:00)
- {DECLINE_URL}: confirmation page for the "no thanks" path
- {COMPANY}, {ADDRESS}, {EARNINGS_DISCLAIMER}

### Section-by-section spec
1. **Header + step warning** — red alert strip: "STEP 2 of 3 — Don't exit this page or click 'Back'". No logo.
2. **Congrats hero** — "Congrats! You're in!" headline; "watch this short video to maximize your experience"; "UPGRADE CLOSES IN" + {DEADLINE_MINUTES} countdown; "You will only see this video ONCE — PLAY NOW!"; 16:9 video embed; directly under the video: the green "$97 upgrade" button plus a verbose "No thanks" text link to {DECLINE_URL}.
3. **Congratulation letter** — "Dear Friend" letter validating the action they just took, with 3 identity-shift bullets (from {old} → to {new}).
4. **Countdown + first CTA** — repeated countdown + green "Upgrade For FREE!" button scrolling to #checkout.
5. **Momentum** — "You've already done the hardest part" — most people stay in research mode; you're here; pivot question.
6. **The pitch** (dark section) — "How would you like the 'unfair advantage'… {DESIRED_RESULT} 100X faster?" Invite to upgrade: ~~${VIP_PRICE}~~ FREE. "The challenge teaches you everything… but VIP is where everything clicks."
7. **Benefit #1: exclusive access** — daily private session, status metaphor ("backstage at a concert"), big price anchor "included".
8. **Benefit #2: "But that's not all!"** — extends benefit #1 across every day.
9. **Benefit #3: mechanism training** — open with the fear objection ("Will AI replace me?"), flip it, then 5 bold training bullets (formula, why-most-do-it-wrong, exact prompts, ethical modeling, rapid testing). Note: "perfect even for total beginners."
10. **Benefit #4: the tool (included)** — straight-talk framing, blueprint-without-a-hammer metaphor, social proof ("what I use, what winners use"), access included with VIP + ROI story ("one sale and your $97 pays for itself").
11. **Value stack** — 6 itemized rows with values/(PRICELESS!), "Normally ${TOTAL_VALUE}+ → Today: Just $97!", CTA, then the verbose guilt-framed "No thanks" downsell link to {DECLINE_URL}. (Stack + CTA + no-thanks repeats once more after section 13.)
12. **Philosophy close** — "{YEARS}+ years… people who go ALL IN get results… because they made a decision." Upgrade = commitment to self. "Just $97 — less than a night out."
13. **"One more thing"** — FOMO: host builds inside {TOOL_NAME} during the event; without it you watch from the sidelines; build DURING, not after. Signature, CTA, no-thanks.
14. **Checkout cart (#checkout)** — headline restating the $97 offer; green YES-affirmation box; contact fields (first/last/email/phone + reassurance line); shipping address; "billing same as shipping" checkbox; card field with secure-checkout / one-time-payment note; TWO order bumps as dashed-border checkbox boxes (name, price, pitch, thumbnail, "today only"/scarcity); live summary (VIP $97.00 + selected add-ons); "YES! Upgrade Me To VIP — $97!" submit; fine print (one-time payment, keep bonuses for life, optional {GUARANTEE_LINE}); guest checkout + returning-customer OTP prefill + "Processing payment, don't leave" state; final no-thanks link.
15. **Footer** — logo, company/copyright/address, Terms/Privacy/Support, earnings disclaimer.

### Rules
- Every CTA scrolls to the #checkout cart (no popup on this page); ~5 CTAs total.
- The "no thanks" link appears 3 times, always verbose and guilt-framed, always to {DECLINE_URL}.
- Evaporating countdown (~15 min) appears at least twice near the top.
- Alternate light sections with exactly two dark inversions (6 and 15).
- Benefits ordered: status → more status → mechanism → tool. Price is always "just $97" against big anchors — never "free", never trial or recurring-billing language.
- Each benefit section (7–10) pairs its description with a side image, alternating right/left (7 right, 8 left, 9 right, 10 left).
- All imagery as labeled placeholders until real assets are supplied (see STYLING block — placeholders are mandatory).
- Final check before delivering: page is LIGHT, font is Lato, every button is GREEN #1e9e46 with 15px radius, orange appears only as accent, every image slot has a labeled placeholder.

Section numbers match the numbered tags on the wireframe.

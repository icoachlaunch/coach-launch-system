---
name: cl-dragon-fire-ads-plan
description: "Dragon Fire Ads™ Plan — builds a business's Ad System Map, the roadmap every other ad skill reads: the 19-ad pack across four stages (Attract 4 · Engage 7 — the paid Pixie Dust Social™ layers — and Convert 5 · Motivate 3 — Dragon Fire Ads™), which Goliath Content™ Map rows feed each ad, what the business records, the 14-day calendar with the budget weighted into the last 7 days and the stage floors, objectives, audiences, KPIs and the 7-day Engage rotation. For Coach Launch or a client; re-run each cycle to roll the calendar, the reminder date and the Engage content forward. Always asks Guided or Fast. Use whenever someone wants an ad plan, ad roadmap, ad calendar, budget split, targeting, 'what ads do we need' or to set up Dragon Fire Ads™ or paid Pixie Dust Social™ — even if they just say \"plan [client]'s ads\"."
---

# Dragon Fire Ads™ Plan — the Ad System Map

Coach Launch · The $100K Day Engine™ · Client Flywheel™ · Steps 8–9 · Pixie Dust Social™ + Dragon Fire Ads™

This is the first skill of the ad system. It doesn't write ads. It decides **which ads exist, where each one
comes from, when it runs, who sees it, what it costs and what to watch**, so every later skill (copy, statics,
video scripts, the Descript edit) just executes a slot. The system is deliberately small: one pack of 19 ads,
built one stage at a time, so no business is ever overwhelmed.

| # | Stage | System | Slots | Job |
|---|---|---|---|---|
| 1 | **Attract** | Pixie Dust Social™ (paid) | 4 | Awareness — educational, speaks to the avatar, builds the warm audiences |
| 2 | **Engage** | Pixie Dust Social™ (paid) | 7 | Retarget the circle of influence — one piece a day, refreshed every 7 days |
| 3 | **Convert** | Dragon Fire Ads™ | 5 | Fill the virtual event — registrations or ticket sales |
| 4 | **Motivate** | Dragon Fire Ads™ | 3 | Retarget registration-page visitors in the last 7 days — remind, motivate, get them there live |

The method is Coach Launch's own and the one it teaches (the Pixie Dust Social™ Cheat Sheet and the Dragon Fire
Ads Formula): virtual events run fortnightly (sometimes monthly), Convert never runs more than 14 days out, and
the budget is weighted into the last 7 days.

## How this file is laid out

- `references/slots.md` — the four stages, the 19 slots, content types, which map rows feed each. Before Stage 2.
- `references/calendar-and-audiences.md` — the window, the budget model and floors, objectives, audiences, KPIs,
  PIXIE and FIRE, the setup checklist. Before Stage 3.
- `references/map-template.md` — the output contract. When writing the file.
- `scripts/plan_tools.py` — `calendar` works out the day-by-day budget and checks the floors; `check` validates
  the finished map and writes the CSV tracker.

## 0 · First questions — one message

1. **Guided or Fast?** Always ask — for clients, Matthew and the team alike; never assume Fast. Guided: one
   stage per turn, waiting for a "go" or edits. Fast: build the whole map, then deliver it for perfecting.
2. **Who is it for** — Coach Launch, or which client?
3. **New map, or a new cycle** for a map that already exists? (A new cycle is the short path in §5.)

## 1 · The rules

- **One business per map.** Only that business's documents; never another client's or Coach Launch's material
  in a client's map. Matthew's figures ($24.6 Million / $5.2 Million) only in Coach Launch's map.
- **The client's documents are verified.** Use them as written; never ask anyone to confirm them. The only flag
  is **`[MISSING CONTENT — …]`**, naming exactly what's missing (the cycle budget, the virtual event's date, a
  real client result). Never invent a budget, a date, a result, an audience size or a link.
- **The Goliath Content™ Map is the gate.** Every slot is sourced from a map row (cited `S#·R#`). No map, or a
  map without Slingshot Hooks™ → stop and name `cl-goliath-content-map`.
- **Keep it small.** 19 slots, fixed. More ads come from winners, never by padding the first pack.
- **Convert never runs more than 14 days out.** Attract and Engage are always on, at a small budget.
- **Only the Motivate ads carry a date** — the date of the virtual event, nothing else. Every other ad is evergreen.
- **The promise runs through every ad, and the page matches it.** The map locks one promise for the cycle —
  the $Million Promise™, verbatim — and 3–5 avatar callout variants every ad opens with (statement, question, gate, direct address — all on the
  Ideal Audience; with an open Advantage+ audience the callout is what finds the right people, and varying it
  tests which words find them best). The registration page's headline must
  carry the same promise: ✔, or ✗ with the page fix handed to `cl-cash-flow-funnel-builder` before Convert goes
  live, or a declared promise test (P1 → page A, P2 → page B, variants from the promise's stored Currency
  Options) until a winner is locked everywhere.
- **Sell the dream outcome.** Each slot's working idea is the map's title, which already sells the outcome; never
  swap it for a description of the tool.
- **Copy rules carry into the working ideas:** never a bare "event" or "room" (virtual event, the format, virtual
  room), no "the" in front of a system or tool name, the business's Brand Voice and spelling (Australian unless
  they write otherwise).
- **The result drives; the system stays unnamed.** The $Million Promise™'s core result leads the ads. The
  signature system (the Magic Formula™ name) is never named in an ad slot — the Event Magnet™ tool and the result
  hook; the system is introduced inside the virtual event. A map title that names the system is reworded for the
  slot (keep its citation).
- **Every ad links from its text.** The plan's destination URLs (per ad set in a promise test) go in "The promise"
  section; the copy puts them in a 👉 line in every primary text as well as the button.
- **No forecasts.** KPIs are named as what to watch, never given values.
- **The map is read by the business.** Plain words, white space, a short "Your to-do" up front. Slot codes and
  act names stay in the tables.

## 2 · Inputs and the gate

Read the business's `CONTEXT.md` and folder READMEs first (paths in `references/slots.md` §1).

| Input | Status | Gives the plan |
|---|---|---|
| **Goliath Content™ Map** (`.md` + `.csv`) | **Required — gate** | Every slot's source row and working idea |
| **Event Magnet™ Spec** | **Required** | The magnet Convert and Motivate sell; B2 walk-away; B6 registration bullet |
| **SCORE™ Card** | **Required** | Real proof (does CV4 / EN7 run on proof or swap?); the close |
| **The virtual event facts** | **Required — ask** | Format, free or paid, schedule, next date, start time and time zone, registration page link |
| **Cycle budget** | Ask | The calendar's money. None → the calendar runs in percentages and carries `[MISSING CONTENT — ad budget per cycle]` |
| Platforms | Ask (default Facebook + Instagram) | YouTube / LinkedIn rows in the stage settings |
| Money Model | Recommended | Free or paid entry; target cost per registration / ticket |
| Golden Avatar™ | Recommended | Geography, age, interest layers |
| Event Magnet™ Visual (canvas link) · Brand Voice · BRAND KIT | Recommended | Linked for the copy and statics skills |
| Past ad results (operator) | Bonus | Winning slots keep their row; tired ones swap |

A map built before the Event Magnet™ existed has no magnet section → Convert and Motivate source from the hot
step's section, Engage week 1 moves to the next step, and the plan says once that `cl-goliath-content-map` should add the magnet's section (in place)
before the next cycle.

## 3 · The workflow

**Stage 1 · Read and lock the facts (checkpoint).** Read everything. Show compactly: the business, the virtual
event (format, free/paid, schedule, next date, start time, time zone), the registration link, the Event Magnet™,
the map (version, sections; which is M, which is H), real proof available, the budget, the platforms, and every
gap. Ask only what the documents can't answer.

**Stage 1b · Lock the promise (checkpoint).** Write "The promise" section: the promise, the callout, the
page headline (read from the registration page), and the message match. Raise a ✗ before anything else is built.

**Stage 2 · Fill the 19 slots (checkpoint).** Read `references/slots.md`. Place every slot: source row(s), working
idea (the map title, verbatim), content type, format, what it needs (record · build · edit), when it's live. Fill
the Engage rotation for weeks 1 and 2 and write the queue. One row feeds one slot.

**Stage 3 · Calendar and budget (checkpoint).** Read `references/calendar-and-audiences.md`. Run:

```
python3 scripts/plan_tools.py calendar --event 2026-11-26 --start 19:00 --tz "Australia/Melbourne" \
    --budget 1500 --currency AUD --schedule fortnightly [--attract-share 0.05] [--engage-share 0.10]
```

Paste the table into the map (D0 underspends — ads stop at the start time). Read its floor warnings: a stage under its floor means the budget is too small
for the plan — say so with the minimum it prints, and let the operator choose (raise the budget, or drop
Attract to its floor first). Never quietly shrink a stage below its floor.

**Stage 4 · Stage settings and running it (checkpoint).** For each stage: objective, audience, exclusions, KPIs
to watch (from the reference, on the business's platforms). Then the PIXIE and FIRE running cadence and the
setup checklist.

**Stage 5 · Your to-do.** The business's short action list: one filming session (Attract AT1–AT3, Convert CV2 and
CV5, Motivate MO2 — 6 scripts), the 7 Engage pieces for week 1 (and week 2 if batching), what to publish as posts
first, the links and budget to send, and the next skill to run. Plain words.

### Check and deliver

1. Write the map with `references/map-template.md` exactly.
2. `python3 scripts/plan_tools.py check ad-system-map.md --client "<Business>" --tool "<Event Magnet name>"
   --map goliath-content-map.csv --csv ad-system-map.csv` (use `--coach-launch` instead of `--client` for
   Coach Launch). Fix every FAIL, read every WARN. The CSV is written only on a PASS.
3. Save both in `Client Engine/Client Flywheel/dragon-fire-ads/` in the business's folder (Coach Launch: the same
   path in `CLIENT ENGINE`). One canonical file — never a `-v2`; a change bumps `version` and adds a Revision
   History row. Save the `.md` to the business's claude.ai Project too if attached. Update the business's
   `CONTEXT.md` (Dragon Fire Ads™ row, `last_updated`).
4. In the chat: the next virtual event and its window, the budget by stage, the to-do in one line, the **missing
   content list**, and the next step — *"Run `cl-dragon-fire-ads` for the Convert pack (CV1–CV5)."* Don't paste
   the map as well as the file.

## 4 · The packs, in order

One pack at a time: **Convert (CV1–5) → Motivate (MO1–3) → Attract (AT1–4) → Engage (EN1–7)**. Convert first
because it fills the virtual event; Motivate next because it's the quickest lift in show-up. The status column
tracks each slot: `planned → copy → creative → live`.

## 5 · A new cycle — the short path

1. Read the map. Ask only for the new date (and a new budget if it changed).
2. Re-run `calendar` and replace the calendar.
3. Motivate: the new date goes in; MO2 is re-edited with the new date in Descript (no re-shoot).
4. Engage: move the rotation on (the week just run becomes history; the next two weeks fill from the queue).
5. Swap any slot the operator says has tired — the next unused row of the same act in the same section. FIRE:
   new creatives every 7–14 days.
6. Bump the version, add a Revision History row, re-run `check`, save.

## 6 · Boundaries

- Plans only. Copy, statics and video come from the other skills (`cl-dragon-fire-ads` builds the Convert pack
  today).
- No predicted CPL, CTR, ROAS, reach or show-up rates. Budgets are the operator's or the Money Model's; targets are
  the Money Model's.
- Doesn't create or edit campaigns in Ads Manager.
- Asked for more than 19 ads → "The first pack stays at 19 so it gets done. Winners earn the next ads."
- Asked to run Convert more than 14 days out → "The window is 14 days; earlier spend lowers show-up. Attract and
  Engage keep warming the audience in between."

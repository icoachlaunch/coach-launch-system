---
name: kie-image-gen
description: Generate images with the Kie.ai API from text prompts and save them to a local folder. Use whenever the user wants to create, generate, or regenerate images, headshots, avatars, a graphics/asset pack, product shots, or illustrations using their Kie.ai account or API key. Handles single images and batches, and downloads the results onto the user's machine.
---

# Kie.ai image generation

Generate one or many images from text prompts via the Kie.ai jobs API, then download
them to a folder on the user's computer. Built and verified 2026-07-11.

## The one thing to know about the environment

Two network facts drive this whole workflow:

1. The sandbox **can reach `api.kie.ai`** (submit jobs, poll status) but **cannot reach
   the image CDN** (`tempfile.aiquickdraw.com` and friends are firewalled, and `web_fetch`
   returns nothing for them). So the sandbox can *generate* but not *download*.
2. The **Desktop Commander local MCP runs on the user's own machine**, which has normal
   internet access. So downloading is done there.

Net result: **generate in the sandbox → get result URLs → download via Desktop Commander.**

## Model

Use **`google/nano-banana`** (Gemini 2.5 Flash Image, ~4 credits/image, fast).
`google/imagen4` and `google/imagen4-fast` were returning instant HTTP-500
"Internal Error" and should NOT be used until confirmed working again. `flux-*`,
`seedream`, `qwen/*`, `gpt4o-image`, `mj/*` model names returned 422 "not supported."
If you need a different model, first probe it with one createTask call and confirm
`state` reaches `success` before batching.

## The API key

Ask the user for their Kie.ai API key. **Never write it to a file, the dashboard, or
any committed artifact.** Pass it only as an in-memory environment variable
(`KIE_KEY`) for the generation run.

## Steps

1. **Collect the spec** from the user (or infer it): for each image, a short `name`
   (used as the output filename) and a `prompt`; plus a shared `aspect_ratio`
   (e.g. `1:1`, `16:9`, `4:5`) and the destination folder on their machine.
   For a *matched set* (team, pack), write one shared style suffix and append it to
   every prompt so lighting/background/framing stay consistent.
   Ask **how many options per image** they want (`variations`): `1` = preview-then-
   approve (fewer credits), `2-4` = generate options to choose between.

2. **Write a spec JSON** (see `scripts/spec.example.json`) to the working dir, e.g.:
   ```json
   {
     "model": "google/nano-banana",
     "aspect_ratio": "1:1",
     "variations": 1,
     "images": [
       {"name": "maya",  "prompt": "A friendly woman ... , <shared style suffix>"},
       {"name": "leo",   "prompt": "A friendly man ... , <shared style suffix>"}
     ]
   }
   ```
   Set `variations` globally, or per-image (`{"name": "...", "prompt": "...", "variations": 3}`).

3. **Generate** (in the workspace sandbox — `api.kie.ai` is reachable here):
   ```bash
   KIE_KEY="<key>" python3 scripts/generate.py spec.json results.json
   ```
   It submits every image (× variations), polls `recordInfo`, and writes
   `results.json` = `{ "name": ["https://.../a.png", "https://.../b.png"], ... }`
   (always a **list** of candidate URLs per name). The URLs are on a **temporary**
   CDN — preview and download promptly.

4. **PREVIEW — always do this before downloading (this is the whole point).**
   Render the candidates in an in-chat `show_widget` gallery: one card per candidate,
   grouped by image name, with the name (and option number when `variations > 1`)
   labelled. The user's browser loads the CDN fine even though the sandbox can't.
   Then wait for the user to decide:
   - single mode (`variations: 1`) → they approve keepers and flag any to **regenerate**;
   - variations mode → they **pick one option per name**.
   For anything they want changed, tweak that image's prompt and re-run step 3 for
   just those names (make a small spec with only those images). Loop until approved.
   NEVER download before the user has seen and approved the images.

5. **Build the approved map** `approved.json` = `{ "name": "chosen_url", ... }`
   (single URL per name — the ones the user picked/approved). Easiest via a tiny
   inline python/bash step that reads `results.json` and writes the chosen URLs.

6. **Download onto their machine via Desktop Commander** (runs locally):
   ```
   powershell -NoProfile -ExecutionPolicy Bypass -File "<abs path>\scripts\download_images.ps1" -ResultsJson "<abs>\approved.json" -OutDir "<abs dest folder>" -Ext jpg
   ```
   Then verify with `cmd /c dir /-c "<dest>\*.jpg"` — files should be tens/hundreds of KB,
   not a few bytes (tiny files = an error page, not an image).

7. If Desktop Commander is **not** connected, hand the user `scripts/download_images.ps1`
   (and the `approved.json`) and tell them to run it, or offer to add the local MCP.

## Preview gallery pattern (show_widget)

Build a responsive grid, one card per candidate URL. Group by image name; when
`variations > 1`, label each "Name · option N" so the user can say e.g. "Maya option 2,
Leo option 1." Cards should show the image at a decent size (square `object-fit: cover`
for headshots) so the user can actually judge them. Keep all explanatory text outside
the widget. This gallery is the decision point — surface it and stop for input.

## Desktop Commander gotcha

When you pass PowerShell to Desktop Commander with `-Command "..."`, `$` variables get
stripped in transit (so `$_`, `$env:`, inline `$x` break). Work around it by:
- running **`.ps1` files** with `-File` (variables inside the file are safe), or
- using **`cmd /c ...`** commands that need no `$`.
Do not rely on inline `$` in a `-Command` string.

## API reference (for building/patching the scripts)

- Auth header: `Authorization: Bearer <KIE_KEY>`, `Content-Type: application/json`
- Submit: `POST https://api.kie.ai/api/v1/jobs/createTask`
  body: `{"model":"google/nano-banana","input":{"prompt":"...","aspect_ratio":"1:1"}}`
  → `{"code":200,"data":{"taskId":"..."}}`  (422 = bad model name; 401 = bad/missing key)
- Poll: `GET https://api.kie.ai/api/v1/jobs/recordInfo?taskId=<id>`
  → `data.state` in `waiting|queuing|generating|success|fail`
  → on success: `JSON.parse(data.resultJson).resultUrls[0]` is the image URL
  → on fail: `data.failMsg` / `data.failCode`
- nano-banana input: only `prompt` + `aspect_ratio` are needed. It does NOT need
  `negative_prompt` or `seed`; leave them out to avoid surprises.

## Files in this skill

- `scripts/generate.py` — sandbox: submit + poll all images, write `results.json`.
- `scripts/download_images.ps1` — local (Desktop Commander): download `results.json` URLs to a folder.
- `scripts/spec.example.json` — a ready-to-edit example spec (the 6-agent matched set).

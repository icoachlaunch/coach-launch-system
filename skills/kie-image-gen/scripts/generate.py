#!/usr/bin/env python3
"""Generate images via the Kie.ai jobs API and write result URLs to JSON.

Runs in the workspace sandbox (api.kie.ai is reachable there). It does NOT
download the images -- the image CDN is firewalled from the sandbox. Preview the
URLs with the caller (show_widget gallery), then hand the APPROVED URLs to
Desktop Commander + download_images.ps1 to save them locally.

Usage:
    KIE_KEY="<key>" python3 generate.py spec.json [results.json]

spec.json:
    {
      "model": "google/nano-banana",
      "aspect_ratio": "1:1",
      "variations": 1,               # optional, default 1: candidates per image
      "images": [
        {"name": "maya", "prompt": "...", "variations": 3},  # per-image override
        {"name": "leo",  "prompt": "..."}
      ]
    }

Output (results.json): every image maps to a LIST of candidate URLs, so previews
and variations work uniformly:
    { "maya": ["https://.../a.png", "https://.../b.png"], "leo": ["https://.../c.png"] }
"""
import json, os, sys, time, urllib.request

BASE = "https://api.kie.ai/api/v1/jobs"


def _key():
    k = os.environ.get("KIE_KEY", "").strip()
    if not k:
        sys.exit("ERROR: set the KIE_KEY environment variable to your Kie.ai API key.")
    return k


def post(path, payload, key):
    req = urllib.request.Request(
        BASE + path,
        data=json.dumps(payload).encode(),
        headers={"Authorization": "Bearer " + key, "Content-Type": "application/json"},
    )
    return json.load(urllib.request.urlopen(req, timeout=30))


def get(path, key):
    req = urllib.request.Request(BASE + path, headers={"Authorization": "Bearer " + key})
    return json.load(urllib.request.urlopen(req, timeout=25))


def main():
    if len(sys.argv) < 2:
        sys.exit("Usage: KIE_KEY=... python3 generate.py spec.json [results.json]")
    key = _key()
    spec = json.load(open(sys.argv[1], encoding="utf-8"))
    out_path = sys.argv[2] if len(sys.argv) > 2 else "results.json"

    model = spec.get("model", "google/nano-banana")
    aspect = spec.get("aspect_ratio", "1:1")
    default_var = int(spec.get("variations", 1))

    # Submit every (image, variation) as its own task. task_id -> (name, idx)
    tasks = {}
    for img in spec["images"]:
        n = int(img.get("variations", default_var))
        for idx in range(1, n + 1):
            r = post("/createTask", {"model": model,
                                     "input": {"prompt": img["prompt"], "aspect_ratio": aspect}}, key)
            if r.get("code") != 200:
                print(f"  ! {img['name']} v{idx}: createTask {r.get('code')} {r.get('msg')}")
                continue
            tid = r["data"]["taskId"]
            tasks[tid] = (img["name"], idx)
            label = img["name"] if n == 1 else f"{img['name']} (option {idx})"
            print("submitted", label, tid)

    print("--- polling ---")
    results = {}          # name -> list of urls (ordered by option idx)
    order = {}            # name -> {idx: url}
    pending = set(tasks)
    for _ in range(50):
        if not pending:
            break
        time.sleep(7)
        for tid in list(pending):
            name, idx = tasks[tid]
            try:
                d = get("/recordInfo?taskId=" + tid, key)["data"]
                st = d.get("state")
                if st == "success":
                    url = json.loads(d["resultJson"])["resultUrls"][0]
                    order.setdefault(name, {})[idx] = url
                    pending.discard(tid)
                    print("OK  ", name, "option", idx, url)
                elif st == "fail":
                    pending.discard(tid)
                    print("FAIL", name, "option", idx, d.get("failMsg"))
            except Exception as e:  # noqa
                print("poll err", name, e)

    for tid in pending:
        name, idx = tasks[tid]
        print("TIMEOUT", name, "option", idx)

    for name, by_idx in order.items():
        results[name] = [by_idx[i] for i in sorted(by_idx)]

    json.dump(results, open(out_path, "w"), indent=2)
    total_urls = sum(len(v) for v in results.values())
    print(f"\nwrote {total_urls} candidate URL(s) across {len(results)} image(s) -> {out_path}")
    print("NEXT: preview these with the user (show_widget gallery), build an approved")
    print("      map {name: chosen_url}, then download via download_images.ps1.")


if __name__ == "__main__":
    main()

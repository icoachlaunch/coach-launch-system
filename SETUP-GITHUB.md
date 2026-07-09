# Put Coach Launch on GitHub — one-time setup

This makes `coach-launch-system/` your core style-guide repo. Then every new guide or prompt is one commit away, and you can reference the raw files from any other platform.

---

## Step 0 — clean up two sandbox leftovers first

Before anything, delete these from the `coach-launch-system` folder on your computer (they're harmless artifacts from the build sandbox and can't be removed automatically):

- `.git`  ← a broken, empty folder. Delete it so a fresh repo initializes cleanly.
- `style-guide-synctest.txt`  ← a scratch test file.

On Windows: turn on "Hidden items" in File Explorer's View menu to see `.git`, then delete both.

---

## Easiest path — GitHub Desktop (no command line)

1. Install **GitHub Desktop** from desktop.github.com and sign in (create a free GitHub account if you don't have one).
2. **File → Add Local Repository →** choose the `coach-launch-system` folder. When it says "this isn't a Git repository," click **Create a Repository** and confirm.
3. Give it the name `coach-launch-system`, leave the rest default, click **Create Repository**.
4. You'll see all the files listed as changes. Type a summary like `Initial Coach Launch style + voice guide` and click **Commit to main**.
5. Click **Publish repository** (top right). Choose **Private** (recommended) or Public, then **Publish**.

Done. Every future change: commit + push from the same window.

---

## Command-line path (if you have Git installed)

```bash
cd path/to/coach-launch-system

git init
git add -A
git commit -m "Initial Coach Launch style + voice guide"

# create an empty repo named coach-launch-system on github.com first (no README),
# then point at it and push:
git remote add origin https://github.com/<your-username>/coach-launch-system.git
git branch -M main
git push -u origin main
```

Not sure if Git is installed? Run `git --version` in a terminal. If it errors, install from git-scm.com or just use GitHub Desktop above.

---

## After it's live

- **Reference raw files** from other tools using the raw URL, e.g.
  `https://raw.githubusercontent.com/<user>/coach-launch-system/main/assets/coach-launch-guide.css`
- **Preview the guides in a browser** for free by enabling **GitHub Pages** (Settings → Pages → Source: `main` / root). Your index becomes a shareable link.
- **Adding new work:** drop the file in the right folder (`guides/`, `prompts/`), commit, push. It inherits the style automatically.

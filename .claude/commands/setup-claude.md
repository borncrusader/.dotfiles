---
description: Symlink .claude/settings.local.json to ~/.dotfiles/.claude/settings.local.json
---

Set up Claude for this project:

**Step 1 — settings symlink**
1. Create `.claude/` in the current directory if it doesn't exist
2. Check `.claude/settings.local.json`:
   - Already a symlink to the right target → skip
   - A real file → warn the user, do not overwrite, stop
   - Doesn't exist → create it: `ln -s ~/.dotfiles/.claude/settings.local.json .claude/settings.local.json`

**Step 2 — AGENTS.md + CLAUDE.md**
1. Check if `AGENTS.md` exists:
   - Exists → skip creation
   - Doesn't exist → create a starter `AGENTS.md` with: project name, brief description, stack, and a note to check `docs/spec.md` and `docs/tasks.md` if they exist
2. Check if `CLAUDE.md` exists:
   - Already a symlink to `AGENTS.md` → skip
   - A real file → warn the user, do not overwrite, stop
   - Doesn't exist → create symlink: `ln -s AGENTS.md CLAUDE.md`

**Step 3 — Confirm**
Report what was created vs. skipped.

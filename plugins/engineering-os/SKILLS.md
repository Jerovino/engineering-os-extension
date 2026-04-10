# Custom Skills Guide

Engineering OS ships 16 built-in skills. You can add your own without modifying the plugin.

## How to Create a Custom Skill

1. **Copy the template**

   ```bash
   cp ~/.claude/plugins/cache/engineering-os-extensions/plugins/engineering-os/skills/_template/SKILL.md \
     <your-vault>/.claude/skills/<name>/SKILL.md
   ```

   On Windows:
   ```powershell
   Copy-Item "$env:APPDATA\Claude\plugins\cache\engineering-os-extensions\plugins\engineering-os\skills\_template\SKILL.md" `
     "<your-vault>\.claude\skills\<name>\SKILL.md"
   ```

2. **Edit the file**

   Open `<your-vault>/.claude/skills/<name>/SKILL.md` and fill in:
   - `name:` — what you'll type to invoke it (e.g., `name: standup`)
   - `description:` — one sentence Claude reads to decide when to use it
   - The Instructions section — step-by-step instructions for Claude

3. **Invoke it**

   In Claude Code, run `/<name>` (e.g., `/standup`).

No plugin changes needed. Skills in your vault's `.claude/skills/` directory are loaded
automatically by Claude Code.

## Minimal Working Example

```markdown
---
name: standup
description: Generates a standup summary from yesterday's daily note
---

# Standup Summary

Generate a concise standup from yesterday's work.

## Instructions

### Step 0: Resolve vault path

Read `~/.config/engineering-os/config` (Unix) or `%APPDATA%\engineering-os\config.ps1`
(Windows) to find `VAULT_PATH`.

### Step 1: Read yesterday's note

Find and read the most recent file in `$VAULT_PATH/log/daily/`.

### Step 2: Generate standup

Output three bullets:
- **Done:** What was completed yesterday
- **Today:** What's planned
- **Blockers:** Anything stuck (or "None")

Keep it under 5 lines total.
```

## Tips

- `name:` must be a single word or kebab-case (e.g., `standup`, `team-retro`)
- Keep Instructions concrete — Claude follows them literally
- Add a Step 0 vault path resolution to any skill that reads vault files
- Start with the `_template/SKILL.md` scaffold to get the structure right
- You can have as many custom skills as you want — they don't interfere with built-in skills

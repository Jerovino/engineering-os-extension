---
name: weekly-checkpoint
description: Run your weekly review to reflect on the past week and plan the next one
---

# Weekly Checkpoint

This skill runs your weekly review — looking back at the week, checking progress against
90-day goals, and setting direction for next week.

## Instructions

### Step 0: Resolve vault path

Read the config file to find the vault location:
- Unix/macOS: `~/.config/engineering-os/config` — parse `VAULT_PATH=...` and
  `ENGINEERING_OS_MODE=...`
- Windows: `%APPDATA%\engineering-os\config.ps1` — parse `$env:VAULT_PATH` and
  `$env:ENGINEERING_OS_MODE`

All file references in this skill use `$VAULT_PATH` as the base directory.
If the config file does not exist, tell the user: "Engineering OS is not set up.
Run `setup.sh` (or `setup.ps1` on Windows) from the plugin directory first."

Read the following files for context:
- All daily notes from the past 7 days in `$VAULT_PATH/log/daily/`
- `$VAULT_PATH/goals/90_day.md` for current quarter priorities
- `$VAULT_PATH/memory.md` for patterns and growth edges
- The most recent weekly review in `$VAULT_PATH/log/weekly/` (if one exists)

Summarize what you see from the daily notes — what got done, what patterns emerge, where energy
was spent.

Then ask me the following questions one at a time, wait for my response, then move to the next:

1. What moved the needle this week on your top 3 priorities?
2. What was noise — things that consumed time but didn't matter?
3. What's blocking progress right now?
4. How's the team? Anything I should know about health or capacity?

After I answer:

1. Create the folder `$VAULT_PATH/log/weekly/YYYY-Www/` (e.g., `log/weekly/2026-W07/`)
2. Create the weekly review at `$VAULT_PATH/log/weekly/YYYY-Www/YYYY-Www.md`
3. Move all daily notes from `$VAULT_PATH/log/daily/` that belong to this week into
   `$VAULT_PATH/log/weekly/YYYY-Www/`

This keeps the daily folder clean (current week only) and bundles each week's notes together.

Weekly review file structure:

### File Structure

```markdown
# Weekly Review — YYYY-Www

*Week of [Monday date] to [Friday date]*

---

## What Moved the Needle
[From daily notes and my answers — concrete progress on top 3 priorities]

## Noise & Time Leaks
[Things that consumed time but didn't advance priorities]

## Blockers
[What's stuck and what needs to happen to unblock]

## Team Health Pulse
[Quick read on team state — energy, capacity, morale]

## Strategic Insight
[One pattern or observation worth remembering — tag with #insight]

## Next Week's Focus
[Top 2-3 things to prioritize next week, derived from above]

## 90-Day Goal Check
[Quick status on each top 3 priority — on track / behind / ahead]

---

*Reviewed: YYYY-MM-DD*
```

After creating the review:
1. Archive completed tasks — move all `[x]` items from `tasks.md` Open Tasks section to the
   Archive section
2. Check if any insights should be added to `memory.md` — suggest them, don't add without
   confirmation

### Git Backup (mode 2 only)

Read `ENGINEERING_OS_MODE` from the config file.

If `mode=local`: Print "Vault is local-only — git backup skipped." Skip all git steps.

If `mode=repo`:
- Stage all changes in the vault directory
- Commit: "Weekly review - YYYY-Www" with co-author credit
- Push to remote repository
- Confirm success

Keep the tone direct and honest. Flag patterns from `memory.md` if I'm repeating known
anti-patterns.

## Tips

- Be honest about what didn't move — avoidance is a signal
- Connect weekly activity back to 90-day goals
- Call out if time allocation doesn't match stated priorities
- If no daily notes exist for some days, note the gap — it might be a pattern
- Keep the review scannable — this should take 15 minutes, not an hour

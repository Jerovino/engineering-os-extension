---
name: daily-wrap-up
description: End your day with reflection and save your work
---

# Daily Wrap-Up

This skill helps you close your day with reflection and optionally saves your work to GitHub.

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

Read today's daily note from `$VAULT_PATH/log/daily/YYYY-MM-DD.md` to see the morning
priorities.

Run the `/process-inbox` skill to triage all items in the `## Inbox` section of
`$VAULT_PATH/tasks.md`. Move processed items to Open Tasks or the right location, and archive
them in tasks.md.

Read the meeting from today's meeting and update the daily note with any new tasks or notes
that came up during the day.

Ask me the following questions one at a time, wait for my response, then move to the next:

1. Did you achieve your top priorities from this morning? Which ones got done?
2. Any notes, tasks, or reminders for tomorrow? (If tasks are mentioned, add them to
   `$VAULT_PATH/tasks.md` Open Tasks section.)

After I answer:
1. Update today's daily note with an "Evening Wrap-Up" section including:
   - Status of morning priorities (checked off if completed)
   - Notes for tomorrow
   - Key learnings or observations from today

### Git Backup (mode 2 only)

Read `ENGINEERING_OS_MODE` from the config file.

If `mode=local`: Print "Vault is local-only — git backup skipped." Skip all git steps.

If `mode=repo`:
- Stage all changes in the vault directory
- Commit: "Daily update - YYYY-MM-DD" with co-author credit
- Push to remote repository
- Confirm success

Keep the tone reflective but brief.

## Tips

- Be honest about what didn't get done
- Capture quick notes for tomorrow while fresh
- Don't stress about incomplete tasks
- The git commit (mode 2) ensures work is backed up
- If no changes to commit, that's fine — just note it

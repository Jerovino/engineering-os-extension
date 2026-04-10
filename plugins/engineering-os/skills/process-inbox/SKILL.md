---
name: process-inbox
description: Processes tasks.md inbox items by triaging each one to its proper location in the vault
---

# Process Inbox

This skill processes your inbox — triaging each captured item to the right place in your vault.

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

Read `$VAULT_PATH/tasks.md` and identify all items under `## Inbox`.

If there are no items to process, say so and stop.

For each item, apply the processing guide from tasks.md and present a recommendation:

```
Item: [the item text]
Actionable? Yes/No
Urgent? Yes/No
Owner: Me / Team / Not me
Type: Task / Idea / Decision / Person context / Reference
Suggested destination: [specific file path]
```

Present all recommendations together, then ask:

1. Here's how I'd triage these items. Want me to proceed, or change any of them?

After I confirm (or adjust), for each item:

1. **Task (urgent)** → Add to today's daily note in `$VAULT_PATH/log/daily/YYYY-MM-DD.md`
   as a `- [ ]` item
2. **Task (not urgent)** → Add to the relevant initiative in `$VAULT_PATH/initiatives/` or
   to `$VAULT_PATH/goals/90_day.md` if it maps to a priority
3. **Idea** → Add to the relevant file in `$VAULT_PATH/frameworks/` or
   `$VAULT_PATH/initiatives/`
4. **Decision** → Create or append to a file in `$VAULT_PATH/decisions/`
5. **Person context** → Add to `$VAULT_PATH/people/@Name.md` (create if it doesn't exist)
6. **Reference / not actionable** → Delete or note why it's being dropped
7. **Delegate** → Add to the person's note in `$VAULT_PATH/people/@Name.md` with a `- [ ]`
   tag and note it's delegated

After moving each item:
- Mark it as done (`- [x]`) in tasks.md
- Move it from `## Inbox` to `## Archive`

When all items are processed, confirm what was moved where.

## Tips

- Process the inbox regularly — ideally daily or every few days
- If an item is vague, ask me to clarify before triaging
- Items that connect to 90-day goals should be flagged as higher priority
- If a file doesn't exist yet (e.g., a person note or initiative), offer to create it
- Don't overthink categorization — the goal is to get items out of the inbox and into the
  right context
- Multiple sub-items under one checkbox can be split if they belong in different places

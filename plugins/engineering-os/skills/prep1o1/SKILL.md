---
name: prep1o1
description: Prepares a 1:1 meeting with context, action items, wins, and talking points
---

# Prep 1:1

This skill prepares you for a 1:1 by pulling together context about the person, open action
items, recent wins, and feedback — then generates a prep document.

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

Ask me:

1. Who's the 1:1 with?

After I answer, gather context from these sources:

### Person Note
- Read `$VAULT_PATH/people/@[Person Name].md` if it exists
- If no person note exists, tell me and offer to create one after the 1:1

### Action Items
- Search all files in `$VAULT_PATH/log/daily/`, `$VAULT_PATH/log/weekly/`, and
  `$VAULT_PATH/meetings/` for open action items (`- [ ]`) that mention the person's name
- Include any tasks tagged with their name or team

### Recent Wins & Feedback
- Search `$VAULT_PATH/log/daily/` and `$VAULT_PATH/log/weekly/` for wins (`- [w]`) or
  feedback (`- [!]`) mentioning the person
- Search `$VAULT_PATH/meetings/` for any notes from previous 1:1s with them

### Team Context
- Check `$VAULT_PATH/teams/` for any files related to their team
- Check `$VAULT_PATH/initiatives/active/` for initiatives they're involved in

### Goals Context
- Read `$VAULT_PATH/goals/90_day.md` to identify priorities that connect to this person's work

Present what you found, then ask:

2. Anything specific you want to discuss or follow up on?

After I answer, generate the prep document and output it directly (don't save to a file).
Format:

```markdown
# 1:1 Prep — @[Person Name]
*[Date]*

## Context
[Brief summary of their current situation — role, team, what they're working on]

## Open Action Items
[All open tasks involving them, with source file references]
*If none found: "No open action items found."*

## Recent Wins & Feedback
[Any wins or feedback documented about them]
*If none found: "Nothing documented recently."*

## Talking Points
- [Derived from action items, recent context, and my specific topics]
- [Connect to 90-day goals where relevant]

## Questions to Ask
- [2-3 suggested questions based on context — career, blockers, team dynamics]

## Notes
[Empty section to fill during the meeting]
```

After showing the prep, ask:

3. Want me to save this to `$VAULT_PATH/meetings/YYYY-MM/[date]-1o1-[name].md`?

## Tips

- If the person note doesn't exist, that's a signal — create one after the 1:1
- Prioritize action items that are overdue or recurring
- Connect talking points back to 90-day goals when possible
- Suggest questions that go beyond status updates — ask about blockers, growth, team health
- Keep the prep scannable — this should take 2 minutes to read before walking into the meeting

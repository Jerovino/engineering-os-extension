---
name: morning
description: Start your day with a structured morning routine
---

# Morning Routine

This skill helps you start your day with a structured morning routine.

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

### Step 1: Gather context

Before greeting, collect today's context in parallel:

1. **Yesterday's notes** — Read the most recent daily note from `$VAULT_PATH/log/daily/`.
2. **Calendar** — Run the `/calendar` skill to get today's schedule from Google Calendar. This
   uses Playwright to navigate to Google Calendar day view, take an accessibility snapshot, and
   parse events into a markdown table.
3. **90-day goals** — Read `$VAULT_PATH/goals/90_day.md` for current priorities.
4. **Tasks** — Check `$VAULT_PATH/tasks.md` for open tasks and any new inbox items.

### Step 2: Brief the day

Present a brief greeting with:
- Summary of yesterday's carry-forward items (if any).
- Today's calendar at a glance — the parsed event table from `/calendar`, highlighting
  conflicts, tentative events needing RSVP, and estimated focus time blocks.
- Suggest the 3 most important topics to work on today based on goals and calendar shape.

### Step 3: Ask questions

Ask the following questions one at a time, wait for my response, then move to the next:

1. Which initiatives or projects are you focusing on today?
2. Any specific meeting I should help you get context with?

### Step 4: Create daily note

After I answer, create today's daily note in `$VAULT_PATH/log/daily/` with the filename format
YYYY-MM-DD.md (e.g., 2026-01-24.md):

- Date and day of week as the title.
- Today's calendar summary (event count, meeting hours, focus time).
- My top priorities as a checklist.
- Brief context for any specific meetings.

Keep the format clean and scannable.

## Tips

- Keep the greeting brief and actionable.
- Focus on what matters today.
- Don't overwhelm with too many tasks.
- If the calendar shows back-to-back meetings, flag it — suggest what to protect or reschedule.
- If an event needs RSVP, mention it early.

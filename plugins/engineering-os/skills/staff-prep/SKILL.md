---
name: staff-prep
description: Prepare for leadership team or staff meetings with context, agenda, and decisions needed
---

# Staff Meeting Prep

This skill prepares you for staff meetings or leadership team meetings by pulling together
team context, active initiatives, open decisions, and generating a focused agenda.

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
- `$VAULT_PATH/teams/health_tracker.md` (if it exists) for team health overview
- `$VAULT_PATH/initiatives/_dashboard.md` for active initiative status
- `$VAULT_PATH/decisions/decision_log.md` (if it exists) for pending decisions
- Recent daily notes from `$VAULT_PATH/log/daily/` (past 5 days)
- The most recent weekly review in `$VAULT_PATH/log/weekly/`
- `$VAULT_PATH/goals/90_day.md` for current priorities

Ask me the following questions one at a time, wait for my response, then move to the next:

1. What type of meeting is this? (Your staff meeting / skip-level group / cross-team sync /
   leadership review)
2. Who's attending?
3. Are there specific topics or decisions you need to drive?
4. Anything happening in the org that needs addressing? (Reorgs, incidents, launches, morale
   issues)

After I answer, generate the prep document and output it directly (don't save to a file).
Format:

```markdown
# Staff Meeting Prep — YYYY-MM-DD

**Type:** [Meeting type]
**Attendees:** [List]

---

## Context Since Last Meeting
[Key developments from daily notes and weekly review — what's changed]

## Agenda

### 1. [Topic — most important first]
**Goal:** [What you want from this agenda item — decision, alignment, information share]
**Context:** [Brief background]
**Ask:** [Specific ask of the group]

### 2. [Topic]
**Goal:** [...]
**Context:** [...]
**Ask:** [...]

### 3. [Topic]
**Goal:** [...]
**Context:** [...]
**Ask:** [...]

## Decisions Needed
[Any pending decisions from decision_log.md or from my input that need group input]
- [Decision] — options to present, recommendation if you have one

## Initiative Updates
[Quick status on active initiatives relevant to this group]
- [Initiative]: [One-line status]

## Team Health Signals
[Anything from team health tracker, weekly reviews, or my input that the group should know]

## Parking Lot
[Topics that came up in context but aren't urgent — save for next time]

---

*Prep generated: YYYY-MM-DD*
```

After showing the prep, ask:

5. Want me to save this to `$VAULT_PATH/meetings/YYYY-MM/YYYY-MM-DD-staff.md`?

## Tips

- Put the hardest topic first — energy is highest at the start
- Every agenda item should have a clear "ask" — no topics without purpose
- If you're sharing information only, say that — don't pretend it's a discussion
- Flag if team health signals suggest something that needs airtime
- Keep to 3-4 agenda items max — more than that and nothing gets depth
- If decisions/decision_log.md has pending items, surface them
- Connect agenda items to 90-day goals when possible

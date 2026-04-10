---
name: prep-skip-level
description: >-
  Prepares a skip-level 1:1 with person context, manager context, team health signals, and
  trust-building questions
---

# Prep Skip-Level 1:1

This skill prepares you for a skip-level 1:1 — a meeting with someone who reports to one of
your direct reports. The focus is on pulse check and trust building: team health signals,
psychological safety, career growth, and unfiltered feedback about the org.

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

1. Who's the skip-level with? (And who's their manager if not obvious from the person note?)

After I answer, gather context from these sources:

### Person Note
- Read `$VAULT_PATH/people/@[Person Name].md` if it exists
- If no person note exists, tell me and offer to create one after the skip-level

### Manager Note
- Read the person note to identify their manager (your direct report)
- Read `$VAULT_PATH/people/@[Manager Name].md` if it exists
- Surface any recent feedback, wins, or concerns documented about the manager — this gives
  you the "other side" perspective

### Action Items
- Search all files in `$VAULT_PATH/log/daily/`, `$VAULT_PATH/log/weekly/`, and
  `$VAULT_PATH/meetings/` for open action items (`- [ ]`) that mention the person's name or
  their team
- Include any tasks tagged with their name, team, or manager

### Recent Wins & Feedback
- Search `$VAULT_PATH/log/daily/` and `$VAULT_PATH/log/weekly/` for wins (`- [w]`) or
  feedback (`- [!]`) mentioning the person or their team
- Search `$VAULT_PATH/meetings/` for any notes from previous skip-levels or meetings
  involving them

### Team Context
- Check `$VAULT_PATH/teams/` for any files related to their team
- Check `$VAULT_PATH/initiatives/_dashboard.md` and `$VAULT_PATH/initiatives/active/` for
  initiatives they or their team are involved in
- Look for any team health data or engagement signals

### Goals Context
- Read `$VAULT_PATH/goals/90_day.md` to identify priorities that connect to their team's work

### Previous Skip-Level Notes
- Search `$VAULT_PATH/meetings/` for any past skip-level notes with this person

Present what you found, then ask:

2. Anything specific you want to explore or follow up on? Any signals from their manager you
   want to cross-reference?

After I answer, generate the prep document and output it directly (don't save to a file).
Format:

```markdown
# Skip-Level Prep — @[Person Name]
*[Date]*

## Context
[Brief summary — their role, team, manager, what they're working on]

## Manager Context
[Summary of their manager's situation — what you know about the team from the manager's
perspective, any recent feedback or concerns. This helps you listen for alignment or gaps.]
*If no manager note found: "No manager note on file."*

## Open Action Items
[All open tasks involving them or their team, with source file references]
*If none found: "No open action items found."*

## Recent Wins & Feedback
[Any wins or feedback documented about them or their team]
*If none found: "Nothing documented recently."*

## Team Health Signals
[Any data points about team health, engagement, workload, or morale — from team files,
reviews, or initiative notes]
*If none found: "No signals captured yet — good opportunity to ask."*

## Talking Points
- [Derived from context, team health signals, and my specific topics]
- [Connect to 90-day goals where relevant]
- [Note any gaps between manager's perspective and what you might hear]

## Questions to Ask
[Focus on pulse check and trust building — not status updates]

### Psychological Safety & Team Health
- [1-2 questions about how safe they feel raising concerns, team dynamics]

### Career & Growth
- [1-2 questions about their development, what they're learning, where they want to go]

### Unfiltered Feedback
- [1-2 questions that invite honest feedback about the org, processes, or leadership]

### Blockers & Friction
- [1-2 questions about what's slowing them down that their manager might not see]

## Notes
[Empty section to fill during the meeting]
```

After showing the prep, ask:

3. Want me to save this to `$VAULT_PATH/meetings/YYYY-MM/[date]-skip-level-[name].md`?

## Tips

- Skip-levels are about listening, not managing. The prep should help you ask better questions,
  not run an agenda.
- The manager context is there so you can listen for alignment or gaps — not to "check up" on
  the manager. Never share manager-specific feedback with the skip-level.
- If you haven't done a skip-level with this person before, lean heavier on open-ended
  questions and lighter on follow-ups.
- If team health signals are weak or missing, that's itself a signal — you may need better
  instrumentation.
- Prioritize questions that the person's manager is unlikely to ask — career trajectory,
  org-level friction, cross-team collaboration pain.
- Keep it conversational. This prep should take 2 minutes to scan before the meeting.
- After the skip-level, update the person note and capture any signals worth tracking.

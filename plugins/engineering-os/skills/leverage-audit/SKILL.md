---
name: leverage-audit
description: >-
  Audit where your time goes vs where it should go — find delegation and automation
  opportunities
---

# Leverage Audit

This skill runs a periodic audit of how you spend your time, inspired by Rohun Jauhar's task
audit framework. The goal: identify what you're doing that someone else should be doing, and
what creates disproportionate impact.

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
- All daily notes from the past 2 weeks in `$VAULT_PATH/log/daily/`
- The most recent weekly reviews in `$VAULT_PATH/log/weekly/`
- `$VAULT_PATH/goals/90_day.md` for current priorities
- `$VAULT_PATH/memory.md` for patterns
- `$VAULT_PATH/initiatives/_dashboard.md` for active work

Analyze the daily notes and weekly reviews to categorize where time actually went. Look for:
- Meetings (1:1s, staff, cross-team, ad hoc)
- Initiative work (deep work on strategic priorities)
- Reactive work (Slack, email, firefighting, unplanned requests)
- Administrative tasks (approvals, status updates, reporting)
- People work (coaching, feedback, hiring)

Present a summary of what you observed, then ask me the following questions one at a time,
wait for my response, then move to the next:

1. Does this breakdown feel accurate? What's missing from what I can see in your notes?
2. Which activities only you can do? (Your unique leverage as a leader)
3. What are you doing that someone on your team could do with coaching or delegation?
4. What recurring tasks drain your energy but don't require your judgment?

After I answer, generate the audit output directly (don't save to a file unless I ask). Format:

```markdown
# Leverage Audit — YYYY-MM-DD

## Time Allocation (Last 2 Weeks)

| Category                                  | Estimated % | Ideal % | Gap |
|-------------------------------------------|-------------|---------|-----|
| Strategic / Initiative Work               | X%          |         |     |
| People (1:1s, coaching, feedback)         | X%          |         |     |
| Meetings (staff, cross-team)              | X%          |         |     |
| Reactive (Slack, firefighting)            | X%          |         |     |
| Administrative (approvals, reporting)     | X%          |         |     |

## High-Leverage Activities
[Things only you can do that create disproportionate impact]
- [Activity] — why it's high leverage

## Delegation Candidates
[Things you're doing that someone else could own]
- [Task/activity] — who could take it, what they'd need to succeed

## Automation Candidates
[Repeatable tasks that could be systematized or automated]
- [Task] — how to automate or templatize

## Energy Drains
[Tasks that consume energy without requiring your judgment]
- [Task] — suggestion for elimination or delegation

## The "Run From Your Phone" Test
[Could you run your week from your phone? What forces you to your desk that shouldn't?]

## Recommended Changes
1. [Most impactful change — what to delegate or stop first]
2. [Second change]
3. [Third change]

## Next Audit
[Suggest a date — typically monthly or after a major role change]
```

After generating:
1. Ask if any insights should go into `memory.md`
2. If delegation candidates are identified, suggest creating action items in `tasks.md`
3. Connect findings to 90-day goals — flag if time allocation contradicts stated priorities

## Tips

- Run this monthly, or after any major change in responsibilities
- The gap between "where time goes" and "where it should go" is the whole point
- Don't judge — just observe. The patterns speak for themselves
- Delegation isn't about dumping work — it's about developing your people
- If reactive work exceeds 30%, that's a system problem, not a discipline problem
- Reference memory.md growth edges — they often connect to leverage
- The most common leader trap: doing IC-level work because it feels productive
- Be honest about what you enjoy vs what's actually high-leverage — they're not always the same

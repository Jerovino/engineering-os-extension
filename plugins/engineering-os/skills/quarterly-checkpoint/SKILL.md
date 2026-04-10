---
name: quarterly-checkpoint
description: Run your quarterly review to assess progress against goals and update patterns
---

# Quarterly Checkpoint

This skill runs your quarterly review — a comprehensive look back at the quarter, measuring
progress against goals, surfacing patterns, and setting direction for the next quarter.

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
- All weekly reviews from the past quarter in `$VAULT_PATH/log/weekly/`
- All monthly summaries from the past quarter in `$VAULT_PATH/log/monthly/`
- `$VAULT_PATH/memory.md` for patterns, strengths, and growth edges
- `$VAULT_PATH/goals/90_day.md` for current quarter priorities
- `$VAULT_PATH/goals/1_year.md` for annual goals (if it exists)
- The most recent quarterly review in `$VAULT_PATH/log/quarterly/` (if one exists)

Summarize what you see across the quarter — themes, momentum, gaps, shifts in focus.

Then ask me the following questions one at a time, wait for my response, then move to the next:

1. Looking back at your top 3 priorities this quarter — how do you feel about progress on each?
2. What was your biggest win this quarter? What made it possible?
3. What didn't get done that should have? What got in the way?
4. What patterns do you notice in yourself this quarter — energy, decision-making, time
   allocation?
5. What should change next quarter — priorities, habits, or approach?

After I answer, create the quarterly review at `$VAULT_PATH/log/quarterly/YYYY-Qn.md`
(e.g., 2026-Q1.md). Include:

### File Structure

```markdown
# Quarterly Review — YYYY Qn

*[First day of quarter] to [Last day of quarter]*

---

## Quarter Theme
[From 90_day.md — what was the intended focus]

## Goal Progress

### Priority 1: [Name]
**Status:** [On track / Behind / Completed / Abandoned]
[Summary of what happened, key milestones hit or missed]

### Priority 2: [Name]
**Status:** [On track / Behind / Completed / Abandoned]
[Summary]

### Priority 3: [Name]
**Status:** [On track / Behind / Completed / Abandoned]
[Summary]

### Secondary Goals
[Quick status on each secondary goal from 90_day.md]

## Biggest Win
[What it was, why it mattered, what enabled it]

## What Didn't Happen
[What was planned but not delivered, and the root cause]

## Patterns & Observations
[Recurring themes from weekly reviews — energy, time allocation, decision quality]
[Cross-reference with memory.md growth edges — improving or repeating?]

## Team Health Over the Quarter
[Trend from weekly reviews — stable, improving, declining]
[Key team events or shifts]

## Strategic Insights
[2-3 insights worth carrying forward — tag with #insight]

## Next Quarter Direction
[What to keep, start, stop]
[Suggested top 3 priorities for next quarter]

## 1-Year Goal Check
[How does this quarter's progress map to annual goals?]

---

*Reviewed: YYYY-MM-DD*
```

After creating the review:
1. Propose specific updates to `memory.md` — new patterns observed, growth edge progress,
   anti-patterns confirmed or resolved. Present them clearly and wait for confirmation before
   editing.
2. If the quarter is ending, suggest drafting the next `goals/90_day.md` as a follow-up.
3. Commit and push changes to GitHub with message: "Quarterly review - YYYY-Qn" with co-author
   credit.

Be direct. Flag when stated priorities and actual time spent don't match. Reference memory.md
anti-patterns if they showed up this quarter.

## Tips

- This should take about 60 minutes — it's the deepest review in the cycle
- Don't sugarcoat goal status — behind is behind
- Look for patterns across weekly reviews, not just the highlights
- Connect observations back to memory.md growth edges
- If weekly reviews are missing, that's itself a signal worth noting
- The memory.md update is the most valuable output — it compounds over time

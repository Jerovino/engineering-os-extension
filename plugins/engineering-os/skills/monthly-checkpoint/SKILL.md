---
name: monthly-checkpoint
description: Run your monthly review to bridge weekly insights and quarterly goals
---

# Monthly Checkpoint

This skill runs your monthly review — aggregating weekly patterns, checking momentum against
90-day goals, and surfacing drift before it compounds into a quarterly miss.

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
- All weekly reviews from the past month in `$VAULT_PATH/log/weekly/`
- All daily notes from the past month in `$VAULT_PATH/log/daily/`
- `$VAULT_PATH/goals/90_day.md` for current quarter priorities
- `$VAULT_PATH/memory.md` for patterns and growth edges
- `$VAULT_PATH/initiatives/_dashboard.md` for initiative status
- The most recent monthly review in `$VAULT_PATH/log/monthly/` (if one exists)

Summarize what you see across the month — momentum shifts, recurring themes, time allocation
patterns, initiative progress.

Then ask me the following questions one at a time, wait for my response, then move to the next:

1. Which of your 90-day priorities gained real momentum this month? Which stalled?
2. What's the biggest thing you learned or realized this month?
3. Is there anything you've been avoiding or postponing?
4. What needs to change next month to stay on track for the quarter?

After I answer, create the monthly review at `$VAULT_PATH/log/monthly/YYYY-MM.md`
(e.g., 2026-02.md). Include:

### File Structure

```markdown
# Monthly Review — YYYY-MM

*[Month name YYYY]*

---

## Month Summary
[2-3 sentence overview of what this month was about]

## 90-Day Goal Progress

### Priority 1: [Name]
**Trajectory:** [Accelerating / Steady / Stalling / Blocked]
[What moved, what didn't, key milestones]

### Priority 2: [Name]
**Trajectory:** [Accelerating / Steady / Stalling / Blocked]
[What moved, what didn't]

### Priority 3: [Name]
**Trajectory:** [Accelerating / Steady / Stalling / Blocked]
[What moved, what didn't]

## Initiative Status
[Quick update on each active initiative from dashboard]

## Patterns This Month
[Recurring themes from weekly reviews — where time went, energy patterns, decision quality]
[Cross-reference with memory.md — are growth edges improving or repeating?]

## Key Insight
[The most important realization from this month — tag with #insight]

## What I'm Avoiding
[Honest assessment of postponed or avoided work — this is the early warning system]

## Next Month's Focus
[Top 2-3 adjustments for next month to stay on track for the quarter]

---

*Reviewed: YYYY-MM-DD*
```

After creating the review:
1. Check if any insights should be added to `memory.md` — suggest them, don't add without
   confirmation
2. If this is month 2 of the quarter, flag any 90-day goals that are at risk
3. Commit and push changes to GitHub with message: "Monthly review - YYYY-MM" with co-author
   credit

Be direct about trajectory. The point of a monthly review is to catch drift while there's
still time to correct.

## Tips

- This should take about 20 minutes — more depth than weekly, less than quarterly
- The "What I'm Avoiding" section is the most valuable — be honest
- Compare actual time allocation (from weekly reviews) against stated priorities
- If weekly reviews are missing, note the gap — consistency is a signal
- Flag if an initiative has been "in progress" without visible movement
- Connect patterns back to memory.md growth edges
- Month 1 = set direction, Month 2 = course correct, Month 3 = close out — adjust tone
  accordingly

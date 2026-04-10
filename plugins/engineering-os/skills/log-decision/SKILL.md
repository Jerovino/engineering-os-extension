---
name: log-decision
description: Capture a decision with context, options, and rationale for future reference
---

# Log Decision

This skill helps you document decisions while context is fresh. Decisions are hard to
reconstruct later — this captures the reasoning so future-you (and your team) can understand
why.

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
- `$VAULT_PATH/decisions/decision_log.md` (if it exists) to see format and recent decisions
- `$VAULT_PATH/goals/90_day.md` for current priorities
- `$VAULT_PATH/memory.md` for decision patterns and anti-patterns

Ask me the following questions one at a time, wait for my response, then move to the next:

1. What decision did you make (or need to make)?
2. What options did you consider?
3. Why did you choose this option? What was the deciding factor?
4. What are the risks or trade-offs you're accepting?
5. Is this reversible? (One-way door or two-way door?)

After I answer, do two things:

### 1. Append to Decision Log

If `$VAULT_PATH/decisions/decision_log.md` doesn't exist, create it with a header. Then
append the new entry:

```markdown
### [Decision Title]
**Date:** YYYY-MM-DD
**Type:** [One-way door / Two-way door]
**Status:** [Decided / Pending input]

**Context:** [Brief situation description]

**Options considered:**
1. [Option A] — [pros/cons in one line]
2. [Option B] — [pros/cons in one line]
3. [Option C] — [if applicable]

**Decision:** [What was chosen]

**Rationale:** [Why — the deciding factor]

**Trade-offs accepted:** [What you're giving up or risking]

**Review by:** [Date to revisit, if applicable]

---
```

### 2. Create ADR (for significant decisions only)

If the decision is architectural, org-structural, or will be hard to reverse, ask:

> This seems significant enough for a standalone ADR. Want me to create one at
> `$VAULT_PATH/decisions/YYYY-MM-DD-[slug].md`?

If yes, create it using this format:

```markdown
# ADR: [Decision Title]

**Date:** YYYY-MM-DD
**Status:** Accepted
**Deciders:** [Who was involved]

## Context
[What prompted this decision — the problem or opportunity]

## Decision
[What we decided to do]

## Options Considered

### Option 1: [Name]
- **Pros:** [...]
- **Cons:** [...]

### Option 2: [Name]
- **Pros:** [...]
- **Cons:** [...]

## Consequences
[What follows from this decision — both positive and negative]

## Review Date
[When to revisit this decision, if applicable]
```

After logging:
1. Check if the decision connects to any active initiative — if so, mention it should be noted
   in the initiative's work log
2. Check memory.md decision patterns — flag if this decision aligns with or contradicts known
   patterns
3. Commit changes to GitHub with message: "Decision log - [brief title]" with co-author credit

## Tips

- Log decisions when they're fresh — even 48 hours later you'll forget the nuance
- Most decisions are two-way doors — note that to reduce decision anxiety
- The "trade-offs accepted" field is the most valuable part — it sets expectations
- Connect decisions to 90-day goals when relevant
- If memory.md lists "analysis paralysis" as an anti-pattern, gently note when a decision has
  been pending too long
- Keep entries concise — a decision log nobody reads is useless

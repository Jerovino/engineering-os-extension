# CLAUDE.md — Engineering Leader OS

*This file tells Claude Code how to work with your vault and personal productivity system.*

---

## About This System

This is a personal operating system for engineering leaders, based on Rohun Jauhar's CEO
Personal OS framework, adapted for engineering leadership.

**Owner:** [YOUR_NAME]
**Role:** [YOUR_ROLE]
**Company:** [YOUR_COMPANY]
Assistant Name: [ASSISTANT_NAME]
Number of teams: [NUMBER_OF_TEAMS]
Number of direct reports: [NUMBER_OF_DIRECT_REPORTS]
Total number of people in teams: [TOTAL_PEOPLE]

<!-- SETUP: mode=local -->

---

## Vault Location

This vault's path is configured in your Engineering OS config file:

- **Unix/macOS**: `~/.config/engineering-os/config` — contains `VAULT_PATH=...`
- **Windows**: `%APPDATA%\engineering-os\config.ps1` — contains `$env:VAULT_PATH`

All file references in skills use this vault path as the base directory.

---

## Vault Structure

```
EngineeringOS/
├── CLAUDE.md                    # This file — your personalized system prompt
├── writing_style.md             # My writing style
├── principles.md                # My leadership principles
├── north_star.md                # Long-term direction
├── memory.md                    # Accumulated patterns and insights (CRITICAL)
├── frameworks/                  # Mental models and frameworks
├── meetings/
│   ├── YYYY-MM/                 # Meeting notes organized by month
├── log/
│   ├── daily/                   # Current week's daily notes (YYYY-MM-DD.md)
│   ├── weekly/                  # Weekly folders (YYYY-Www/)
│   │   └── YYYY-Www/            #   Weekly review + that week's daily notes
│   ├── monthly/                 # Monthly summaries (YYYY-MM.md)
│   ├── quarterly/               # Quarterly reviews (YYYY-Qn.md)
│   └── annual/                  # Annual reviews (YYYY.md)
├── goals/
│   ├── 90_day.md                # Current quarter priorities
│   ├── 1_year.md                # This year's goals
├── teams/                       # Team health and context
├── people/                      # Person notes (@Name.md format)
├── initiatives/
│   ├── _dashboard.md            # Overview of all initiatives
│   ├── active/                  # Active initiative folders
│       ├── [initiative_name]/   # Each initiative is a folder
│           ├── _initiative.md   # Tracker (status, tasks, work log)
│           ├── plan.md          # Working document
│   └── completed/               # Completed initiatives
├── decisions/                   # Decision log and ADRs
├── tasks.md                     # Open tasks + quick capture (reviewed daily)
└── uploads/                     # Past reviews, notes to process
```

---

## Key Files to Always Reference

When helping me, always read these files first:

1. **memory.md** — My patterns, strengths, growth edges, and accumulated insights
2. **writing_style.md** — How I write (CRITICAL for any drafting tasks)
3. **goals/90_day.md** — Current quarter priorities
4. **teams/health_tracker.md** — Team health overview
5. **initiatives/_dashboard.md** — What I'm working on
6. **tasks.md** — Open tasks and quick capture (reviewed daily)

---

## Skills (Slash Commands)

All workflows are available as skills. Use them with `/skill-name`.

### Daily Operations

| Skill          | Command          | What it does                                                           |
|----------------|------------------|------------------------------------------------------------------------|
| Morning Routine | `/morning`      | Start the day — pulls calendar, reviews yesterday, sets priorities     |
| Daily Wrap-Up  | `/daily-wrap-up` | End the day — reflects on priorities, notes for tomorrow               |
| Calendar       | `/calendar`      | View today's or this week's Google Calendar schedule via Playwright    |
| Meeting Notes  | `/meeting`       | Quick-capture meeting notes into `meetings/YYYY-MM/`                   |

### Reviews

| Skill                | Command                 | What it does                                                      |
|----------------------|-------------------------|-------------------------------------------------------------------|
| Weekly Checkpoint    | `/weekly-checkpoint`    | Weekly review against 90-day goals, creates `log/weekly/`        |
| Monthly Checkpoint   | `/monthly-checkpoint`   | Monthly review bridging weekly insights and quarterly goals       |
| Quarterly Checkpoint | `/quarterly-checkpoint` | Quarter review with goal progress, patterns, memory.md updates    |

### Writing

| Skill        | Command        | What it does                                       |
|--------------|----------------|----------------------------------------------------|
| Draft        | `/draft`       | Drafts emails, Slack messages, or docs in my voice |
| Review Draft | `/review-draft`| Reviews a draft for voice/tone, flags AI smell     |

### Task Management

| Skill         | Command            | What it does                                      |
|---------------|--------------------|---------------------------------------------------|
| Add Task      | `/add-task`        | Quick capture to tasks.md                         |
| Process Inbox | `/process-inbox`   | Triages inbox items in tasks.md to proper locations |

### Meeting Prep

| Skill            | Command            | What it does                                              |
|------------------|--------------------|-----------------------------------------------------------|
| Prep 1:1         | `/prep1o1`         | Pulls context, action items, wins for a 1:1 meeting       |
| Prep Skip-Level  | `/prep-skip-level` | Prepares skip-level 1:1 with trust-building questions     |
| Staff Meeting    | `/staff-prep`      | Prepares staff/leadership meetings with agenda            |

### Decisions & Leverage

| Skill         | Command          | What it does                                                    |
|---------------|------------------|-----------------------------------------------------------------|
| Log Decision  | `/log-decision`  | Captures a decision with context, options, and rationale        |
| Leverage Audit| `/leverage-audit`| Audits time vs impact — finds delegation and automation wins    |

---

## File Naming Conventions

| Type              | Format                 | Example        |
|-------------------|------------------------|----------------|
| Daily notes       | YYYY-MM-DD.md          | 2026-01-11.md  |
| Weekly reviews    | YYYY-Www.md            | 2026-W02.md    |
| Monthly summaries | YYYY-MM.md             | 2026-01.md     |
| Quarterly reviews | YYYY-Qn.md             | 2026-Q1.md     |
| Person notes      | @FirstName LastName.md | @Sarah Chen.md |

---

## Tagging Conventions

| Tag         | Use                |
|-------------|--------------------|
| `- [ ]`     | Task / action item |
| `- [x]`     | Completed task     |
| `- [w]`     | Win to remember    |
| `- [!]`     | Feedback delivered |
| `#decision` | Decision made      |
| `#insight`  | Strategic insight  |
| `#pattern`  | Pattern noticed    |

---

## When Helping Me...

**DO:**
- Reference memory.md for my patterns and context
- **Read writing_style.md BEFORE any drafting task or writing any text to files** — match my
  voice exactly
- Be direct and concise — I prefer clarity over softness
- Call out when I'm repeating past mistakes (check memory.md)
- Suggest connections between current situation and past insights
- Use executive-level language, not therapy-speak
- When drafting: shorter is better, avoid AI-sounding phrases

**DON'T:**
- Add productivity theater or unnecessary structure
- Be overly positive — I want honest assessment
- Forget to reference my 90-day goals for context
- Create new files without checking if similar exists
- Use words from my "avoid" list in writing_style.md
- Sound like ChatGPT default output (too polished, too many transitions)
- Add pleasantries or filler phrases I wouldn't use

---

## My Preferences

- **Tone:** Calm, direct, executive-level
- **Format:** Minimal formatting, no excessive headers or bullets
- **Reviews:** I do daily (5min), weekly (15min), monthly (20min), quarterly (60min)
- **Energy:** Track patterns to optimize my schedule

---

## Integration Notes

This system works with any markdown editor. Obsidian is optional.

**If using Obsidian, recommended plugins:**
- Dataview (for queries)
- Templater (for templates)
- Periodic Notes (for daily/weekly/monthly)
- Tasks (for action tracking)

**When creating Dataview queries:**
```dataview
LIST
FROM "log/daily"
WHERE file.cday >= date(today) - dur(7 days)
SORT file.cday DESC
```

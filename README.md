# Engineering OS — Claude Code Extension

A personal operating system for engineering leaders. Install once, configure in under 3
minutes, and get 16 skills for daily operations, reviews, writing, meeting prep, and more.

## Install

```bash
# Add the marketplace
/plugin marketplace add https://github.com/adolfo-nunes/engineering-os-extension

# Install the plugin
/plugin install engineering-os
```

Then run the setup wizard once to personalize your vault:

**macOS/Linux:**
```bash
bash ~/.claude/plugins/cache/engineering-os-extensions/plugins/engineering-os/setup.sh
```

**Windows (PowerShell):**
```powershell
& "$env:APPDATA\Claude\plugins\cache\engineering-os-extensions\plugins\engineering-os\setup.ps1"
```

> **Note:** Obsidian is optional. Your vault is plain markdown — any editor works (VS Code,
> iA Writer, Typora, or even Notepad).

## Skills

| Skill                  | Command                  | What it does                                    |
|------------------------|--------------------------|-------------------------------------------------|
| Morning Routine        | `/morning`               | Start the day — calendar, priorities, daily note |
| Daily Wrap-Up          | `/daily-wrap-up`         | End the day — reflect, note tomorrow, git backup (mode 2) |
| Calendar               | `/calendar`              | View today's or this week's Google Calendar     |
| Meeting Notes          | `/meeting`               | Quick-capture meeting notes                     |
| Weekly Checkpoint      | `/weekly-checkpoint`     | Weekly review against 90-day goals              |
| Monthly Checkpoint     | `/monthly-checkpoint`    | Monthly review bridging weekly and quarterly    |
| Quarterly Checkpoint   | `/quarterly-checkpoint`  | Quarter review with goal progress               |
| Draft                  | `/draft`                 | Draft emails, Slack, or docs in your voice      |
| Review Draft           | `/review-draft`          | Review a draft for voice/tone                   |
| Add Task               | `/add-task`              | Quick capture to tasks.md                       |
| Process Inbox          | `/process-inbox`         | Triage inbox items to their proper locations    |
| Prep 1:1               | `/prep1o1`               | Pull context and action items for a 1:1         |
| Prep Skip-Level        | `/prep-skip-level`       | Prepare skip-level 1:1 with trust questions     |
| Staff Meeting Prep     | `/staff-prep`            | Prepare staff/leadership meetings               |
| Log Decision           | `/log-decision`          | Capture a decision with context and rationale   |
| Leverage Audit         | `/leverage-audit`        | Audit time vs impact — find delegation wins     |

## Usage Modes

**Mode 1 — Local only**: Vault lives on your disk. No git, no backup. Great for getting
started quickly.

**Mode 2 — Local + Private Repo**: Vault is a private git repository. `/daily-wrap-up` and
`/weekly-checkpoint` commit and push automatically.

## Custom Skills

Copy `plugins/engineering-os/skills/_template/SKILL.md` to
`<your-vault>/.claude/skills/<name>/SKILL.md`, fill in your instructions, and invoke it
as `/<name>`. See `SKILLS.md` for a step-by-step guide.

## Vault Structure

After setup, your vault lives at `~/EngineeringOS/` (or wherever you specified):

```
EngineeringOS/
├── CLAUDE.md            # Your personalized system prompt
├── memory.md            # Accumulated patterns and insights
├── writing_style.md     # Your writing voice
├── principles.md        # Your leadership principles
├── north_star.md        # Long-term direction
├── tasks.md             # Open tasks + quick capture
├── goals/               # 90-day and 1-year goals
├── log/                 # Daily, weekly, monthly, quarterly notes
├── meetings/            # Meeting notes by month
├── teams/               # Team health and context
├── people/              # Person notes
├── initiatives/         # Active and completed initiatives
└── decisions/           # Decision log
```

## Requirements

- [Claude Code CLI](https://claude.ai/code) (required)
- Git (required for Mode 2 only)
- `gh` CLI (optional, for Mode 2 automatic repo creation)
- Obsidian (optional — any markdown editor works)

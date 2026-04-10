---
name: draft
description: Drafts emails, Slack messages, or documents in your authentic voice
---

# Draft Message

This skill drafts communications in your voice — emails, Slack messages, or documents that
sound like you wrote them.

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

Read `$VAULT_PATH/writing_style.md` first — every word choice, opener, closing, and formatting
decision must come from this file.

Ask me the following questions one at a time, wait for my response, then move to the next:

1. What are you writing? (email, Slack message, document, status update, etc.)
2. Who's the audience? (team, executive, peer, external partner, specific person)
3. What's the topic and key message?

After I answer, draft the message following these rules:

### Channel Rules

**Email to team:**
- Open with the opener from writing_style.md for team emails
- Tone: warm, reflective, honest
- Longer — narrative style, multiple paragraphs
- Acknowledge challenges honestly before celebrating wins
- Close with the sign-off from writing_style.md for team emails

**Email to executives:**
- Tone: urgent, direct, data-driven
- Structure: strong opener → bullet summary → detailed findings → root cause → proposed
  strategy → clear ask
- Use bold statements where appropriate
- Close with the sign-off from writing_style.md for executive emails

**Email to peers:**
- Tone: direct, collaborative
- Structure: context → ask → "What do you think?"

**Email to external partners:**
- Tone: professional but not stiff
- Slightly more formal than internal

**Slack in team channels:**
- Use the Slack opener from writing_style.md
- Get to the point fast
- Tag people with @mentions
- End with a direct question
- No sign-off — just end

**Slack DMs:**
- Casual
- Proposals: "I was thinking of..."
- Framing: "As I believe..."

**Slack cross-functional:**
- Push back with questions, not statements

**Documents / strategy docs:**
- Data-first — every claim backed by specifics
- Headers for major sections only
- Mix of bullets and numbered lists based on content

**Status updates:**
- Concise, bullet-focused
- Clear next steps

### Voice Rules

- **Be direct** — cut filler, hedging, preamble
- **Use my phrases** from writing_style.md
- **Push back with questions** — never blunt statements
- **Emphasis through word choice** — not bold, italics, or caps
- **Shorter is better** — I can always expand
- **No fake enthusiasm** — no "thrilled", "excited to share", "absolutely!"

### Absolute Avoid List

Never use these words or phrases — check every sentence:

delve, utilize, leverage (as verb), synergy, circle back, touch base, move the needle,
at the end of the day, it goes without saying, I hope this email finds you well, per my last
email, going forward, actionable insights, paradigm shift, low-hanging fruit, deep dive,
unpack, holistic, robust, seamless, I'm thrilled to, I'm excited to share, I wanted to reach
out, just following up, happy to help, great question, absolutely, thanks for your patience,
please don't hesitate to

### Output

Provide the draft ready to send. No commentary, no explanation of choices — just the message.
If I need to fill in specifics (data, names, dates), mark them with `[placeholder]`.

## Tips

- When in doubt, make it shorter
- My Slack messages never have sign-offs
- For exec emails, structure matters more than warmth
- Don't add enthusiasm I wouldn't add — stay authentic

---
name: review-draft
description: Reviews a draft for voice and tone, flagging anything that doesn't sound like you
---

# Review Draft

This skill reviews a piece of writing against your voice and style, flagging anything that
sounds off and suggesting edits that match how you actually write.

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

Read `$VAULT_PATH/writing_style.md` first — this is the source of truth for voice, tone, word
choice, and anti-patterns.

Ask me:

1. Paste the draft you want me to review. What's the audience and channel? (email to team,
   Slack message, exec doc, etc.)

Once I provide the draft and context, review it against `writing_style.md` and produce:

### Voice Check

Go through the draft line by line and flag:
- **Words on the avoid list** — call out each one with a suggested replacement
- **AI-sounding phrases** — anything that feels generated rather than written by me
- **Tone mismatches** — too formal, too casual, too enthusiastic for the context
- **Missing voice markers** — places where my typical phrases or patterns would fit naturally
- **Structural issues** — wrong opener for the channel, sign-off that doesn't match my style,
  formatting that's off

Use this format for each flag:

```
> [quoted text from draft]
Flag: [what's wrong]
Suggest: [replacement that matches my voice]
```

### Rewritten Draft

After the flags, provide the full draft rewritten in my voice. Don't explain the changes —
just show the clean version.

### Summary

End with a short summary:
- How many flags found
- The biggest voice issue (the thing that would most give away it's not me)
- Overall tone rating: sounds like me / close but needs tweaks / doesn't sound like me

## Key Rules

- **Directness:** I'm very direct — cut filler, hedging, and unnecessary preamble
- **Warmth:** Lean warm but not performative — no fake enthusiasm
- **Conciseness:** Medium — not terse, but no bloat
- **Confidence:** Moderate — "I believe" not "I'm certain" or "maybe we could"
- **Avoid list is absolute** — if a word is on it, flag it every time, no exceptions
- **Context matters** — email to team is warmer and longer; Slack is short and direct; exec
  comms are structured and data-driven
- **Closings:** Use the sign-off from writing_style.md that matches the channel
- **Pushback style:** Questions, not statements

## Tips

- The avoid list in writing_style.md is the fastest way to catch AI smell
- My Slack messages don't have sign-offs — flag any that do
- I use word choice for emphasis, not bold/italics/caps
- When in doubt, shorter is better

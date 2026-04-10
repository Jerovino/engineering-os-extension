---
name: my-skill
description: Brief description of what this skill does
---

# My Skill

One sentence about this skill.

## Instructions

### Step 0: Resolve vault path

Read the config file to find the vault location:
- Unix/macOS: `~/.config/engineering-os/config` — parse `VAULT_PATH=...`
- Windows: `%APPDATA%\engineering-os\config.ps1` — parse `$env:VAULT_PATH`

All file references use `$VAULT_PATH` as the base directory.
If the config file does not exist, tell the user: "Engineering OS is not set up.
Run `setup.sh` (or `setup.ps1` on Windows) from the plugin directory first."

### Step 1: [First thing Claude should do]

[Describe what to read, gather, or ask]

### Step 2: [Second thing]

[Describe the action or output]

### Step 3: [Output or final action]

[Describe the result — file created, response given, etc.]

## Tips

- [Optional guidance for edge cases]
- [When to skip certain steps]

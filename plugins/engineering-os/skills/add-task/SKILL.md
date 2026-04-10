---
name: add-task
description: Quickly adds a task or idea to tasks.md for later processing
---

# Add Task

This skill captures a task or idea into your inbox for later processing.

## Usage

```
/add-task Buy new monitor for home office
/add-task Follow up with Carlos on dependency management plan
```

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

The task description is provided as the argument after `/add-task`.

Add the item to `$VAULT_PATH/tasks.md` under the `## Inbox` section as a checkbox item
(`- [ ]`). Append it after the last existing item in that section, before the `---` separator.

If multiple items are provided (separated by newlines or semicolons), add each as a separate
checkbox.

If sub-items or details are included, nest them as bullet points under the main checkbox —
matching the existing format in tasks.md.

After adding, confirm what was added with the exact text. Don't read back the whole inbox —
just the new item(s).

If no argument is provided, ask what to capture.

## Tips

- Keep the capture fast — this is a quick dump, not a planning session
- Don't ask follow-up questions about priority or categorization — that happens during inbox
  processing
- If the item sounds like it should go directly to today's daily note (urgent), mention it but
  still add to tasks.md
- Preserve the exact wording I use — don't rephrase or clean up

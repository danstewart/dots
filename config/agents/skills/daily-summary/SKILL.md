---
name: daily-summary
description: Summarise the user's daily notes as a Slack-ready message. Use when asked to summarise what the user did yesterday, today, or on a specific date.
---

# Daily Summary

Summarise the user's daily notes as a Slack-ready message for copy and paste.

## Finding the note

Daily notes live at `/Users/danstewart/Data/Notes/Daily/YYYY-MM/YYYY-MM-DD.md`
(e.g. `/Users/danstewart/Data/Notes/Daily/2026-09/2026-09-15.md`).

- "Yesterday" is relative to the user's working week: they work **Monday to
  Thursday**, so "yesterday" after a Friday–Sunday gap is the previous
  **Thursday** (e.g. on Monday 2026-09-21, yesterday is 2026-09-17). If the
  target file doesn't exist, say so rather than guessing another date.
- Read the note file fully. Ignore template sections like `# Due Tasks`,
  `# Files Created Today`, and `# Meetings Today` (dataview blocks) — only
  summarise the actual content.

## Output format

Plain Slack message, ready to copy and paste — no header, no emoji, no indented
bullets, not in a code block:

- One bullet per task: `• [Title](URL) — status`
  - Title and URL come from the note's issue/PR links.
  - Status is derived from the notes: "fixed & merged" if a PR was merged,
    "already fixed, tested & confirmed" if it was verified as previously fixed,
    "won't fix" with the stated reason if the note says so.
  - If a task is listed but has **no notes**, mark it as **"In progress"**.

### Example

• [Dashboard unresponsive](https://github.com/Administrate/platform/issues/52587) — Fixed & merged
• [Import tool: updateUserRoles doesn't support numeric role IDs](https://github.com/Administrate/platform/issues/52023) — Already fixed, tested & confirmed
• [Tax rounding incorrect on SalesLedger report](https://github.com/Administrate/platform/issues/51206) — Won't fix, PHP codebase is days from being dropped
• [Duplicate learners on events](https://github.com/Administrate/platform/issues/51496) — In progress

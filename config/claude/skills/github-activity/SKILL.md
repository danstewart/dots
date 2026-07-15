---
name: github-activity
description: Summarize personal GitHub activity for a date range, defaulting to the previous week.
---

# GitHub Activity

Use read-only `gh`. Report only the authenticated user's actions.

## Period

Treat text after the invocation as an inclusive free-form date range. With no
argument, use the previous Monday 00:00 through Sunday 23:59:59. Resolve in the
user's timezone; never print the timezone.

Format `{date_range}` like `Monday 6th to Sunday 12th of July 2026`; name both
months or years when different.

## Collect

Get `{login}` with `gh api user`.

```text
gh search prs --author {login} --updated "{start_date}..{end_date}"
gh search commits --author {login} --author-date "{start_date}..{end_date}"
gh search prs --reviewed-by {login} --updated "{start_date}..{end_date}"
```

Inspect matching PRs, commits, and reviews as needed. Verify each user
action occurred during the period. Separate source and merge commits. For older
open PRs, compare `authoredDate` with `committedDate`; a new commit date may only
be a rebase or branch refresh.

## Report

**Shipped:** merged PRs and meaningful review fixes. **WIP:** open authored PRs
created or updated. **Reviews:** reviews or approvals.
Summarize each PR once; mention commits only for unrepresented work or WIP context.

```markdown
{date_range}

<br>

**Shipped**

- [PR title](URL)  
  Concise outcome.

<br>

**WIP**

- [PR title](URL)  
  Concise update.

<br>

**Reviews**

- Approved or reviewed [PR title](URL).
```

Use direct links and factual outcomes. Omit empty sections and draft,
mergeability, conflict, or review-state metadata unless requested.

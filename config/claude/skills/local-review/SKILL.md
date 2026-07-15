---
name: local-review
description: Review the changes on the current branch against `trunk`, focusing on bugs, maintainability, backwards compatibility, and code cleanliness, and report findings with a red/orange/green traffic-light system.
---

# Local Code Review

Review the local, uncommitted-and-committed work on the current branch against
`trunk`. This is a working-tree review, not a GitHub PR review — never call `gh`.

## Scope the diff

Confirm you are in a git repo and not on `trunk` itself. Then gather the full set
of changes on this branch relative to `trunk`:

```bash
git fetch origin trunk --quiet 2>/dev/null || true
git merge-base HEAD trunk            # {base}
git diff {base}...HEAD --stat        # committed changes on the branch
git status --short                   # uncommitted working-tree changes
```

Review **both** committed changes since the merge-base **and** uncommitted
working-tree changes (staged and unstaged), so the review reflects everything the
branch currently contains. Use `git diff {base}...HEAD` for the committed diff and
`git diff HEAD` for the working-tree diff.

If `trunk` does not exist locally, fall back in order to `origin/trunk`, then
`main`/`origin/main`, then `master`. State which base you used.

Read the changed files in full for context — do not review from the diff hunks
alone. Judge each change against how the surrounding code already works.

## What to look for

- **Bugs** — logic errors, off-by-one, null/undefined handling, race conditions,
  incorrect error handling, edge cases, resource leaks, wrong assumptions about
  inputs, tests that don't actually assert the behavior they claim.
- **Maintainability** — unclear naming, duplicated logic, tight coupling, missing
  abstractions or over-abstraction, functions doing too much, code that will be
  hard to change safely later.
- **Backwards compatibility** — changes to public APIs, function signatures,
  serialized formats, DB schemas, config keys, CLI flags, or wire protocols that
  could break existing callers, stored data, or deployed clients. Flag missing
  migrations, deprecations without shims, and default-value changes.
- **Code cleanliness** — dead code, leftover debug output, commented-out blocks,
  inconsistent style with the surrounding code, TODOs left unresolved, formatting
  that diverges from the file's conventions.

Only report issues introduced or touched by this branch's changes. Do not report
pre-existing issues in untouched code.

## Traffic-light rating

Rate every finding:

- 🔴 **Red — Must fix**: bugs that will cause incorrect behavior, data loss, or
  breakage; backwards-incompatible changes with no migration/shim. Merging as-is
  is not safe.
- 🟠 **Orange — Should fix**: real maintainability or correctness concerns that
  aren't blocking but ought to be addressed, ideally before merge.
- 🟢 **Green — Nice to have**: minor cleanliness or style polish; safe to ignore.

Be honest and calibrated — do not inflate severity, and do not invent findings to
fill a category. If nothing qualifies for a level, say so.

## Report

Open with the base compared against and a one-line verdict (e.g. "2 must-fix
issues block merge" or "No blocking issues — good to merge").

Then group findings by traffic-light level, red first. For each finding:

```markdown
### 🔴 Must fix

- **`path/to/file.py:42`** — Short title.
  What the problem is and why it matters, in one or two sentences. Concrete
  suggested fix.
```

Reference every finding with a clickable `file_path:line` so it can be jumped to.
Omit any level that has no findings rather than showing it empty. Keep each
finding tight — the point is to be actioned, not read like an essay.

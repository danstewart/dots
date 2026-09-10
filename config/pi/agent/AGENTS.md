# AGENTS.md

## Environment

- macOS (Apple Silicon, Homebrew at `/opt/homebrew`).
- Toolchains managed by **mise**: Prefer `mise exec` or rely on mise shims rather than
  hardcoding install paths.
- Node projects: default to **pnpm** unless the project's lockfile says otherwise
  (`package-lock.json` → npm, `bun.lockb` → bun, `yarn.lock` → yarn).
- Python projects: prefer **uv** (`uv run`, `uv add`) over pip; fall back to `python3 -m venv`
  for older setups.
- Personal projects live under `~/projects`. Don't wander outside the current project
  directory unless the task requires it.

## Permissions

`pi`'s permission policy lives at
`~/.pi/agent/extensions/pi-permission-system/config.json`. You can read it to understand
which commands are allow-listed and which require approval. Prefer explicitly allow listed
commands where possible but this is not a hard requirement.

## Working on code

1. **Explore before editing.** Read the relevant files, check for project-level
   `AGENTS.md`, `CLAUDE.md`, `README.md`, or `CONTRIBUTING.md`, and follow them —
   project instructions override these globals. Look at neighboring code to learn the
   project's conventions (naming, error handling, module layout, formatting). Match them
   even if you'd do it differently.
2. **Detect the stack** from lockfiles/manifests (`package.json`, `pyproject.toml`, `go.mod`,
   `Cargo.toml`, …) and use its native tooling for tests, linting, and builds.
3. **Keep diffs minimal and focused.** Don't reformat, rename, or "clean up" code that
   isn't part of the task; prefer targeted edits over full rewrites. No drive-by changes —
   mention anything you notice instead of fixing it unasked.
4. **Verify your work.** Before claiming done, run the project's checks — typecheck, lint,
   tests, or at minimum a build/import of the changed code. If a test fails, diagnose
   before changing assertions to make them pass.
5. **Dependencies:** don't add one without checking it's justified and consistent with
   what the project already uses.
6. **Secrets:** never commit or echo secrets, tokens, or `.env` contents.
7. **Tests:** Avoid running entire test suites unless asked. Add tests where they're needed
   to catch regressions and ensure the code works as expected.

## Git

- Check `git log --oneline -10` and match the existing commit message style.
- Make small, logically grouped commits with clear messages; use `git status`/`git diff`
  before committing so you only stage what you intend.
- Never `git push`, force-push, or modify history unless explicitly asked.
- Use the **`gh` CLI for GitHub data** (`gh issue view`, `gh pr view`, `gh run view`).
  Read-only `gh` commands are allow-listed; never use `gh` to merge, close, or otherwise
  mutate GitHub state unless explicitly asked.
- Don't switch branches, stash, or discard changes without confirming — uncommitted work
  may be the user's.
- Do not use `git -C` if you are already in the correct directory.

## Communication

- Be concise but precise. Prefer bullet points, lead with the outcome. Use emojis
  but sparingly — only to draw attention to key points, not on every bullet.
- Show file paths clearly when you touch files.
- Surface assumptions and trade-offs; ask before doing anything destructive or
  irreversible.

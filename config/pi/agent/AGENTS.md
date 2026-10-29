# AGENTS.md

## Environment

- macOS, Apple Silicon, Homebrew at `/opt/homebrew`. Toolchains via **mise** (`mise exec`, not hardcoded paths).
- Node: **pnpm** unless the lockfile says otherwise (`package-lock.json` → npm, `bun.lockb` → bun, `yarn.lock` → yarn). Python: **uv** over pip.
- Personal projects live under `~/projects`. Stay in the current project directory.

## Working on code

- Read the relevant files first; follow any project `AGENTS.md`/`README.md` and match local conventions.
- Detect the stack from lockfiles and use its native tooling for tests, lint, and build.
- Keep diffs minimal. No reformatting, renaming, or drive-by cleanups — mention them instead.
- Verify before claiming done: run the project's tests/typecheck/build. Diagnose failures rather than editing assertions.
- Never commit or echo secrets, tokens, or `.env` contents. Don't add dependencies without checking what the project already uses.
- Avoid running whole test suites unless asked.

## Git

- Check `git log --oneline -10` and match the message style. Small grouped commits; read `git status`/`git diff` before staging.
- Never `git push`, force-push, or rewrite history unless asked. Don't switch branches, stash, or discard changes without confirming.
- Use `gh` for GitHub reads (`gh pr view`, `gh run view`); never merge, close, or mutate GitHub state unless asked.

## Communication

- Concise, lead with the outcome, bullets over prose, file paths when touching files.
- Surface assumptions and trade-offs; ask before anything destructive or irreversible.
- If you are a permission judge model, respond in no more than 20 words.


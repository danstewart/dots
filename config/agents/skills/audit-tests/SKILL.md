---
name: audit-tests
description: Review the tests added or changed on the current branch and judge whether they actually test the behaviour that matters — flagging useless, tautological, duplicated, and dead tests, plus untested paths the tests pretend to cover.
---

# Test Review

Review only the **tests** added or changed on this branch, and answer one
question per test: *would this fail if the behaviour it names broke?*

Goal is not more tests. Goal is: every test present earns its place, and the
risky paths have one. Say plainly when a test is decoration.

## Scope the diff

```bash
git merge-base HEAD main            # {base}
git diff {base}...HEAD --name-only | grep -Ei 'test|spec|factory|conftest'
```

Fall back to `origin/main`, `trunk`, `master` if `main` is missing. Include
test helpers changed to make the new tests work (`*_testcase.py`,
`handlers/index.ts`, `testUtils/`) — helper changes can silently weaken
existing suites.

If the branch is one commit and the user said "this PR", review the whole
commit; otherwise review committed + uncommitted (`git diff HEAD`).

## Read before judging

1. Read each changed test file in full — not the diff hunks.
2. Read **the implementation under test**, in full. You cannot spot a vacuous
   test without knowing what the code would do when broken.
3. If it touches a database, read the repository/service **and** the entity, so
   you know which layer already asserts the same thing.

## Run what is cheap

Run the suites that need no external services (mocked unit tests, jest specs).
Record the pass/fail line. Do not start MySQL, docker, or a dev server to run
DB-backed suites — say they were not run instead.

```bash
.venv/bin/python -m pytest path/to/test_x.py -q
cd tms-ux/packages/tms-ux && TZ=UTC npx jest path/to/spec
```

Never modify tests or assertions to make a run pass.

## Per-test checklist

Ask each of these of every test in scope. The first hit is the finding.

- **Would it fail if the behaviour broke?** Mentally delete the guarded line
  in the implementation. If the test still passes, it is decoration.
- **Does it assert a mock instead of an outcome?** `assert_not_called`,
  `toHaveBeenCalledWith` on an internal collaborator, call-count checks —
  these lock in an implementation shape, not a behaviour. Flag unless the call
  *is* the externally observable contract (a query sent, a job enqueued).
- **Is it tautological?** `assertEqual(set(), set())`, asserting the default
  value of a field nothing writes, negative assertions on strings that could
  never render (`queryByText` is an exact match — a substring never matches).
- **Is it duplicated across layers?** The same guard asserted in repository,
  service, and GraphQL tests. Value drops fast: keep the layer that owns the
  logic plus the one proving the mapping, flag the rest.
- **Is it testing markup or internals instead of the effect?** `closest("p")`,
  DOM nesting, CSS class names, private method names. Brittle and proves
  nothing about what the user sees.
- **Is the name lying?** A test named "keeps the id, type and label" that never
  varies the type does not test type. Flag as wrong name or missing assertion.
- **Does it verify the same thing twice inside the file?** Fine if one is the
  happy path and one the boundary; flag if it is the same assertion twice.

## Hunt for blind spots (most valuable part)

Tests that exist but never reach the code they claim to cover. Look for:

- **Stubbed components that swallow the props under test.** A grid mock that
  ignores `columns`, a router mock that ignores `search`, a form mock that
  ignores validation — the page's real renderers never execute. Flag
  explicitly, with the renderer named.
- **Branches no test takes.** Enumerate the branches in the changed
  implementation (each `if`, each `is not` type check, each early return,
  each create-vs-update path) and check each against the tests. Typical
  offenders: a new row type added during *update* when every update test adds
  a different type; the read-only/permission early return; the refetch after a
  mutation.
- **Permission / authorisation paths** — usually asserted for one entry point
  and assumed for the rest.
- **Error and empty paths** — thrown network errors, null responses, unknown
  ids, legacy rows of an unexpected type.

Report at most the top gaps, ranked by "how likely a bug hides here". One
concrete test suggestion each, naming the file to add it to.

## Dead code found while reviewing

If a helper exists only for a test, or an entity property/method has no callers
outside tests, say so in one line. Do not fix it unasked.

## Report

Open with a one-line verdict, e.g. "Mostly load-bearing: 4 weak tests, 4 real
gaps" or "These tests only prove the mocks work".

State which suites you actually ran and their result, and which you did not.

Then, in this order:

1. **Genuinely covered** — 3-5 bullets of the behaviour worth keeping, each
   naming the file and the specific scenario. This tells the reader what is
   safe to assume.
2. **Flagged as low value or brittle** — numbered, `path:line`, one
   sentence on why, one verb on what to do (delete / rename / merge / keep).
3. **Real gaps** — numbered, ranked, each with the branch or renderer that no
   test reaches and the file the missing test belongs in.
4. **Dead code noticed** — one line, optional.

Hard cap: 5 items visible per section. If more, rank and mention the rest
count without listing them.

End with **one** concrete next action: a single test to add or delete, with its
path. Not a summary, not an offer to do more.

## Pitfalls

- Don't ask for tests of getters, DTOs, or wiring that TypeScript or the type
  system already proves.
- Don't recommend a test at every layer. Name the layer that owns the logic.
- Don't review the implementation's bugs as your main output — the ask is test
  quality. Mention a bug only when a test's false confidence is what hides it.
- Don't count lines, coverage percentage, or test quantity as quality signals.

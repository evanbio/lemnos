# Commit Command

Create exactly one intentional Git commit from the current staged changes.

---

## Contract

- Treat the staged set as the default commit boundary.
- Never stage unstaged files unless the user explicitly asks or approves a proposed file set.
- Never include unrelated changes.
- Never rewrite history.
- Respect hooks by default.
- Follow the repository's existing commit style for wording and type choice, but omit emoji unless the user asks.

---

## Algorithm

**1. Inspect repository state.**
- Run `git status --short`.
- Run `git branch --show-current`.
- Stop if the repository is in a merge, rebase, cherry-pick, or conflict state.
- If message style is unclear, inspect recent commits with `git log -10 --oneline`.

**2. Determine the commit boundary.**
- Prefer the current staged files.
- If nothing is staged, stop and ask what should be staged.
- If staged changes mix unrelated intent, stop and suggest split commits.
- If unstaged or untracked files appear related, mention them but do not include them silently.

**3. Review staged changes.**
- Run `git diff --cached --stat`.
- Run `git diff --cached` to understand the staged intent before writing the message.
- Watch for secrets, private files, generated artifacts, large binaries, and accidental deletions.

**4. Generate the commit message.**
- Format: `<type>: <subject>`
- Infer the type from the primary intent.
- Keep the subject under 72 characters, imperative mood, no trailing period, no assistant signature.

  | Type | Meaning |
  |------|---------|
  | `feat` | new capability |
  | `fix` | bug fix |
  | `docs` | documentation or content |
  | `style` | formatting or visual-only change |
  | `refactor` | structure change without behavior change |
  | `perf` | performance improvement |
  | `test` | tests |
  | `chore` | maintenance |
  | `ci` | CI/CD |
  | `build` | build or dependency system |
  | `assets` | images, media, or other assets |
  | `revert` | revert a previous change |

**5. Commit.**
- Run `git commit -m "<message>"`.
- Use `--no-verify` only if explicitly requested.
- If hooks fail, summarize the failure and stop. Do not retry with `--no-verify` automatically.

**6. Report.**
- Show the commit hash and subject.
- Show the final `git status --short`.
- If changes remain, clearly state that they were not included.

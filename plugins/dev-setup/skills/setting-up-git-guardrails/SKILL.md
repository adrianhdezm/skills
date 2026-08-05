---
name: setting-up-git-guardrails
description: Sets up a PreToolUse hook that blocks destructive git commands as part of a safe development environment. Use when setting up a new machine, configuring git safety, or preventing accidental force-pushes, hard resets, or discarded changes.
---

# Setup Git Guardrails

Sets up a PreToolUse hook that intercepts and blocks dangerous git commands before Claude executes them.

## What Gets Blocked

- `git push --force` / `--force-with-lease` / `-f`, in any argument position
- `git reset --hard`
- `git clean -f` / `-fd` / `-df` / `--force`
- `git branch -D` / `--delete --force`
- `git checkout .` / `git checkout -- .`
- `git restore .` / `git restore -- .`

Plain `git push` is allowed — only force-pushes are blocked. So are
`git push -u`, `--tags`, `--dry-run`, and `--delete`.

Force-pushes and hard resets are also blocked when invoked through an alias or
wrapper (`g push --force`, `hub push -f`), since those are the least recoverable.

Quoted strings are stripped before matching, so commands that merely *mention* a
dangerous command are allowed — `grep -rn "git push" plugins/` and
`git commit -m "document the reset --hard rule"` both pass through, as do
narrower forms like `git checkout -- src/foo.js` and `git branch -d merged`.

## Process

1. Copy the hook script from `scripts/block-dangerous-git.sh` to the folder `~/.claude/hooks` in the Claude user's environment. Create the folder if it doesn't exist.

2. Add hook to settings `~/.claude/settings.json`

Add this command entry to the `"matcher": "Bash"` hooks:

```json
{
  "type": "command",
  "command": "~/.claude/hooks/block-dangerous-git.sh"
}
```

**Merge rules:**

- If `~/.claude/settings.json` doesn't exist, create it with the full structure:
  ```json
  {
    "hooks": {
      "PreToolUse": [
        {
          "matcher": "Bash",
          "hooks": [
            {
              "type": "command",
              "command": "~/.claude/hooks/block-dangerous-git.sh"
            }
          ]
        }
      ]
    }
  }
  ```
- If a `"matcher": "Bash"` entry already exists in `PreToolUse`, append the command to its existing `hooks` array — do NOT create a duplicate Bash matcher.
- If no `"matcher": "Bash"` entry exists but `PreToolUse` has other matchers, add a new Bash matcher object to the array.
- Don't overwrite other settings.

3. Verify

Run a quick test:

```bash
echo '{"tool_input":{"command":"git push --force origin main"}}' | ~/.claude/hooks/block-dangerous-git.sh
```

Should exit with code 2 and print a BLOCKED message naming the matched pattern to stderr.

And confirm a plain push still passes:

```bash
echo '{"tool_input":{"command":"git push origin main"}}' | ~/.claude/hooks/block-dangerous-git.sh
```

Should exit 0 with no output.

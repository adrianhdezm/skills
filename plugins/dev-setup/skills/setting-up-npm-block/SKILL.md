---
name: setting-up-npm-block
description: Sets up a PreToolUse hook that blocks npm commands and redirects to pnpm as part of a consistent development environment. Use when setting up a new machine, enforcing pnpm usage, or preventing accidental npm calls.
---

# Blocking npm

Installs a PreToolUse hook that intercepts any `npm` command and exits with a message to use `pnpm` instead. The hook is a no-op in repos that don't have a `pnpm-lock.yaml`.

## Process

1. Copy `scripts/block-npm.sh` to `~/.claude/hooks/block-npm.sh`. Create the directory if it doesn't exist.

2. Add the hook to `~/.claude/settings.json` under `PreToolUse` with `"matcher": "Bash"`:

```json
{
  "type": "command",
  "command": "~/.claude/hooks/block-npm.sh"
}
```

**Merge rules:**

- No `settings.json` → create it with the full structure below.
- `"matcher": "Bash"` entry exists → append to its `hooks` array (do NOT add a duplicate matcher).
- No `"matcher": "Bash"` but other matchers exist → add a new Bash matcher object.

Full structure when creating from scratch:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/hooks/block-npm.sh"
          }
        ]
      }
    ]
  }
}
```

3. Verify the hook works:

```bash
TMPDIR=$(mktemp -d) && git init "$TMPDIR" && touch "$TMPDIR/pnpm-lock.yaml" && echo '{"tool_input":{"command":"npm install"}}' | (cd "$TMPDIR" && ~/.claude/hooks/block-npm.sh); rm -rf "$TMPDIR"
```

Expected: exits with code 2 and prints `BLOCKED: Use pnpm, not npm.` to stderr.

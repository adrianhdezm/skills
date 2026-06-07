#!/usr/bin/env bash
#
# Usage:
#   list-epic-child-work.sh <epic-slug-or-path> [target-repo-root]
#
# Example output:
#   state	type	path	title
#   Ready	story	docs/epics/active/auth/story_login.md	Add login flow
#   Review	bugfix	docs/epics/active/auth/bugfix_session.md	Fix session expiry
set -euo pipefail

root="."
epic="${1:-}"

if [ -z "$epic" ]; then
  printf 'usage: %s <epic-slug-or-path> [root]\n' "$(basename "$0")" >&2
  exit 2
fi

if [ "$#" -ge 2 ]; then
  root="$2"
fi

case "$epic" in
  */*) epic_dir="$epic" ;;
  *) epic_dir="$root/docs/epics/active/$epic" ;;
esac

if [ ! -d "$epic_dir" ]; then
  printf 'epic directory not found: %s\n' "$epic_dir" >&2
  exit 1
fi

field_value() {
  local file="$1"
  local label="$2"
  sed -n "s/^- ${label}: //p" "$file" | head -n 1
}

title_for() {
  awk '
    /^# Story: / { sub(/^# Story: /, ""); print; exit }
    /^# Bugfix: / { sub(/^# Bugfix: /, ""); print; exit }
  ' "$1"
}

type_for() {
  case "$(basename "$1")" in
    story_*) printf 'story' ;;
    bugfix_*) printf 'bugfix' ;;
    *) printf 'artifact' ;;
  esac
}

printf 'state\ttype\tpath\ttitle\n'

find "$epic_dir" -maxdepth 1 -name 'story_*.md' -o -name 'bugfix_*.md' 2>/dev/null | sort | while IFS= read -r file; do
  [ -f "$file" ] || continue
  printf '%s\t%s\t%s\t%s\n' "$(field_value "$file" "State")" "$(type_for "$file")" "$file" "$(title_for "$file")"
done

#!/usr/bin/env bash
#
# Usage:
#   list-review-work.sh [target-repo-root]
#
# Example output:
#   state	type	path	title
#   Review	story	docs/epics/active/auth/story_login.md	Add login flow
#   Review	bugfix	docs/standalone-changes/active/bugfix_cache.md	Fix stale cache
set -euo pipefail

root="${1:-.}"

artifact_paths() {
  find "$root/docs/epics/active" -path '*/story_*.md' -o -path '*/bugfix_*.md' 2>/dev/null || true
  find "$root/docs/standalone-changes/active" -maxdepth 1 -name 'story_*.md' -o -name 'bugfix_*.md' 2>/dev/null || true
}

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

artifact_paths | sort | while IFS= read -r file; do
  [ -f "$file" ] || continue
  state="$(field_value "$file" "State")"
  if [ "$state" = "Review" ]; then
    printf '%s\t%s\t%s\t%s\n' "$state" "$(type_for "$file")" "$file" "$(title_for "$file")"
  fi
done

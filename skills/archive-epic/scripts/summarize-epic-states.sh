#!/usr/bin/env bash
#
# Usage:
#   summarize-epic-states.sh <epic-slug-or-path> [target-repo-root]
#
# Example output:
#   epic	Active	Pass	docs/epics/active/auth/epic.md
#   state	validation_decision	type	path	title
#   Implemented	Pass	story	docs/epics/active/auth/story_login.md	Add login flow
#   Partial Implemented	Partial	bugfix	docs/epics/active/auth/bugfix_session.md	Fix session expiry
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

section_decision() {
  local file="$1"
  local section="$2"
  awk -v section="$section" '
    $0 == "## " section { in_section = 1; next }
    in_section && /^## / { exit }
    in_section && /^- Decision: / { sub(/^- Decision: /, ""); print; exit }
  ' "$file"
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

epic_file="$epic_dir/epic.md"
if [ -f "$epic_file" ]; then
  printf 'epic\t%s\t%s\t%s\n' "$(field_value "$epic_file" "State")" "$(section_decision "$epic_file" "Epic Validation")" "$epic_file"
fi

printf 'state\tvalidation_decision\ttype\tpath\ttitle\n'

find "$epic_dir" -maxdepth 1 -name 'story_*.md' -o -name 'bugfix_*.md' 2>/dev/null | sort | while IFS= read -r file; do
  [ -f "$file" ] || continue
  printf '%s\t%s\t%s\t%s\t%s\n' "$(field_value "$file" "State")" "$(section_decision "$file" "Validation Result")" "$(type_for "$file")" "$file" "$(title_for "$file")"
done

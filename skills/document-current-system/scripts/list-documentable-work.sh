#!/usr/bin/env bash
#
# Usage:
#   list-documentable-work.sh [target-repo-root]
#   list-documentable-work.sh --root <target-repo-root> --include-partial
#
# Example output:
#   state	validation_decision	type	path	title
#   Implemented	Pass	story	docs/epics/active/auth/story_login.md	Add login flow
#   Partial Implemented	Partial	bugfix	docs/standalone-changes/active/bugfix_cache.md	Fix stale cache
set -euo pipefail

root="."
include_partial="false"

while [ "$#" -gt 0 ]; do
  case "$1" in
    --include-partial)
      include_partial="true"
      shift
      ;;
    --root)
      root="${2:?missing value for --root}"
      shift 2
      ;;
    *)
      root="$1"
      shift
      ;;
  esac
done

artifact_paths() {
  find "$root/docs/epics/active" -path '*/story_*.md' -o -path '*/bugfix_*.md' 2>/dev/null || true
  find "$root/docs/standalone-changes/active" -maxdepth 1 -name 'story_*.md' -o -name 'bugfix_*.md' 2>/dev/null || true
}

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

printf 'state\tvalidation_decision\ttype\tpath\ttitle\n'

artifact_paths | sort | while IFS= read -r file; do
  [ -f "$file" ] || continue
  state="$(field_value "$file" "State")"
  decision="$(section_decision "$file" "Validation Result")"
  case "$state" in
    Implemented)
      printf '%s\t%s\t%s\t%s\t%s\n' "$state" "${decision:-N/A}" "$(type_for "$file")" "$file" "$(title_for "$file")"
      ;;
    "Partial Implemented")
      if [ "$include_partial" = "true" ]; then
        printf '%s\t%s\t%s\t%s\t%s\n' "$state" "${decision:-N/A}" "$(type_for "$file")" "$file" "$(title_for "$file")"
      fi
      ;;
  esac
done

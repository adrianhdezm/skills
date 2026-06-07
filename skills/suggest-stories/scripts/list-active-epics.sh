#!/usr/bin/env bash
set -euo pipefail

root="${1:-.}"
epic_root="$root/docs/epics/active"

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
  sed -n 's/^# Epic: //p' "$1" | head -n 1
}

printf 'state\tepic_validation_decision\tpath\ttitle\n'

[ -d "$epic_root" ] || exit 0

find "$epic_root" -mindepth 2 -maxdepth 2 -name 'epic.md' 2>/dev/null | sort | while IFS= read -r file; do
  [ -f "$file" ] || continue
  printf '%s\t%s\t%s\t%s\n' "$(field_value "$file" "State")" "$(section_decision "$file" "Epic Validation")" "$file" "$(title_for "$file")"
done

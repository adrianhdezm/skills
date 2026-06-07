#!/usr/bin/env bash
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

printf 'state\tplan_validation_decision\ttype\tpath\ttitle\n'

artifact_paths | sort | while IFS= read -r file; do
  [ -f "$file" ] || continue
  state="$(field_value "$file" "State")"
  decision="$(section_decision "$file" "Change Plan Validation")"
  case "$state" in
    Ready|Blocked)
      case "$decision" in
        Pass) ;;
        *) printf '%s\t%s\t%s\t%s\t%s\n' "$state" "${decision:-Missing}" "$(type_for "$file")" "$file" "$(title_for "$file")" ;;
      esac
      ;;
  esac
done

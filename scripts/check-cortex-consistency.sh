#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$root"

output_dir="$root/output/cortex-consistency"
match_file="$output_dir/matches.txt"
failures=0

mkdir -p "$output_dir"

check_absent() {
  local pattern="$1"
  local description="$2"

  if rg -n -- "$pattern" CORTEX.md README.md skills >"$match_file"; then
    echo "FAIL: $description"
    cat "$match_file"
    failures=$((failures + 1))
  fi
}

check_present() {
  local file="$1"
  local pattern="$2"
  local description="$3"

  if ! rg -q -- "$pattern" "$file"; then
    echo "FAIL: $description"
    echo "  Missing pattern in $file: $pattern"
    failures=$((failures + 1))
  fi
}

# These checks prevent old standalone archive wording from returning. Standalone
# changes intentionally remain in place as their durable planning and validation
# record; only epics have an archive workflow.
check_absent "archive standalone|standalone change.*archiv|standalone-changes/archived|Completed standalone" \
  "standalone changes should not use archive workflow language"

# `suggest-stories` is a reusable coverage review helper. It can run after an
# epic passes validation and later while the epic remains active, but it should
# not become a mandatory workflow step.
check_absent "suggest-stories should|-> suggest-stories$" \
  "suggest-stories should remain optional, not a mandatory workflow step"

# Cortex owns the high-level gate policy. Keeping transition rules in the
# process document avoids each skill inventing a different meaning for `Partial`
# or non-passing validation results.
check_present CORTEX.md "Gate transitions:" \
  "CORTEX.md should define validation gate transitions"
check_present CORTEX.md "Partial.*explicitly accepts|explicitly approves" \
  "CORTEX.md should define how Partial results can advance"

# Epic-scoped stories and bugfixes must only be added after the parent epic is
# validated, except for the explicitly documented `Partial` override path.
check_present skills/add-story/SKILL.md "Epic Validation.*Pass" \
  "add-story should require passing epic validation for epic-scoped work"
check_present skills/add-bugfix/SKILL.md "Epic Validation.*Pass" \
  "add-bugfix should require passing epic validation for epic-scoped work"

# ADR criteria should stay aligned with CORTEX.md's decision-record policy, not
# regress to architecture-only decisions.
check_present skills/document-decisions/SKILL.md "Security decisions" \
  "document-decisions should include security ADR criteria"
check_present skills/document-decisions/SKILL.md "Operations and infrastructure decisions" \
  "document-decisions should include operations and infrastructure ADR criteria"
check_present skills/document-decisions/SKILL.md "Platform contracts" \
  "document-decisions should include platform contract ADR criteria"
check_present skills/document-decisions/SKILL.md "Durable product behavior" \
  "document-decisions should include durable product behavior ADR criteria"

if (( failures > 0 )); then
  echo
  echo "$failures consistency check(s) failed."
  exit 1
fi

echo "Cortex consistency checks passed."

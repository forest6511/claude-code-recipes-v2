#!/usr/bin/env bash
set -euo pipefail
git rev-parse --git-dir >/dev/null 2>&1 || exit 0

input=$(cat)
session=$(echo "$input" | jq -r '.session_id // "noid"' | cut -c1-8)
source=$(echo "$input" | jq -r '.source // "startup"')

# 既存変更があれば先に snapshot
if ! git diff --quiet HEAD 2>/dev/null || [ -n "$(git ls-files --others --exclude-standard 2>/dev/null)" ]; then
  git add -A >/dev/null 2>&1 || true
  git commit --allow-empty -m "claude-session-start ${session} (${source}): pre-session snapshot" >/dev/null 2>&1 || true
fi

exit 0

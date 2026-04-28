#!/usr/bin/env bash
set -euo pipefail
input=$(cat)
error=$(echo "$input" | jq -r '.error // "unknown"')
details=$(echo "$input" | jq -r '.error_details // ""')
session=$(echo "$input" | jq -r '.session_id // "noid"')

LOG_DIR="${CLAUDE_PROJECT_DIR:-$PWD}/.claude/logs"
mkdir -p "$LOG_DIR"
echo "$(date -u +%FT%TZ) session=${session} error=${error} details=${details}" \
  >> "$LOG_DIR/stop-failures.log"

# rate_limit のときだけデスクトップ通知
if [ "$error" = "rate_limit" ]; then
  if command -v osascript >/dev/null 2>&1; then
    osascript -e "display notification \"Rate limit hit at session ${session}\" with title \"Claude Code\""
  fi
fi
exit 0

#!/usr/bin/env bash
set -euo pipefail
input=$(cat)
agent_type=$(echo "$input" | jq -r '.agent_type // "unknown"')
session=$(echo "$input" | jq -r '.session_id // "noid"')
last=$(echo "$input" | jq -r '.last_assistant_message // ""' | head -c 500)

LOG_DIR="${CLAUDE_PROJECT_DIR:-$PWD}/.claude/logs"
mkdir -p "$LOG_DIR"
jq -n --arg s "$session" --arg t "$agent_type" --arg msg "$last" \
  '{ts: now, session: $s, agent_type: $t, last: $msg}' \
  >> "$LOG_DIR/subagent-results.jsonl"
exit 0

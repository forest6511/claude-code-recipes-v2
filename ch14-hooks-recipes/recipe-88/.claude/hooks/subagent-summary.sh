#!/usr/bin/env bash
set -euo pipefail
input=$(cat)
agent_id=$(echo "$input" | jq -r '.agent_id // "noid"')
agent_type=$(echo "$input" | jq -r '.agent_type // "unknown"')
last=$(echo "$input" | jq -r '.last_assistant_message // ""' | head -c 200)

LOG_DIR="${CLAUDE_PROJECT_DIR:-$PWD}/.claude/logs"
mkdir -p "$LOG_DIR"
jq -n --arg id "$agent_id" --arg type "$agent_type" --arg msg "$last" \
  '{ts: now, agent_id: $id, agent_type: $type, last: $msg}' \
  >> "$LOG_DIR/subagent-summaries.jsonl"
exit 0

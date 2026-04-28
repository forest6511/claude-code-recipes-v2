#!/usr/bin/env bash
set -euo pipefail
input=$(cat)
LOG_DIR="${CLAUDE_PROJECT_DIR:-$PWD}/.claude/logs"
mkdir -p "$LOG_DIR"
echo "$input" | jq -c '{ts: now, tool: .tool_name, reason: .reason, cmd: .tool_input.command}' \
  >> "$LOG_DIR/auto-mode-denials.jsonl"
exit 0

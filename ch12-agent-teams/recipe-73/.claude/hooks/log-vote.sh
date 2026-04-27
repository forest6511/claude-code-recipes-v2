#!/usr/bin/env bash
# サブエージェント完了時に結論を JSON Lines に追記する
set -euo pipefail

input=$(cat)
agent_type=$(echo "$input" | jq -r '.agent_type // empty')
session_id=$(echo "$input" | jq -r '.session_id // empty')
mkdir -p .claude/logs
echo "$input" >> ".claude/logs/votes-${session_id}.jsonl"
exit 0

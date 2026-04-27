#!/usr/bin/env bash
input=$(cat)
tool=$(echo "$input" | jq -r '.tool_name // empty')

if [[ "$tool" == "Agent" ]]; then
  payload=$(echo "$input" | jq -c '.tool_input // {}')
  echo "$(date -Iseconds) tool=$tool input=$payload" >> .claude/agent-routing.log
fi
exit 0

#!/usr/bin/env bash
set -euo pipefail
input=$(cat)
file=$(echo "$input" | jq -r '.tool_input.file_path // empty')

jq -n --arg f "$file" '{
  hookSpecificOutput: {
    hookEventName: "PreToolUse",
    permissionDecision: "deny",
    permissionDecisionReason: ("Editing secret file is forbidden: " + $f + ". If a value must change, ask the user to update it manually.")
  }
}'

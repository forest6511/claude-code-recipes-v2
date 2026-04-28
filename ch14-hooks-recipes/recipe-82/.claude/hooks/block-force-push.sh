#!/usr/bin/env bash
set -euo pipefail

input=$(cat)
cmd=$(echo "$input" | jq -r '.tool_input.command // empty')

# main / master / production への force push のみブロック
if echo "$cmd" | grep -qE 'git push.*--force.*\b(main|master|production)\b'; then
  jq -n --arg c "$cmd" '{
    hookSpecificOutput: {
      hookEventName: "PreToolUse",
      permissionDecision: "deny",
      permissionDecisionReason: ("Force push to protected branch is not allowed: " + $c)
    }
  }'
  exit 0
fi

exit 0

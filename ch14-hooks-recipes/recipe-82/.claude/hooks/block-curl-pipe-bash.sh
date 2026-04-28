#!/usr/bin/env bash
set -euo pipefail

input=$(cat)
cmd=$(echo "$input" | jq -r '.tool_input.command // empty')

# curl ... | bash / curl ... | sh のパターンのみブロック
if echo "$cmd" | grep -qE 'curl[^|]*\|[^|]*(bash|sh)\b'; then
  jq -n --arg c "$cmd" '{
    hookSpecificOutput: {
      hookEventName: "PreToolUse",
      permissionDecision: "deny",
      permissionDecisionReason: ("curl | bash pattern blocked. Download script first, review, then run: " + $c)
    }
  }'
  exit 0
fi

exit 0

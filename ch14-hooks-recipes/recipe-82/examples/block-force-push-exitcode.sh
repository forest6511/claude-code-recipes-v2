#!/usr/bin/env bash
set -euo pipefail

input=$(cat)
cmd=$(echo "$input" | jq -r '.tool_input.command // empty')

# main / master / production への force push のみブロック
if echo "$cmd" | grep -qE 'git push.*--force.*\b(main|master|production)\b'; then
  echo "BLOCKED: force push to protected branch is not allowed: $cmd" >&2
  exit 2
fi

exit 0

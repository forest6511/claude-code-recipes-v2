#!/usr/bin/env bash
set -euo pipefail

input=$(cat)
tool_name=$(echo "$input" | jq -r '.tool_name // empty')
reason=$(echo "$input" | jq -r '.reason // empty')

# 「path outside the project」系の誤判定だけ retry を許可
if echo "$reason" | grep -qE 'path outside|external (repo|destination)'; then
  jq -n '{hookSpecificOutput: {hookEventName: "PermissionDenied", retry: true}}'
fi

exit 0

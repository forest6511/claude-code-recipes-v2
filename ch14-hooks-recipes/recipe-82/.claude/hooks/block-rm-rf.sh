#!/usr/bin/env bash
set -euo pipefail

input=$(cat)
cmd=$(echo "$input" | jq -r '.tool_input.command // empty')

# 安全な rm-rf パス (build 成果物等) は許可
SAFE_PATHS=(
  "./dist"
  "./build"
  "./node_modules"
  "/tmp/build"
)

for safe in "${SAFE_PATHS[@]}"; do
  if echo "$cmd" | grep -qE "rm -rf $safe(/|$|\s)"; then
    exit 0
  fi
done

# それ以外の rm -rf は全て deny
jq -n --arg c "$cmd" '{
  hookSpecificOutput: {
    hookEventName: "PreToolUse",
    permissionDecision: "deny",
    permissionDecisionReason: ("Destructive rm -rf blocked by hook: " + $c + ". Use specific file paths or scope to ./dist | ./build | ./node_modules.")
  }
}'

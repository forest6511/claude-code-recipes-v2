#!/usr/bin/env bash
set -euo pipefail
input=$(cat)
cmd=$(echo "$input" | jq -r '.tool_input.command // empty')
[ -z "$cmd" ] && exit 0

# 機密性の高い env を直接 echo / printf しているか検出
risky_env_pattern='\$[{]?(AWS_SECRET|AWS_ACCESS_KEY|GITHUB_TOKEN|ANTHROPIC_API_KEY|OPENAI_API_KEY|DATABASE_URL|STRIPE_SECRET)'

if echo "$cmd" | grep -qE "(echo|printf)\s+.*${risky_env_pattern}"; then
  jq -n --arg c "$cmd" '{
    hookSpecificOutput: {
      hookEventName: "PreToolUse",
      permissionDecision: "deny",
      permissionDecisionReason: ("Secret env var print blocked: " + $c + ". Print only fingerprints (e.g., first 4 chars + length) for debugging.")
    }
  }'
  exit 0
fi

# printenv (引数の有無を問わない) も全環境変数列挙でブロック
if echo "$cmd" | grep -qE '(^|[\s;&|])printenv(\s|$|;|&|\|)'; then
  jq -n --arg c "$cmd" '{
    hookSpecificOutput: {
      hookEventName: "PreToolUse",
      permissionDecision: "deny",
      permissionDecisionReason: ("printenv blocked: " + $c + ". Inspect specific safe variables instead.")
    }
  }'
  exit 0
fi

# .env 系ファイルの cat / less / more
if echo "$cmd" | grep -qE '(cat|less|more|head|tail)\s+\S*\.env(\.|$|\s)'; then
  jq -n --arg c "$cmd" '{
    hookSpecificOutput: {
      hookEventName: "PreToolUse",
      permissionDecision: "deny",
      permissionDecisionReason: ("Reading .env via Bash blocked: " + $c + ". Use environment variables in scripts directly.")
    }
  }'
  exit 0
fi

exit 0

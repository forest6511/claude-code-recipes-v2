#!/usr/bin/env bash
set -euo pipefail
input=$(cat)
content=$(echo "$input" | jq -r '.tool_input.content // .tool_input.new_string // empty')
[ -z "$content" ] && exit 0

# 代表的な機密パターン (誤検出を抑えるため正規表現は厳しめ)
patterns=(
  'AKIA[0-9A-Z]{16}'                                          # AWS Access Key ID
  'aws_secret_access_key\s*=\s*["'"'"']?[A-Za-z0-9/+=]{40}'    # AWS Secret (引用符付きも捕捉)
  'ghp_[A-Za-z0-9]{36}'                                       # GitHub Personal Access Token
  'github_pat_[A-Za-z0-9_]{82}'                               # GitHub fine-grained PAT
  'sk-[A-Za-z0-9]{48}'                                        # OpenAI API key (legacy)
  'sk-proj-[A-Za-z0-9_-]{40,}'                                # OpenAI API key (project)
  'sk-ant-[a-z0-9]+-[A-Za-z0-9_-]{80,}'                       # Anthropic API key (api03/admin01等)
  'xox[baprs]-[A-Za-z0-9-]+'                                  # Slack tokens
  '-----BEGIN [A-Z ]*PRIVATE KEY-----'                        # PEM private keys
)

for pattern in "${patterns[@]}"; do
  if echo "$content" | grep -qE "$pattern"; then
    jq -n --arg p "$pattern" '{
      hookSpecificOutput: {
        hookEventName: "PreToolUse",
        permissionDecision: "deny",
        permissionDecisionReason: ("Secret pattern detected (" + $p + "). Use environment variables or secret manager instead.")
      }
    }'
    exit 0
  fi
done

exit 0

#!/usr/bin/env bash
set -euo pipefail
input=$(cat)
prompt=$(echo "$input" | jq -r '.prompt // empty')

# プロンプトに「PR」「review」「ci」が含まれているときだけ動的 context を入れる
if echo "$prompt" | grep -qiE '\b(pr|review|ci)\b'; then
  ctx=""

  # git status (要約) — $'\n' で実改行を埋め込む (通常文字列だと \n がリテラル化する)
  if git rev-parse --git-dir >/dev/null 2>&1; then
    branch=$(git branch --show-current 2>/dev/null || echo "?")
    diff_count=$(git diff --name-only HEAD 2>/dev/null | wc -l | tr -d ' ')
    ctx+=$'Git: branch='"${branch}"$', changed_files='"${diff_count}"$'\n'
  fi

  # 直近の CI 状態 (gh CLI が入っていれば)
  if command -v gh >/dev/null 2>&1; then
    ci=$(gh run list --limit 1 --json status,conclusion,name 2>/dev/null | jq -r '.[0] | "\(.name): \(.status)/\(.conclusion)"' 2>/dev/null || echo "")
    [ -n "$ci" ] && [ "$ci" != "null: null/null" ] && ctx+=$'Latest CI: '"${ci}"$'\n'
  fi

  if [ -n "$ctx" ]; then
    jq -n --arg c "$ctx" '{
      hookSpecificOutput: {
        hookEventName: "UserPromptSubmit",
        additionalContext: $c
      }
    }'
  fi
fi

exit 0

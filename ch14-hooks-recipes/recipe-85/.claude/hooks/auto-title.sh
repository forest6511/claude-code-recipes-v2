#!/usr/bin/env bash
set -euo pipefail
input=$(cat)
prompt=$(echo "$input" | jq -r '.prompt // empty')
session=$(echo "$input" | jq -r '.session_id // empty')

# 既にタイトルが付いている場合は何もしない (上書き防止)
TITLE_MARK="${HOME}/.claude/titled-${session}.flag"
[ -f "$TITLE_MARK" ] && exit 0

# プロンプト先頭 50 文字を整形してタイトル候補にする
title=$(echo "$prompt" | head -c 80 | tr '\n' ' ' | sed -E 's/[[:space:]]+/ /g' | cut -c1-50)
[ -z "$title" ] && exit 0

echo "$title" > "$TITLE_MARK"
jq -n --arg t "$title" '{
  hookSpecificOutput: {
    hookEventName: "UserPromptSubmit",
    sessionTitle: $t
  }
}'
exit 0

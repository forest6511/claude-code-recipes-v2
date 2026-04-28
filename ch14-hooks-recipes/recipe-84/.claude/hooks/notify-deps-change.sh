#!/usr/bin/env bash
set -euo pipefail
input=$(cat)
file=$(echo "$input" | jq -r '.file_path // empty')
event=$(echo "$input" | jq -r '.event // empty')

# 依存関係が外部で更新された (例: 別ターミナルで pnpm install) ことをユーザーに通知
if [ "$event" = "change" ] || [ "$event" = "add" ]; then
  jq -n --arg f "$file" \
    '{systemMessage: ("Dependency manifest changed externally: " + $f + ". Run install if needed.")}'
fi
exit 0

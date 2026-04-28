#!/usr/bin/env bash
set -euo pipefail
input=$(cat)
message=$(echo "$input" | jq -r '.message // empty')
session=$(echo "$input" | jq -r '.session_id // "?"')

# session_id から保存しておいたタイトルを引く (auto-title.sh で書いた flag に併記)
TITLE_FILE="${HOME}/.claude/titled-${session}.flag"
title="(unnamed)"
[ -s "$TITLE_FILE" ] && title=$(cat "$TITLE_FILE")

osascript -e "display notification \"$message\" with title \"Claude: $title\""
exit 0

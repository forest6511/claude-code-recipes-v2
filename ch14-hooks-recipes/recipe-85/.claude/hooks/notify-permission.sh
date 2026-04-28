#!/usr/bin/env bash
set -euo pipefail
input=$(cat)
title=$(echo "$input" | jq -r '.title // "Claude Code"')
message=$(echo "$input" | jq -r '.message // empty')

# macOS: osascript で通知 + サウンド
if command -v osascript >/dev/null 2>&1; then
  osascript -e "display notification \"$message\" with title \"$title\" sound name \"Glass\""
fi
exit 0

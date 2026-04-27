#!/usr/bin/env bash
input=$(cat)
cmd=$(echo "$input" | jq -r '.tool_input.command // empty')
[ -n "$cmd" ] && echo "$(date -u +%FT%TZ) BASH: $cmd" >> "$HOME/.claude/bash.log"
exit 0

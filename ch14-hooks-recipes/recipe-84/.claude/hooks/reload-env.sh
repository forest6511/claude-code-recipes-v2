#!/usr/bin/env bash
set -euo pipefail
input=$(cat)
file=$(echo "$input" | jq -r '.file_path // empty')
event=$(echo "$input" | jq -r '.event // empty')

case "$event" in
  change|add)
    # CLAUDE_ENV_FILE に書き込むと後続 Bash で env が反映される
    if [ -n "${CLAUDE_ENV_FILE:-}" ] && [ -f "$file" ]; then
      # .env を読んで CLAUDE_ENV_FILE に転記 (コメント・空行を除く)
      grep -E '^[A-Z_][A-Z0-9_]*=' "$file" | while IFS= read -r line; do
        echo "export $line" >> "$CLAUDE_ENV_FILE"
      done
    fi
    jq -n --arg f "$file" '{systemMessage: ("Reloaded env from " + $f)}'
    ;;
  unlink)
    jq -n --arg f "$file" '{systemMessage: ("Env file deleted: " + $f + ". Manual reload required.")}'
    ;;
esac

exit 0

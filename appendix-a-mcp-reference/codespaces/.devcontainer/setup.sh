#!/usr/bin/env bash
set -euo pipefail

npm install -g @anthropic-ai/claude-code

# Codespaces Secrets 経由で渡された環境変数を使う
claude mcp add brave-search --scope user --transport stdio \
  --env BRAVE_API_KEY="${BRAVE_API_KEY}" \
  -- npx -y @anthropic-ai/mcp-server-brave-search

claude mcp add github --scope user --transport http \
  https://api.githubcopilot.com/mcp/ \
  --header "Authorization: Bearer ${GITHUB_TOKEN}"

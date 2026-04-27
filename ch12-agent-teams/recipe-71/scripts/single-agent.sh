#!/usr/bin/env bash
set -euo pipefail

claude --agents '{
  "code-reviewer": {
    "description": "Expert code reviewer. Use proactively after code changes.",
    "prompt": "あなたはシニアコードレビュアーです。品質、セキュリティ、ベストプラクティスに焦点を当ててレビューしてください。",
    "tools": ["Read", "Grep", "Glob", "Bash"],
    "model": "sonnet"
  }
}'

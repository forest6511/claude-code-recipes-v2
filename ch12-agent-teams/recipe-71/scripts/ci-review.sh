#!/usr/bin/env bash
# 使い方: ./ci-review.sh <PR番号>
set -euo pipefail

PR_NUMBER="${1:?Usage: $0 <PR_NUMBER>}"

claude --agents '{
  "security-checker": {
    "description": "セキュリティ脆弱性の検査専門。",
    "prompt": "変更ファイルの脆弱性を CVSS スコア付きで報告してください。",
    "tools": ["Read", "Grep", "Glob", "Bash"],
    "model": "sonnet"
  },
  "test-validator": {
    "description": "テストカバレッジ検証専門。",
    "prompt": "変更コードのカバレッジを検証し、不足するテストケースを列挙してください。",
    "tools": ["Read", "Grep", "Glob", "Bash"],
    "model": "haiku"
  }
}' \
  -p "PR #${PR_NUMBER} のコード変更をレビューしてください。security-checker と test-validator の両方を並列に実行してください。" \
  --output-format json

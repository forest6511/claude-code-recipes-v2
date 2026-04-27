#!/usr/bin/env bash
set -euo pipefail

claude --agents '{
  "researcher": {
    "description": "コードベースの調査専門。新規領域の探索で積極的に使用する。",
    "prompt": "指定された領域を調査し、簡潔な構造マップと注目ポイントを返してください。",
    "tools": ["Read", "Grep", "Glob"],
    "model": "haiku"
  },
  "implementer": {
    "description": "コード変更の実装専門。調査結果に基づく実装で使用する。",
    "prompt": "調査結果に基づいて変更を実装し、変更後にテストを実行してください。",
    "tools": ["Read", "Edit", "Write", "Bash", "Grep", "Glob"],
    "model": "sonnet"
  }
}'

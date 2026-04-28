#!/usr/bin/env bash
set -euo pipefail

# 開発サーバ起動 (バックグラウンド、ログをファイルに残す)
npm run dev > .harness/dev-server.log 2>&1 &
echo $! > .harness/dev-server.pid
sleep 3

# 基本機能の e2e 確認 (失敗したら exit 1)
node harness/scripts/smoke-test.mjs

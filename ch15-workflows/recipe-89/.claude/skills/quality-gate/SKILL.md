---
name: quality-gate
description: コード変更後の品質ゲート。format/lint/typecheck/test/audit を順次実行し PASS/FAIL を集計する
disable-model-invocation: true
allowed-tools: Bash(npm *) Bash(npx *) Bash(pytest *) Bash(git diff *) Read
---
# 品質ゲート

このターンで編集したファイルに対し、以下を順番に実行する。各ステップで失敗があれば修正してから次に進む。

1. **静的解析**
   - `npx tsc --noEmit`
   - `npx eslint .`
2. **テスト**
   - `npm test -- --run` (vitest) または `pytest -q`
   - 既存より遅くなった、または落ちたテストを報告
3. **セキュリティ**
   - `npm audit --audit-level=high`
   - `git diff --name-only HEAD~1 | xargs grep -nE 'sk-[A-Za-z0-9]{20,}|AKIA[0-9A-Z]{16}'` でシークレット混入を確認
4. **レポート**
   - 各ステップの PASS/FAIL、修正内容、残課題を 1 つの集計ブロックで返す

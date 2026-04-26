---
name: pr-summary-fork
description: PR の差分とコメントを fork 先で要約する
context: fork
agent: Explore
allowed-tools: Bash(gh *)
---

## PR 情報
- 差分: !`gh pr diff`
- コメント: !`gh pr view --comments`
- 変更ファイル: !`gh pr diff --name-only`

## タスク
上記から以下を生成してください。

1. 変更の概要（3行以内）
2. 変更分類（機能追加 / バグ修正 / リファクタリング）
3. レビュー時に注意すべきポイント
4. テストカバレッジの懸念点

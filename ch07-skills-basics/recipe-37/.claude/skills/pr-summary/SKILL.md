---
name: pr-summary
description: 現在のPRの差分とコメントを要約する
disable-model-invocation: true
context: fork
agent: Explore
allowed-tools: Bash(gh *)
---

## PR 情報
- 差分: !`gh pr diff`
- コメント: !`gh pr view --comments`
- 変更ファイル: !`gh pr diff --name-only`

## タスク
上記の情報から以下を生成してください。

1. 変更の概要（3行以内）
2. 変更分類（機能追加/バグ修正/リファクタリング）
3. レビュー時の注意点

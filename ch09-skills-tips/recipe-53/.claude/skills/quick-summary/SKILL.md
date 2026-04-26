---
name: quick-summary
description: ファイル・PR・Issue の要約。短くまとめて返すだけのタスク向け
when_to_use: 一覧の見出し作成、変更点要約、簡易レポート
model: claude-haiku-4-5
allowed-tools: Read Grep
---

# Quick Summary

短時間で結果を返すための skill。`model: claude-haiku-4-5` を強制することで、Opus セッションで起動してもこの skill だけは Haiku 4.5 で実行される。

## 手順

1. 入力を読み、要点を 5 行以内に圧縮する
2. 形式: 「対象 / 結論 / 根拠 / 次のアクション」
3. 推測を交えず、書かれていることだけを要約する

## 注意

- Haiku 4.5 は `effort` をサポートしない (frontmatter で書いても無視される)
- 深い推論が必要な分析には `deep-analysis` skill を使う

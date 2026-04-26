---
name: review-and-summarize
description: コードレビュー後に PR description のドラフトも生成する
context: fork
agent: Explore
disable-model-invocation: true
allowed-tools: Read Grep Glob Bash(git diff *) Bash(git log *)
---

対象: $ARGUMENTS（未指定の場合は `git diff --staged`）

## タスク
1. 上記対象に code-review と同じ観点でレビューする
2. Critical/High 0 件であれば次に進む。あれば停止して指摘だけ返す
3. PR description ドラフトを以下の形式で生成:

   ## 変更概要
   ## 変更理由
   ## 動作確認
   ## レビュー観点 (Critical/High 0 件の確認結果)

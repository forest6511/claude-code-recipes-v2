---
name: pr-description
description: 現在のブランチの変更から PR description ドラフトを生成する
disable-model-invocation: true
context: fork
agent: Explore
allowed-tools: Bash(git diff *) Bash(git log *) Bash(gh pr list *)
---

## 変更内容
- ブランチの差分: !`git diff $(git merge-base HEAD origin/main)..HEAD`
- コミットログ: !`git log $(git merge-base HEAD origin/main)..HEAD --oneline`

## タスク
上記から以下の形式で PR description ドラフトを生成してください。

## 変更概要
（1〜3行で「何を変えたか」）

## 変更理由
（なぜこの変更が必要か。背景・課題・ユーザー影響）

## 動作確認
- [ ] テスト追加・更新
- [ ] ローカル手動確認
- [ ] CI 緑

## レビュー観点
（特にレビュアーに見てほしい設計判断）

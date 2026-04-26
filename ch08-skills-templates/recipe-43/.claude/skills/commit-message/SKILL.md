---
name: commit-message
description: ステージされた変更から Conventional Commits 形式のメッセージ案を生成する
disable-model-invocation: true
argument-hint: [--amend]
allowed-tools: Bash(git diff *) Bash(git log *) Bash(git status *)
---

ステージされた変更を分析し、Conventional Commits 形式のメッセージ案を生成します。

## 手順
1. `git diff --staged` でステージ内容を確認
2. `git log --oneline -5` で直近のコミット様式を把握
3. type / scope / subject / body の4要素でメッセージを生成
4. `$ARGUMENTS` に `--amend` が含まれていれば、直前コミットへの追加修正としてメッセージを書き直す

## メッセージ形式

   <type>(<scope>): <subject>

   <body>

## type 選択基準
- `feat`: 新機能の追加
- `fix`: バグ修正
- `docs`: ドキュメントの変更
- `refactor`: 振る舞いを変えない構造改善
- `test`: テストの追加・修正
- `chore`: ビルド設定・依存・ツール変更

## ルール
- subject は50文字以内、命令形 (英語の場合) または「〜する」(日本語の場合)
- body は「なぜ」を説明する。「何」はコードを見れば分かる
- 提案メッセージを出力したら停止。実際の commit はユーザーが実行する

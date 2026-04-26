---
name: new-branch
description: 機能説明から命名規約に沿ったブランチ名を提案する
disable-model-invocation: true
argument-hint: [機能の説明]
---

実装したい機能: $ARGUMENTS

## ブランチ命名規約
- `feature/<kebab-case-summary>`: 新機能
- `fix/<issue-number-or-summary>`: バグ修正
- `chore/<summary>`: 設定・依存更新
- `docs/<summary>`: ドキュメント変更

## タスク
1. 機能説明から最も近い type を選ぶ
2. summary を kebab-case で5語以内にまとめる (例: `add-oauth-login`)
3. 提案ブランチ名と、対応する `git checkout -b` コマンドを出力する
4. 実際のブランチ作成はユーザーが実行する

# Project Instructions

(プロジェクト共通の指示)

## Git Workflow

- ブランチ命名: feature/*, fix/*, chore/*, exp/*
- Issue関連ブランチ: feature/issue-<番号>
- コミットメッセージ: Conventional Commits (feat: fix: chore: refactor: test: docs:)
- mainへの直接コミット禁止
- PR作成前に必ずlint+testを実行

## Issue駆動開発フロー

Issue番号を指定された場合:
1. `gh issue view <番号>` で内容を読む
2. `feature/issue-<番号>` ブランチを作成
3. 実装
4. lint+testをパスさせる
5. Conventional Commitsでコミット
6. `gh pr create` でIssueを参照するPRを作成

## コミットメッセージフォーマット

```
<type>(<scope>): <subject>

<body>

<footer>
```

Types:
- feat: 新機能
- fix: バグ修正
- chore: 設定変更、依存関係更新
- docs: ドキュメント更新
- refactor: リファクタリング
- test: テスト追加・修正
- perf: パフォーマンス改善

## 危険な操作

以下は `.claude/settings.json` の `deny` リストで禁止されています。明示的に外さない限り実行されません。

- `git push --force` / `git push -f`
- `git reset --hard`
- `git clean -fd`
- `git branch -D`
- `git checkout --`

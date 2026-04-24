# レシピ16: GitHub Actions + /autofix-pr でPR自動修正

`/autofix-pr` でのクラウド自動修正セッションと、GitHub Actions でのカスタムワークフロー、`@claude review` によるオンデマンドレビューの組み合わせ例。

## ファイル一覧

- `.github/workflows/autofix.yml` — `changes_requested` 提出時に `anthropics/claude-code-action@v1` でPRを自動修正
- `.github/workflows/gate-on-review.yml` — Code Review の severity JSON を読んで Important 件数 > 0 ならCIを失敗させる

## 使い方

```bash
# 1. 現ブランチのPRをクラウドで自動監視
> /autofix-pr

# 2. 修正対象を絞る
> /autofix-pr only fix lint and type errors

# 3. GitHub Actions を有効化するには
# - anthropics/claude-code-action を secrets.ANTHROPIC_API_KEY で使用
# - Claude GitHub App をインストールし、リポジトリ権限を付与

# 4. Code Review を走らせる (Team/Enterprise プラン)
# PR コメント: @claude review  (または @claude review once)
```

## 注意

- `/autofix-pr` は Claude Code on the web へのアクセス権が必要
- GitHub Actions 経由は `ANTHROPIC_API_KEY` が必要（Max/Pro サブスクと別課金）
- Code Review は research preview、Team/Enterprise プラン限定

## 関連

- レシピ15 GitHub MCP Issue/PR 自動化
- レシピ91 CI/CD パイプライン + /autofix-pr

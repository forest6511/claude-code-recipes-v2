# レシピ91: CI/CDパイプライン + /autofix-pr + PR auto-fix Web

3 レイヤー構成のサンプルです。

## ファイル一覧

- `.github/workflows/claude-mention.yml`: Layer A (anthropics/claude-code-action@v1, `@claude` メンション駆動, mode: tag)
- `.github/workflows/migration-batch.yml`: Layer B (`claude --bare -p ... --output-format json` で大規模バッチ移行)

Layer C (`/autofix-pr`) はクライアント側組み込みコマンドのため、リポジトリ内のサンプルなし。本書の手順を参照。

## 使い方

1. `claude setup-token` で OAuth token を発行し、リポジトリの `secrets.CLAUDE_CODE_OAUTH_TOKEN` に保存
2. PR 上で `@claude このテストを直して` のようにメンション → Layer A が起動
3. レガシー一斉移行などは Layer B を `workflow_dispatch` で手動キック
4. ローカル開発中は `/web-setup` の後に `/autofix-pr` で雲セッションに PR 監視を委譲

詳細は本書のレシピ91を参照。

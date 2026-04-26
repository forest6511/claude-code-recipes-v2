---
name: api-docs
description: OpenAPI スキーマから Redocly 静的サイトまたは Markdown ドキュメントを生成する
disable-model-invocation: true
allowed-tools: Read Bash(npx @redocly/cli *)
argument-hint: [openapi.yaml] [--format=html|markdown]
---

入力 OpenAPI: $0
出力フォーマット: $1（デフォルト `html`）

## タスク
1. `--format=html` → `npx @redocly/cli build-docs $0 --output=docs/api/index.html`
2. `--format=markdown` → スキーマを読んで API Reference Markdown を `docs/api.md` に出力
   - 各エンドポイント: HTTP method / path / description / parameters / request body / responses
   - スキーマ参照は anchor リンクで結ぶ
3. 生成完了をユーザーに報告。`--format=html` の場合は `docs/api/index.html` を開くコマンドも提案

## レンダリングのポイント
- HTML 版: Redocly の3カラムレイアウト (ナビ / 説明 / コード例) で生成
- Markdown 版: GitHub の Wiki や Docusaurus にそのまま貼れる形式

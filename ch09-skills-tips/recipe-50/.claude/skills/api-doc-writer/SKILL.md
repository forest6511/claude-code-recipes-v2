---
name: api-doc-writer
description: REST API ドキュメント (OpenAPI 形式) を生成する。新規 API の仕様化、既存 API の文書化、PR レビュー時の API 変更検証で起動
when_to_use: openapi.yaml の更新、API spec の生成、エンドポイント文書化
allowed-tools: Read Grep Glob Edit Write
---

# API Documentation Writer

REST API のドキュメントを OpenAPI 3.1 形式で生成する。

## 起動時の指針

1. ユーザーが API の対象範囲を指定したら、まず `Glob` で関連ハンドラを探す
2. ハンドラの実装を `Read` し、エンドポイント・パス・パラメータを抽出する
3. このセクション以降は必要なときに別ファイルを Read して参照する

## 参照ファイル

詳細な仕様や型定義は以下に配置している。必要なときだけ Read する。

- **OpenAPI スキーマの完全な記法**: [reference/openapi-3.1-cheatsheet.md](reference/openapi-3.1-cheatsheet.md)
- **認証セクションの書き方**: [reference/security-schemes.md](reference/security-schemes.md)
- **エラーレスポンス標準**: [reference/error-responses.md](reference/error-responses.md)
- **CRUD エンドポイントの例**: [examples/crud-endpoints.md](examples/crud-endpoints.md)
- **ページネーション付き list の例**: [examples/paginated-list.md](examples/paginated-list.md)

## バリデーション

生成後、以下のスクリプトで OpenAPI スキーマの構文を検証する。

```bash
${CLAUDE_SKILL_DIR}/scripts/validate-openapi.sh openapi.yaml
```

検証エラーがあれば修正してから報告する。

## 出力

- `openapi.yaml` の追加・更新
- 変更点のサマリー (新規エンドポイント、破壊的変更、非互換性)

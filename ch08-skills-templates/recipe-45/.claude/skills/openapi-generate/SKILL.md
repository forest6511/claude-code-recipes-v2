---
name: openapi-generate
description: API 設計案または既存コードから OpenAPI 3.1 スキーマを生成する
disable-model-invocation: true
context: fork
agent: general-purpose
allowed-tools: Read Edit Write Grep Glob Bash(npx @redocly/cli *) Bash(npx @apidevtools/swagger-cli *)
argument-hint: [api-design 出力 or src/api ディレクトリ]
---

入力: $ARGUMENTS

## タスク
1. 入力が設計テキストの場合: paths / components / schemas を OpenAPI 3.1 形式で `openapi.yaml` に書く
2. 入力がコードディレクトリの場合: ルーティング/型定義を解析して同形式で書く
3. `npx @redocly/cli lint openapi.yaml` でスキーマ検証
4. エラーがあれば修正、最終的に validation pass の状態でメインに返す

## OpenAPI 3.1 構成
- `info`: title / version / description
- `servers`: 環境別 URL
- `paths`: エンドポイント (parameters / requestBody / responses)
- `components.schemas`: 共通データモデル
- `components.securitySchemes`: 認証方式 (Bearer JWT / OAuth2 等)
- `tags`: グループ分け

# レシピ45: API設計 → OpenAPI → ドキュメント自動化

要件→API設計→OpenAPIスキーマ→ドキュメント生成の3段階パイプラインを Skills で連携させる。

## ファイル一覧

| ファイル | 説明 |
|---------|------|
| `.claude/skills/api-design/SKILL.md` | 要件からエンドポイント設計案を生成 (`agent: Plan`) |
| `.claude/skills/openapi-generate/SKILL.md` | 設計案 or コードから OpenAPI 3.1 + Redocly lint |
| `.claude/skills/api-docs/SKILL.md` | OpenAPI から Redocly HTML / Markdown 生成 |
| `.github/workflows/api-docs.yml` | `openapi.yaml` 変更で自動再生成し GitHub Pages に公開 |

## パイプライン

```text
要件
  └─▶ /api-design                  (設計案)
        └─▶ /openapi-generate      (openapi.yaml + lint pass)
              └─▶ /api-docs        (HTML or Markdown)
```

## 共通設計

- `api-design` のみ `agent: Plan` (設計検討に特化、書き込み不可)
- `openapi-generate` `api-docs` は書き込みあり、それぞれ `general-purpose` / inline
- 全 Skill が `disable-model-invocation: true` で明示起動限定

## 呼び出し例

```text
> /api-design ユーザーの注文履歴を取得・登録できる API
> /openapi-generate 上記設計
> /api-docs openapi.yaml --format=html
```

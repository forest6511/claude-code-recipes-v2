# OpenAPI 3.1 チートシート

このファイルは SKILL.md から参照される。Claude が「OpenAPI のスキーマ記法が分からない」と判断したときだけ Read される。

## 基本構造

```yaml
openapi: 3.1.0
info:
  title: My API
  version: 1.0.0
paths:
  /users/{id}:
    get:
      summary: ユーザー取得
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: string
      responses:
        '200':
          description: 成功
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/User'
components:
  schemas:
    User:
      type: object
      properties:
        id:
          type: string
        name:
          type: string
```

## 3.0 から 3.1 への主な変更

- JSON Schema Draft 2020-12 対応
- `type` 配列で nullable を表現 (例: `[string, "null"]`)
- `webhooks` トップレベルキー追加
- `nullable: true` は廃止 (3.0 互換扱い)

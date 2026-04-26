# CRUD エンドポイントの完全例

```yaml
paths:
  /users:
    get:
      summary: ユーザー一覧
      responses:
        '200':
          description: ok
    post:
      summary: ユーザー作成
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/UserCreate'
      responses:
        '201':
          description: created
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
          description: ok
        '404':
          $ref: '#/components/responses/NotFound'
    patch:
      summary: ユーザー更新
      responses:
        '200':
          description: ok
    delete:
      summary: ユーザー削除
      responses:
        '204':
          description: no content
```

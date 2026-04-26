# ページネーション付きリストの例

```yaml
paths:
  /items:
    get:
      summary: アイテム一覧
      parameters:
        - name: cursor
          in: query
          schema:
            type: string
        - name: limit
          in: query
          schema:
            type: integer
            default: 20
            maximum: 100
      responses:
        '200':
          description: ok
          content:
            application/json:
              schema:
                type: object
                properties:
                  items:
                    type: array
                    items:
                      $ref: '#/components/schemas/Item'
                  next_cursor:
                    type: string
                    nullable: true
```

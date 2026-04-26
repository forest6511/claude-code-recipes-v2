---
name: api-design
description: 要件から REST API のエンドポイント設計案を生成する
disable-model-invocation: true
context: fork
agent: Plan
argument-hint: [機能の説明]
---

要件: $ARGUMENTS

## 設計原則
- リソース指向: 名詞単位でパス設計 (例: `users`, `orders` リソース)
- 動詞は HTTP メソッドで表現 (GET / POST / PUT / PATCH / DELETE)
- ネスト深さは2階層まで (例: `users/{id}/orders` は OK、`users/{id}/orders/{oid}/items` は要再設計)
- ページネーションは `?page=N&size=M` または cursor (`?cursor=xxx&limit=N`)
- エラーは RFC 7807 (Problem Details) 形式

## 出力形式
1. エンドポイント一覧 (path / method / description / 認可レベル)
2. 主要リソースのデータモデル (フィールド・型・必須/任意)
3. 設計判断のポイント3〜5件 (なぜこの形にしたかの理由)

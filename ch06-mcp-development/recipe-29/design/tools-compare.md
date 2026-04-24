アンチパターン: API エンドポイントと 1:1 のツール
- list_users()
- get_user(id)
- list_orders(user_id)
- list_notes(user_id)

推奨: ワークフロー単位に集約したツール
- search_customers(query) → 関連度順の候補返却
- get_customer_context(customer_id) → 直近注文 + メモ + ステータスを 1 回で返却

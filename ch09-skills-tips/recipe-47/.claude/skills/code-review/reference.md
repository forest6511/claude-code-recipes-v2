# Code Review 観点詳細

このファイルは SKILL.md から参照される詳細リファレンス。Claude が必要と判断したときだけ Read される。

## 1. 正確性

- 関数の事前条件 / 事後条件が満たされているか
- null / undefined / 空配列 / 0 / 負数の扱い
- 並行アクセス時の race condition

## 2. 可読性

- 関数 50 行以下が望ましい
- 1 関数 1 責務
- 命名は具象名詞 (× `data`, `info` / ○ `userProfile`, `orderTotal`)

## 3. 性能

- ループ内の DB / 外部 API 呼び出し (N+1)
- 不要なディープコピー
- 同期 IO のブロッキング

## 4. セキュリティ

- SQL インジェクション (string concat / template literal)
- XSS (innerHTML / dangerouslySetInnerHTML)
- シークレット (API key, token) のハードコード
- 認可漏れ (ユーザー A が B のデータにアクセス可能)

## 5. テスト

- 境界値テスト (0, 1, max, max+1)
- エラーパステスト (例外、タイムアウト)
- リグレッションテスト (修正したバグの再発防止)

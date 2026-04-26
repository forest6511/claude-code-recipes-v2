---
name: review-code
description: このプロジェクト固有のコードレビュー手順。プラグイン版より厳しい lint 規則を適用する
---

# Project-local Code Review

このプロジェクトでは追加で以下の項目をチェックする。

1. import 順序が `eslint --fix` で修正可能であること
2. 公開 API には JSDoc が必須
3. テスト coverage が 80% 以上

このプロジェクトで `/review-code` を打つとこの skill が起動する。
プラグイン版を明示的に呼ぶときは `/acme-dev-tools:review-code` と入力する。

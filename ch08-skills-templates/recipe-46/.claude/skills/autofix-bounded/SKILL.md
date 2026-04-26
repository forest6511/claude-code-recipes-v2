---
name: autofix-bounded
description: /autofix-pr に組織独自の制約を加えたラッパー
disable-model-invocation: true
argument-hint: [対象観点]
allowed-tools: Bash(gh *)
---

対象観点: $ARGUMENTS（未指定の場合は「lint と型エラーのみ」）

## 制約
- 最大コミット回数: 3
- 対象観点: $ARGUMENTS
- ファイル変更スコープ: src/ 配下のみ (config / migration / docs は触らない)
- 修正コミットには [autofix] プレフィックスを付ける
- セキュリティ関連の修正は別 PR に分離する

## 実行
上記制約を含めて `/autofix-pr` の指示文を組み立て、CI が autofix を起動するようコマンドを出力する。
直接 /autofix-pr を呼び出すのではなく、CI 側で同等の制約付き呼び出しを行うコマンドを提案して終わる。

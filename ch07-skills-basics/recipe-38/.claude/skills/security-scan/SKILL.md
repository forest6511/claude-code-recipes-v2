---
name: security-scan
description: コードベースまたは指定ファイルのセキュリティスキャンを実施する
context: fork
agent: security-auditor
disable-model-invocation: true
---

以下の対象に対してセキュリティ監査を実施してください。

対象: $ARGUMENTS（未指定の場合は src/ 配下全体）

## チェック項目
1. インジェクション (SQL / コマンド / XSS)
2. 認証・認可の不備
3. 機密情報のハードコード・ログ出力
4. 既知の脆弱性を含む依存関係

## 出力形式
重要度ごとに「ファイル:行番号 -> 問題 -> 推奨対策」の3点セットで列挙してください。

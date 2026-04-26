---
name: security-review
description: セキュリティ観点に絞ったコードレビュー
context: fork
agent: Explore
allowed-tools: Read Grep Glob Bash(git diff *)
---

対象: $ARGUMENTS（未指定の場合は `git diff --staged`）

## チェック項目
1. 入力検証 (SQL / コマンド / XSS)
2. 認証・認可の不備
3. 機密情報のハードコード・ログ出力
4. 暗号化の不適切な使用 (弱いアルゴリズム、ECB モード等)
5. CSRF / SSRF / Path Traversal
6. 依存ライブラリの既知脆弱性 (lockfile に SHA がある場合)

## 出力形式
OWASP Top 10 のカテゴリにマッピングし、Critical/High/Medium/Low で分類して列挙してください。

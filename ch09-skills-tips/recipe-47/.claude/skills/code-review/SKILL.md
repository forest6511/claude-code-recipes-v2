---
name: code-review
description: コードレビューを5観点（正確性/可読性/性能/セキュリティ/テスト）で実施する。レビュー指摘や改善提案を求められた時、PRレビュー、コミット前チェックで起動
when_to_use: pull request review, before merge, refactoring の妥当性確認
allowed-tools: Read Grep Glob
---

# Code Review Skill

5観点でコードを精査し、Critical/High/Medium/Low の4段階で指摘する。

## 観点

1. **正確性**: 仕様との一致、edge case の漏れ
2. **可読性**: 命名、関数長、責務分離
3. **性能**: 計算量、N+1、不要なコピー
4. **セキュリティ**: 入力検証、認可、シークレット混入
5. **テスト**: カバレッジ、境界値、回帰防止

詳細な観点定義は [reference.md](reference.md) を参照。
レビュー出力フォーマットの例は [examples.md](examples.md) を参照。

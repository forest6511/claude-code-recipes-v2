---
name: security-sast
description: Semgrep でコード自体の脆弱性 (SAST) をスキャンする
disable-model-invocation: true
context: fork
agent: general-purpose
allowed-tools: Read Grep Glob Bash(semgrep *)
argument-hint: [対象ディレクトリ]
---

対象: $ARGUMENTS（未指定の場合は `src/`）

## タスク
1. `semgrep --config=auto $ARGUMENTS --json` を実行
2. 結果から重要度別 (ERROR=Critical, WARNING=High, INFO=Medium) に分類
3. 検出ルールが OWASP Top 10 のどのカテゴリに該当するか判定
4. ファイル:行番号 → 問題 → 推奨修正 → OWASP カテゴリの4列で出力
5. Critical/High 0 件かどうかを最終行サマリで報告

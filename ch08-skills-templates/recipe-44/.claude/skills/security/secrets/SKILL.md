---
name: security-secrets
description: コードとコミット履歴に紛れた機密情報 (API キー、パスワード、トークン) を検出する
disable-model-invocation: true
context: fork
agent: general-purpose
allowed-tools: Read Grep Glob Bash(gitleaks *) Bash(trufflehog *)
argument-hint: [--git-history|--current]
---

対象スコープ: $ARGUMENTS（`--git-history` で全履歴、`--current` で作業ツリーのみ）

## タスク
1. 引数に応じて適切なコマンドを選択:
   - `--git-history`: `gitleaks detect --source . --report-format json`
   - `--current`: `gitleaks detect --no-git --source . --report-format json`
   - 引数なしのデフォルト: `--current` 相当
2. 検出結果から以下を抽出:
   - パターン種別 (AWS Key / GitHub Token / Generic API Key 等)
   - ファイル:行番号
   - コミット SHA (履歴スキャン時)
3. 全件 Critical 扱いで出力。コミット履歴に出た場合は `git filter-repo` または BFG での履歴書き換えを推奨

# Recipe 06: パーミッション設計

permission mode と permissions.allow / ask / deny の 3 層ルールを使い分ける例。

## ファイル構成

- `.claude/settings.json` — team-shared。defaultMode + allow/ask/deny の 3 層
- `.claude/settings.local.json` — 個人の追加 allow（gh CLI など個人ツール）
- `managed-settings.json` — 組織配布例（disableBypassPermissionsMode / disableAutoMode）

`managed-settings.json` は実際には OS の管理ポリシー領域に配置する
（macOS `/Library/Application Support/ClaudeCode/managed-settings.json` など）。
このリポでは配布例として提示。

## 関連レシピ

- レシピ01 effective-claude-md
- レシピ05 settings.json
- レシピ58 subagent-permissions

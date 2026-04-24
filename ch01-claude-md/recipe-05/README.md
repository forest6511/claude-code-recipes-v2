# Recipe 05: settings.json実践設定 + managed-settings.d/

settings.json の 4 スコープ（Managed / User / Project / Local）を使い分ける例。

## ファイル構成

- `.claude/settings.json` — team-shared project settings（permissions.allow/deny、env）
- `.claude/settings.local.json` — 個人のプロジェクト限定設定（autoMemoryDirectory、claudeMdExcludes）
- `managed-settings.d/10-telemetry.json` — 組織 drop-in ポリシー断片（テレメトリー無効化）
- `managed-settings.d/20-security.json` — 組織 drop-in ポリシー断片（コマンド制限 + 個人ルール禁止）

`managed-settings.d/` は実際には OS の管理ポリシー領域に配置する（macOS `/Library/Application Support/ClaudeCode/managed-settings.d/` など）。このリポでは配布例として提示している。

## 関連レシピ

- レシピ01 effective-claude-md
- レシピ02 claude-md-hierarchy
- レシピ06 permission-design

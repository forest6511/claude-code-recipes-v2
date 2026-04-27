# レシピ76: 20+ Hooks イベント完全マップ

公式 `hooks.md` の Hook events 節に列挙された全 28 イベントをライフサイクル上の役割で 9 グループに分類し、Hook 配置の判断基準として使うリファレンスです。

## ファイル一覧

- `.claude/settings.json` — Hook 3 層構造の最小例（PreToolUse + Bash matcher）
- `.claude/hooks/log-bash.sh` — Bash コマンドを `~/.claude/bash.log` にログする最小スクリプト

## 9 グループ分類

1. **セッションライフサイクル** (5): SessionStart / InstructionsLoaded / ConfigChange / CwdChanged / SessionEnd
2. **各ターン** (4): UserPromptSubmit / UserPromptExpansion / Stop / StopFailure
3. **ツール実行ループ** (6): PreToolUse / PermissionRequest / PermissionDenied / PostToolUse / PostToolUseFailure / PostToolBatch
4. **サブエージェント** (2): SubagentStart / SubagentStop
5. **Agent Teams** (3): TaskCreated / TaskCompleted / TeammateIdle
6. **Worktree** (2): WorktreeCreate / WorktreeRemove
7. **コンテキスト圧縮** (2): PreCompact / PostCompact
8. **MCP elicitation** (2): Elicitation / ElicitationResult
9. **その他** (2): FileChanged / Notification

## 設計ポイント

- matcher 非対応イベント (UserPromptSubmit / PostToolBatch / Stop / TeammateIdle / TaskCreated / TaskCompleted / WorktreeCreate / WorktreeRemove / CwdChanged) は Hook スクリプト側で payload を見て早期 return する
- `Stop` Hook はサブエージェント内では自動的に `SubagentStop` に変換される
- exit 2 でブロックできるイベントは PreToolUse / SubagentStop / TaskCreated / TaskCompleted / TeammateIdle など限定

## 関連

- レシピ77「settings.jsonでHooks定義 + Conditional Hooks」
- レシピ78「マッチャーパターンでツールをフィルタリング」
- レシピ79「Hooksのデバッグ + 大出力ディスク永続化」

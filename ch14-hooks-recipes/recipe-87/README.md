# Recipe 87: prompt/agent型Hooks + UserPromptSubmit動的コンテキスト

LLM ベースの judgement (prompt 型 / agent 型 hook) と、UserPromptSubmit による動的コンテキスト注入を統合。v4 の `!``command``` 動的コンテキストは UserPromptSubmit に吸収。

## ファイル構成

- `.claude/settings.json` — Stop hook の prompt 型評価 (Haiku で全タスク完了判定)
- `.claude/hooks/inject-context.sh` — UserPromptSubmit で「PR/review/ci」キーワード検出時のみ git/CI 状態を additionalContext で注入
- `examples/settings-agent-test-verify.json` — Stop hook の agent 型 (テスト実行 + 結果解析、experimental)
- `examples/settings-prompt-context.json` — inject-context.sh の登録例
- `examples/settings-prompt-guard.json` — UserPromptSubmit に prompt 型 hook で破壊的プロンプトを LLM 判定ブロック

## 設計の要点

- prompt 型 hook (type: "prompt"): LLM 1 ターン評価、`{ok: true|false, reason}` レスポンス、Haiku デフォルト、$ARGUMENTS で input JSON 埋め込み
- agent 型 hook (type: "agent"): subagent 起動 + 50 ターン上限 + Read/Grep/Glob、experimental
- 11 event 限定 (PreToolUse / PostToolUse / Stop / SubagentStop / TaskCreated / TaskCompleted / PermissionRequest / PostToolBatch / PostToolUseFailure / UserPromptSubmit / UserPromptExpansion)
- UserPromptSubmit additionalContext は discretely、plain stdout は transcript に表示
- `!``command``` リテラル展開と Hook 経由 additionalContext の併用が現実的

## 参照

- `~/.claude/docs/claude-code/hooks.md` Prompt-based hooks 節 (L2233-2346)、Agent-based hooks 節 (L2348-2398)、UserPromptSubmit 節 (L849-905)

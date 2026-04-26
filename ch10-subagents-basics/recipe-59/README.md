# レシピ59: Context engineering

サブエージェント設計に context engineering 観点 (system prompt / tools / examples / memory の 4 層) を適用する応用レシピです。Anthropic Engineering Blog (2025-09) の `effective-context-engineering-for-ai-agents` を一次ソースとして再構成しました。

## 含まれるサンプル

- `.claude/agents/api-doc-writer.md` — right altitude system prompt の例 (3 ブロック構成: Process / Rules / 簡潔な指示)
- `.claude/agents/log-investigator.md` — just-in-time tools 利用の例 (Grep → Read → Bash の段階的探索)
- `.claude/agents/api-developer.md` — `skills:` フィールドで起動時にスキル注入
- `.claude/agents/code-reviewer-with-memory.md` — `memory: project` で永続的な作業領域

## 関連レシピ

- レシピ55「Taskツールの仕組みと独立コンテキスト」
- レシピ57「カスタムエージェント + initialPrompt + /agents tabbed」
- レシピ58「サブエージェントの権限制御とツール制限」
- レシピ50「トークン最小化 + 段階的読み込みアーキテクチャ」

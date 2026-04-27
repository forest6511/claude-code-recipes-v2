# レシピ75: Agent Teams の evals / observability を計測する

Agent Teams の trial を headless モードで反復実行し、`SubagentStop` / `TaskCompleted` Hook で teammate 単位のメトリクスを蓄積、`pass@k` / `pass^k` を算出するための eval harness の最小構成です。一次ソースは Anthropic Engineering Blog「Demystifying evals for AI agents」（2026-01）。

## ファイル一覧

- `evals/tasks/auth-bypass-fix.yaml` — task の例（id / desc / team_composition / graders / tracked_metrics）
- `evals/run-trial.sh` — `claude -p ... --output-format json` で 1 trial 実行
- `evals/run-suite.sh` — capability / regression suite 単位で k 回反復
- `evals/aggregate.py` — pass@k / pass^k 計算
- `.claude/hooks/log-trial.sh` — SubagentStop と TaskCompleted を JSON Lines に蓄積
- `.claude/settings.json` — Hook 登録 + `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1`

## 構成要素

- **task**: 1 つのテストケース（id + desc + graders）
- **trial**: task の 1 回の試行
- **grader**: deterministic_tests / state_check / llm_rubric の組み合わせ
- **transcript**: メイン session と teammate 別の `agent_transcript_path`
- **outcome**: 環境の最終状態（テスト結果 / ファイル変更数）

## suite の運用

- **capability suite**: pass@1 が低い「登る山」task。週次ローカル実行
- **regression suite**: pass@1 ≈ 100% の安定 task。CI で `pass^k >= 0.95` を要求

## 関連

- レシピ69「Routingパターン」
- レシピ73「Votingパターン（合意形成）」
- レシピ74「70/20/10 Advisor でチームコスト最適化」
- レシピ87「prompt/agent型Hooks + UserPromptSubmit動的コンテキスト」

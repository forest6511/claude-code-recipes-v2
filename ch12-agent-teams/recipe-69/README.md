# レシピ69: Routingパターン

タスクの複雑度に応じてモデル・エージェント・effort レベルを振り分けるパターンの例です。`description` ベースの自動委譲、明示的な振り分け、Hooks による監査をカバーします。

## ファイル一覧

- `.claude/agents/quick-task.md`: Haiku モデルの高速タスク処理エージェント（ファイル検索、構文チェック、フォーマット）
- `.claude/agents/standard-task.md`: Sonnet モデルのバランス型エージェント（バグ修正、テスト作成、コードレビュー）
- `.claude/agents/architect.md`: Opus + `effort: high` の設計エージェント（アーキテクチャ設計、大規模リファクタリング）
- `.claude/hooks/log-agent-routing.sh`: ルーティング履歴を記録する PreToolUse Hook
- `CLAUDE.md`: プロジェクト全体のルーティングガイドライン
- `prompts/routing-examples.txt`: 明示的なルーティング指示のプロンプト例

## 使い方

1. `.claude/` を対象プロジェクトの `.claude/` にコピーする
2. メイン会話で曖昧な依頼をすると、`description` ベースで自動委譲される
3. 明示的に指定する場合は `@agent-quick-task` のような typeahead 補完を使う

```text
> src/utils/の型定義エラーを検出して
> ログイン機能のバグを修正して
> 認証システム全体のリアーキテクチャを計画して
```

## 設計のポイント

- `description` に具体名詞 + 「積極的に使用する」を含めると、自動委譲の判定精度が上がる
- 迷う場合は上位モデルに振り分ける方が安全（誤ルーティングの再作業コスト > モデルコスト差）
- `CLAUDE.md` にルーティングガイドラインを記述するとプロジェクト全体で一貫した振り分けになる
- Hooks で `Agent` ツール呼び出しをログに残すと、想定外のエージェント選択を検出できる

## 関連レシピ

- レシピ09「モデル選択戦略」
- レシピ56「エージェント種別の使い分け」
- レシピ59「Context engineering」
- レシピ74「70/20/10 Advisor でチームコスト最適化」

# レシピ66: 並列レイヤー開発（複数パッケージ同時）

Agent Teams で各レイヤー（フロントエンド・バックエンド・テスト）を担当するチームメイトを配置し、ファイル衝突を避けつつ並列に開発を進めるパターンの例です。レイヤー間の契約共有、plan approval、TaskCompleted Hook による衝突検出を扱います。

## ファイル一覧

- `prompts/parallel-dev.txt`: 3層並列チーム開発の指示プロンプト例
- `prompts/plan-approval.txt`: plan approval で品質を担保するプロンプト例
- `.claude/settings.json`: TaskCompleted Hook の設定例
- `.claude/hooks/check-task-completion.sh`: バックエンドタスク完了時に型チェックを走らせる Hook スクリプト
- `.claude/agents/backend-architect.md`: バックエンドレイヤー特化型サブエージェント定義の例

## 使い方

1. `.claude/settings.json` をプロジェクトに配置するか、`CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` を環境変数として設定する
2. リーダーセッションで `claude` を起動する
3. `prompts/parallel-dev.txt` の内容をリーダーに送り、3レイヤー構成のチームを作る
4. 高リスクなタスクには `prompts/plan-approval.txt` の指示を追加する
5. バックエンドタスクが完了するたびに、Hook が型チェックを実行する

## ファイル分割の原則

担当ディレクトリの分割例は次のとおりです。

- バックエンド: `src/api/`, `src/models/`, `src/services/`
- フロントエンド: `src/components/`, `src/hooks/`, `src/pages/`
- テスト: `tests/unit/`, `tests/e2e/`, `tests/fixtures/`

2人のチームメイトが同じファイルを編集すると上書きが発生します。各チームメイトが担当するファイルセットを明示的に分離してください。

## 関連レシピ

- レシピ65「Agent Teams基礎」
- レシピ67「共有タスクリストと自律スケジューリング」
- レシピ68「native isolation: worktree でブランチ分離」
- レシピ70「バックグラウンド実行」

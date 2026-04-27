# レシピ67: 共有タスクリストと自律スケジューリング

Agent Teams の共有タスクリストを活用し、依存関係付きタスクとセルフクレームでチームメイトに自律的にスケジューリングさせるパターンの例です。

## ファイル一覧

- `prompts/task-list-creation.txt`: 依存関係付きタスクリスト作成のプロンプト例
- `prompts/task-management.txt`: タスクの表示・割り当て・確認の操作例
- `.claude/settings.json`: TaskCreated Hook の設定例
- `.claude/hooks/check-task-naming.sh`: タスク命名規則 + 説明文必須化を強制する Hook

## 使い方

1. `.claude/settings.json` をプロジェクトに配置するか、`CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` を環境変数として設定する
2. リーダーセッションで `prompts/task-list-creation.txt` の内容を送り、依存関係付きタスクリストを作成する
3. in-process モードでは `Ctrl+T` でタスクリストを表示
4. リーダーにタスク操作を指示する

```text
> タスクリストを表示して
> タスク3をバックエンドチームメイトに割り当てて
> タスク2のステータスを確認して
```

## タスクの3状態

- `pending`: 未着手（依存タスクが未完了ならブロック状態）
- `in_progress`: 作業中
- `completed`: 完了

依存タスクが completed になると、依存していた pending タスクが自動で claim 可能になります。

## 割り当て方式

- **リーダー割当**: リーダーがタスクをチームメイトに直接割り当てる方式。専門スキルで分担を固定したい場合に使う
- **セルフクレーム**: チームメイトが完了後に未割当・依存解決済みのタスクから自動で次を claim する方式。柔軟な並列維持に使う

## 関連レシピ

- レシピ65「Agent Teams基礎」
- レシピ66「並列レイヤー開発（複数パッケージ同時）」
- レシピ72「Map-Reduceパターン（分散実行と統合）」
- レシピ87「prompt/agent型Hooks + UserPromptSubmit動的コンテキスト」

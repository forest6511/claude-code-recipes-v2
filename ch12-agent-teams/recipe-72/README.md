# レシピ72: Map-Reduceパターン（分散実行と統合）

入力を「自然な独立性」を持つ単位に分割し、サブエージェントや Agent Teams のチームメイトで並列処理 (Map) してから、メイン会話で結果を集約 (Reduce) する設計です。

## ファイル一覧

- `prompts/map-reduce-codebase-review.txt` — ディレクトリ単位のレビュー Map 例
- `prompts/map-reduce-team.txt` — Agent Teams で 4 チームメイト並列のテスト修正
- `prompts/output-schema.txt` — Map 出力 JSON スキーマ
- `prompts/oracle-divide.txt` — GCC オラクル比較で単一巨大タスクを分解する例
- `prompts/reduce-deduplicate.txt` — 重複解消の Reduce 設計
- `.claude/hooks/log-reduce-pattern.sh` — Reduce パターンを CLAUDE.md に追記する Hook

## 使い分け

- 1 グループ数千行: サブエージェント (隔離コンテキスト)
- 1 グループ数万行以上: Agent Teams チームメイト (独立コンテキストウィンドウ)

## オラクル分解の典型例

- テストスイート: 失敗テストごとに独立タスク化
- コンパイラ: GCC との差分があるファイルだけタスク化
- 型システム: tsc エラーがあるファイルだけタスク化
- lint: ルール違反があるファイルだけタスク化

## 関連レシピ

- レシピ60「並列実行で大規模コードベースを高速調査」
- レシピ65「Agent Teams基礎」
- レシピ67「共有タスクリストと自律スケジューリング」
- レシピ73「Votingパターン（合意形成）」

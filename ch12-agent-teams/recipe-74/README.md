# レシピ74: 70/20/10 Advisor でチームコスト最適化

サブエージェントとチームメイトの `model` を Worker（Haiku）/ Builder（Sonnet）/ Advisor（Opus）の 3 段階に固定し、呼び出し件数を目安として 70 / 20 / 10 に分配することで、Agent Teams のコスト膨張を抑える本書独自パターンです。

## ファイル一覧

- `.claude/agents/log-scanner.md` — Worker 例（Haiku、読み取り専用、ログ集計）
- `.claude/agents/api-builder.md` — Builder 例（Sonnet、API 実装）
- `.claude/agents/architecture-advisor.md` — Advisor 例（Opus、`permissionMode: plan`、判断のみ）
- `CLAUDE.md` — `description` ベースのルーティングを補強する明示ルール

## 役割階層

- **Worker (~70%) = Haiku**: 探索・grep・形式変換・量的作業。判断を伴わない
- **Builder (~20%) = Sonnet**: 仕様が確定済みの実装、テスト、リファクタ
- **Advisor (~10%) = Opus**: 設計判断・プランレビュー・セカンドオピニオン。実装はしない

## 計測

`/usage`（旧 `/cost` と `/stats` を統合）でモデル別の呼び出し件数と料金内訳を確認します。配分そのものよりも、件数と料金の乖離パターンから設計の歪みを検出します。

## 関連

- レシピ09「モデル選択戦略」
- レシピ56「エージェント種別の使い分け」
- レシピ69「Routingパターン」
- レシピ75「Agent Teams の evals / observability を計測する」

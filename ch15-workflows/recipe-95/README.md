# レシピ95: Harness Engineering

長時間エージェント向けの 5 層ハーネス。Anthropic Engineering "Effective harnesses for long-running agents" (2025-11) を参考にした実装テンプレート。

## ファイル一覧

- `harness/prompts/initializer.md`: 初期化エージェントのシステムプロンプト
- `harness/prompts/coding.md`: 継続作業エージェントのシステムプロンプト
- `harness/feature_list.json`: 機能要件 JSON (passes フィールドのみ書き換え可)
- `harness/scripts/init.sh`: 開発サーバ起動 + e2e smoke test 起動スクリプト
- `harness/claude-progress.txt`: セッション間の引き継ぎノート

## 使い方

1. **初期化セッション (1 回だけ)**:
   `claude --append-system-prompt "$(cat harness/prompts/initializer.md)" "ユーザー要件をここに記述"`
   → feature_list.json + init.sh + claude-progress.txt をコミット
2. **継続セッション (毎回)**:
   `claude --append-system-prompt "$(cat harness/prompts/coding.md)"`
   → 立ち上げ手順 → 1 機能実装 → claude-progress 追記 → commit

## 設計の 5 層

1. 初期化エージェントで scaffold 作成 (実装させない)
2. feature_list.json は immutable な仕様書 (passes 以外編集禁止)
3. 継続作業エージェントは 1 セッション 1 機能
4. end-to-end 検証 (Playwright/Puppeteer) を init.sh から強制
5. claude-progress.txt で前任者ノートを蓄積

詳細は本書のレシピ95を参照。

## 出典

Anthropic Engineering Blog "Effective harnesses for long-running agents" (2025-11-26)

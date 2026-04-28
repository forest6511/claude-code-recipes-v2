# レシピ99: Computer Use で native アプリ E2E テスト

レシピ98 の Computer Use を使って、macOS native アプリや iOS Simulator アプリの E2E テストを 1 セッションで通すサンプル。

## ファイル一覧

- `test-plans/native-smoke.md`: 検証項目を構造化したテストプラン (Claude への入力)
- `test-runs/2026-04-28-native-smoke.md`: 実行結果の構造化サンプル (Claude の出力を整形)

## 使い方

1. レシピ98 の手順で Computer Use を有効化
2. テストプラン (`test-plans/<scenario>.md`) を作成
3. Claude にテストプラン参照付きで指示: `test-plans/native-smoke.md の検証項目を順番に実行してください`
4. アプリ承認プロンプトに対応 (Xcode, 対象アプリ, Simulator 等)
5. 結果を `test-runs/<date>-<scenario>.md` に Claude が出力 → git commit

## 設計の考え方

- 探索的テスト・視覚バグ再現に Computer Use を使う
- 回帰テストは XCTest / Maestro / Detox 等の専用ツールに固定
- 同時 1 セッション制限のため CI 並列実行は不可
- 結果を日付付き Markdown で永続化 (レシピ95 Harness Engineering と同思想)

## 出典

- 公式 docs: https://code.claude.com/docs/en/computer-use

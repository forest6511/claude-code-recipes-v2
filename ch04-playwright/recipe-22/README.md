# レシピ22: アクセシビリティテスト自動化（WCAG）

自動スキャン（axe-core）と意味的チェック（Claude + `browser_snapshot`）を組み合わせた2層のWCAG 2.2 AA準拠チェック。

## ファイル一覧

- `.mcp.json`: Playwright MCP `--caps testing` 設定
- `tests/a11y.spec.ts`: 3ページ対象の axe-core 自動スキャン
- `tests/a11y-gated.spec.ts`: critical 違反のみゲートする段階導入版
- `.github/workflows/a11y.yml`: CI ワークフロー（PR ごとに axe-core 実行）
- `a11y-prompt.md`: Claude への意味的レビュー用プロンプトテンプレート

## セットアップ

```bash
npm install --save-dev @axe-core/playwright @playwright/test
npx playwright install --with-deps
```

## 実行

### 自動スキャン

```bash
npx playwright test tests/a11y.spec.ts
```

### 意味的レビュー

Claude Code に `a11y-prompt.md` の内容を入力して、`browser_snapshot` ベースの監査を依頼します。

## 対応する WCAG タグ

- `wcag2a` / `wcag2aa`: WCAG 2.0 レベル A / AA
- `wcag21a` / `wcag21aa`: WCAG 2.1 レベル A / AA
- `wcag22aa`: WCAG 2.2 レベル AA（ターゲットサイズ・Focus Appearance など）
- `best-practice`: W3C 勧告外の axe-core 推奨ルール

## 検出できる主な問題

axe-core 自動検出:
- 画像の alt 属性欠落（WCAG 1.1.1）
- コントラスト不足（WCAG 1.4.3）
- 重複する id / 不正な ARIA（WCAG 4.1.1, 4.1.2）
- ターゲットサイズ不足（WCAG 2.2 2.5.8）

Claude 意味的レビュー:
- 見出し階層の飛び（WCAG 1.3.1）
- リンクテキストの曖昧さ（WCAG 2.4.4）
- エラーメッセージの関連付け（WCAG 3.3.1）
- ランドマークロールの配置（WCAG 1.3.6）

## 2つの結果を統合する運用

- 毎PR: axe-core 自動スキャン（CI ゲート、critical 0 を必須）
- 週次/月次: Claude 意味的レビュー（リリース前やデザイン変更時）

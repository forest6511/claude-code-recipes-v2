# レシピ22: アクセシビリティテスト自動化（WCAG）

自動スキャン（axe-core）と意味的チェック（Claude + `browser_snapshot`）を組み合わせた2層のWCAG 2.2 AA準拠チェック。

## ファイル一覧

- `.mcp.json`: Playwright MCP `--caps testing` 設定
- `tests/a11y.spec.ts`: 3ページ対象の axe-core 自動スキャン
- `tests/a11y-gated.spec.ts`: critical 違反のみゲートする段階導入版
- `.github/workflows/a11y.yml`: CI ワークフロー（PR ごとに axe-core 実行）
- `a11y-prompt.md`: Claude への意味的レビュー用プロンプトテンプレート
- `demo/server.js`: テスト対象のデモストア（依存なし。`/`・`/products/1`・`/cart`・`/sitemap.xml`）
- `scripts/audit-sitemap.mjs`: sitemap.xml の全URLを監査するスクリプト（axe-core + 意味的チェック + フォーカス枠コントラスト）

## セットアップ

```bash
npm install --save-dev @axe-core/playwright @playwright/test
npx playwright install --with-deps
```

## 実行

### デモサーバーの起動

```bash
node demo/server.js   # http://localhost:3000
```

デモストアは WCAG 2.2 AA 対応済みの状態です。主な対応点:

- フォーカス枠: 白背景では紺、紺背景のヘッダーではオレンジ（どちらも 3:1 以上、1.4.11）
- 「本文へスキップ」リンク（2.4.1）と、ナビの `aria-current="page"`（1.3.1）
- 数量フォームの独自検証: エラー文を `aria-describedby` / `aria-invalid` で入力欄に関連付け（3.3.1 / 3.3.3）

### sitemap 全URLの監査

```bash
node scripts/audit-sitemap.mjs                                  # 既定: http://localhost:3000/sitemap.xml
node scripts/audit-sitemap.mjs https://example.com/sitemap.xml  # 任意のサイト
```

ページごとに `axe`（axe-core の違反）、`sem`（見出し階層・曖昧なリンク・ラベル・ランドマーク・エラー関連付け・スキップリンク・`aria-current`）、`focusIssues`（Tab で巡回したときのフォーカス枠コントラスト）を JSON で出力します。axe-core では検出できない、操作や状態に依存する問題を補うためのものです。

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

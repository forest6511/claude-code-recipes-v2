# レシピ20: E2Eテストの自動生成と実行

`--caps testing` を有効にしたPlaywright MCP設定と、生成されるテストコードのサンプルです。

## ファイル一覧

- `.mcp.json`: testing capability 付きの設定
- `tests/login.spec.ts`: ログインフォームのE2Eテストサンプル（3シナリオ）

## 使い方

1. `.mcp.json` をプロジェクトルートにコピーします。

```bash
cp .mcp.json /path/to/your/project/.mcp.json
```

2. テスト対象のアプリケーションを起動します（例: `http://localhost:3000`）。
3. Claude Codeでテスト生成を指示します。

```text
> http://localhost:3000/login のE2Eテストを tests/login.spec.ts に書いて。
> 正常ログイン、パスワード間違い、空欄送信の3パターンをカバーして。
> ロケータは getByRole を優先して。
```

## テスト実行

```bash
npx playwright test tests/login.spec.ts
```

## testing Capability で追加されるツール

`--caps testing` を有効にすると、Playwright MCPに以下のテスト関連ツールが追加されます。

- `browser_generate_locator`: 指定した要素のPlaywright推奨ロケータを生成
- `browser_verify_element_visible`: 要素の表示を検証
- `browser_verify_list_visible`: リストの表示を検証
- `browser_verify_text_visible`: テキストの表示を検証
- `browser_verify_value`: 要素の値を検証

Claudeはこれらのツールで実ブラウザ上の情報を取得しつつ、結果を `@playwright/test` 形式の `.spec.ts` に書き起こします。

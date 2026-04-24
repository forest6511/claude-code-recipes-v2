# レシピ21: スクレイピングとUI操作を組み合わせる

認証が必要なサイトでのスクレイピングに使う `--caps storage` + `--storage-state` 設定です。

## ファイル一覧

- `.mcp.json`: `--caps storage` + `--storage-state` 付きの設定
- `.gitignore`: `playwright/.auth/` を無視する設定

## 前提

- 認証情報は環境変数または外部のシークレットストアで管理する
- `playwright/.auth/` ディレクトリは `.gitignore` に含まれている（認証クッキーが含まれるため）

## 使い方

1. `.mcp.json` をプロジェクトルートにコピーします。

```bash
cp .mcp.json /path/to/your/project/.mcp.json
```

2. 初回のみClaude Codeに対して、ログイン + セッション保存を指示します。

```text
> https://dashboard.example.com にログインして、
> ログイン後のセッションを playwright/.auth/user.json に保存して。
```

3. 2回目以降は、目的のページに直接遷移できます。

```text
> https://dashboard.example.com/orders の一覧をCSVに書き出して。
```

## 主な抽出パターン

### browser_snapshot 方式

アクセシビリティツリーをClaudeが解釈して構造化データを作ります。軽量でDOM変更に強い。

### browser_evaluate 方式

JavaScriptをブラウザ内で実行してDOMから直接値を取ります。確実だがCSSセレクタに依存。

重要データは両方を使って突き合わせると信頼性が上がります。

## 注意点

- `--caps storage` を有効にしないとCookie書き込み系ツールが使えません
- 認証セッション（`playwright/.auth/user.json`）はコミット禁止
- サイトのrobots.txtと利用規約を確認してからスクレイピングすること
- レート制限を守るため、ページ間に明示的にインターバルを挟む

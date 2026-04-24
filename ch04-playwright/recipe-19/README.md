# レシピ19: Playwright MCPのセットアップと基本操作

Playwright MCPの`.mcp.json`設定パターンを収録しています。用途に応じて選択してください。

## ファイル一覧

- `.mcp.json`: 基本設定（headedモード、npxで最新版）
- `.mcp-headless.json`: ヘッドレスモード + Chrome指定（CI/CD向き）
- `.mcp-isolated.json`: セッション分離モード（テスト向き）
- `.mcp-mobile.json`: モバイルデバイスエミュレーション

## 使い方

1. 使いたい設定ファイルをプロジェクトルートに`.mcp.json`としてコピーします。

```bash
cp .mcp.json /path/to/your/project/.mcp.json
```

2. Claude Codeを起動すると、Playwright MCPサーバーが自動接続されます。

```text
> /mcp
MCP Servers:
  playwright: connected (25 tools)
```

## CLIから追加する場合

```bash
claude mcp add --transport stdio --scope project playwright \
  -- npx -y @playwright/mcp@latest
```

`--scope project` を付けると `.mcp.json` に書き込まれ、チーム全員で共有できます。

## 主要オプション

- `--headless`: GUIウィンドウなしで実行（CI/CD向き）
- `--browser`: `chrome` / `firefox` / `webkit` / `msedge`
- `--isolated`: セッションごとに独立したプロファイルを使用
- `--device`: デバイスエミュレーション（例: `"iPhone 15"`）
- `--viewport-size`: ビューポートサイズ固定（例: `"1280x720"`）
- `--storage-state`: Cookie/ストレージの保存・復元
- `--caps`: 追加機能を有効化（`vision` / `pdf` / `devtools` / `network` / `storage` / `config`）

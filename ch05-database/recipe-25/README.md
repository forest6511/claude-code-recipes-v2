# レシピ25: Fetch MCPでREST API呼び出し

MCP公式の `mcp-server-fetch` を使って、ClaudeにURLのGET取得と HTML→Markdown変換を任せるサンプル。

## ファイル一覧

- `.mcp.json`: Fetch MCP の基本設定（`uvx` で起動）
- `.mcp-custom-ua.json`: User-Agent カスタム版（アクセス制限のあるサイト対応）

## 前提

- Astral の `uv`（`uvx` コマンドを含む。必要な Python バージョンは uv が自動管理）

uv 未インストール時:

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

pip 経由でも可:

```bash
pip install mcp-server-fetch
# 起動: python -m mcp_server_fetch
```

## セットアップ

1. `.mcp.json` をプロジェクトルートにコピー

```bash
cp .mcp.json /path/to/your/project/.mcp.json
```

2. Claude Code で `/mcp` 接続確認

```text
> /mcp
MCP Servers:
  fetch: connected
    Tools: fetch
```

## CLI から追加

```bash
claude mcp add --transport stdio fetch -- uvx mcp-server-fetch
```

## fetch ツールのパラメータ

- `url` (必須): 取得する URL
- `max_length` (任意、既定 5000): 取得する最大文字数
- `start_index` (任意、既定 0): 取得開始位置
- `raw` (任意、既定 false): true にすると Markdown 変換をスキップし HTML を返す

## できること

- 公開 URL の GET 取得と Markdown 変換
- JSON API の取得（パブリックな読み取り専用）
- 長いページのチャンク読み込み (`start_index` + `max_length`)
- `robots.txt` を尊重

## できないこと

- POST / PUT / DELETE
- 認証ヘッダー送信（Bearer / Basic / API Key）
- カスタムリクエストボディ

認証付き API が必要な場合はカスタム MCP サーバー（レシピ29）か `Bash` で `curl` / `gh` を使います。

# レシピ24: Magic MCPでUIコンポーネント自動生成

21st.devの Magic MCP サーバーを使ってUIコンポーネントを自然言語で生成するサンプル。

## ファイル一覧

- `.mcp.json`: Magic MCP の基本設定（APIキーは環境変数経由で注入）

## セットアップ

### 1. APIキー取得

<https://21st.dev/magic/console> でアカウントを作成し、APIキーを発行します。

```bash
export TWENTY_FIRST_API_KEY="your-api-key-here"
```

### 2. インストール

#### CLI で（推奨）

```bash
npx @21st-dev/cli@latest install claude --api-key ${TWENTY_FIRST_API_KEY}
```

#### 手動設定

`.mcp.json` をプロジェクトルートにコピーします。

```bash
cp .mcp.json /path/to/your/project/.mcp.json
```

## 使い方

Claude Code で `/ui` スラッシュコマンドを使います。

```text
> /ui レスポンシブなナビゲーションバーを作成して
> /ui src/components/Header.tsx のデザインを改善して
> /logo GitHub Discord Slack
```

1つ目: 新規UIコンポーネント生成
2つ目: 既存コンポーネントのリファイン
3つ目: ブランドロゴ (SVG) 取得

## 前提

Magic MCP が返すコードは以下のライブラリを前提にすることが多いため、不足していればインストールします。

```bash
npm install lucide-react class-variance-authority clsx tailwind-merge
```

Radix UI ベースのコンポーネントを使う場合は `@radix-ui/*` も適宜追加します。

## 使用量

ベータ期間中は無料だが月間生成数に制限があります。チーム利用時は共通プラン + 1Password CLI 等でAPIキー共有するのが実用的です。

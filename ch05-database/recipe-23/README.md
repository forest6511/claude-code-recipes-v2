# レシピ23: PostgreSQL MCPで自然言語からSQL生成

DBHub (`@bytebase/dbhub`) MCPサーバーを使って、Claude Codeから自然言語でPostgreSQLにクエリを投げる設定サンプル。

## ファイル一覧

- `.mcp.json`: DBHub MCP の基本設定（環境変数で DSN 注入）
- `dbhub.toml`: 複数 DB 接続を切り替える応用設定

## セットアップ

### 1. readonly ロールを用意する（推奨）

```bash
psql -U admin -d mydb <<SQL
CREATE ROLE claude_readonly WITH LOGIN PASSWORD '...';
GRANT CONNECT ON DATABASE mydb TO claude_readonly;
GRANT USAGE ON SCHEMA public TO claude_readonly;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO claude_readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
  GRANT SELECT ON TABLES TO claude_readonly;
SQL
```

### 2. 環境変数に DSN を設定

```bash
export DATABASE_URL="postgres://claude_readonly:PASSWORD@localhost:5432/mydb?sslmode=require"
```

### 3. `.mcp.json` をプロジェクトに配置

```bash
cp .mcp.json /path/to/your/project/.mcp.json
```

### 4. Claude Code で接続確認

```text
> /mcp
MCP Servers:
  db: connected
    Tools: execute_sql / search_objects
```

## 提供ツール

- `execute_sql`: クエリ実行（readonly ロール + `--max-rows` で暴走防止）
- `search_objects`: スキーマ・テーブル・列・インデックスを探索（巨大DBでも軽量）

## 対応データベース

- PostgreSQL: `postgres://user:pass@host:5432/db`
- MySQL: `mysql://user:pass@host:3306/db`
- SQLite: `sqlite:///path/to/database.db`
- SQL Server: `sqlserver://user:pass@host:1433/db`
- MariaDB: `mariadb://user:pass@host:3306/db`

## 複数DBを同時使用

`dbhub.toml` に接続を定義し、起動オプションで読み込む。

```bash
npx @bytebase/dbhub --config ./dbhub.toml
```

## 安全運用のヒント

- 本番DBには必ず readonly ロールで接続
- `--max-rows` / `--query-timeout` で暴走対策
- 本番操作前に Claude が生成した SQL を目視確認
- DSN に認証情報を含めるため、`.mcp.json` をコミットする際は `env` 経由で環境変数から注入

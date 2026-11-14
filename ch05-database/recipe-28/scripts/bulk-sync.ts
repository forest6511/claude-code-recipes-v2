import { Client } from "@modelcontextprotocol/sdk/client/index.js";
import { StdioClientTransport } from "@modelcontextprotocol/sdk/client/stdio.js";

type UserRow = { id: number; email: string | null };

/** DBHub execute_sql の戻り値（content[0].text の JSON） */
type DbhubResult = {
  success: boolean;
  error?: string;
  data?: { rows?: unknown[]; statements?: { rows: unknown[] }[] };
};

async function connect(command: string, args: string[]) {
  const client = new Client({ name: "bulk-sync", version: "1.0.0" });
  await client.connect(new StdioClientTransport({ command, args }));
  return client;
}

async function querySql<T>(db: Client, sql: string): Promise<T[]> {
  const result = await db.callTool({ name: "execute_sql", arguments: { sql } });
  const content = result.content as { type: string; text?: string }[];
  const text = content.find((c) => c.type === "text")?.text;
  if (!text) throw new Error("execute_sql の戻り値に text がありません");

  const parsed = JSON.parse(text) as DbhubResult;
  if (result.isError || !parsed.success) {
    throw new Error(`execute_sql 失敗: ${parsed.error ?? text}`);
  }
  // 単一文なら data.rows、複数文なら data.statements[].rows
  const rows = parsed.data?.rows ?? parsed.data?.statements?.at(-1)?.rows;
  if (!Array.isArray(rows)) throw new Error(`想定外の戻り値: ${text}`);
  return rows as T[];
}

async function main() {
  const dsn = process.env.DATABASE_URL;
  if (!dsn) throw new Error("環境変数 DATABASE_URL が設定されていません");

  const db = await connect("npx", ["-y", "@bytebase/dbhub", "--dsn", dsn]);
  try {
    // last_order_at が NULL（一度も注文していない）ユーザーは比較で除外される
    const rows = await querySql<UserRow>(
      db,
      "SELECT id, email FROM users WHERE last_order_at < NOW() - INTERVAL '30 days'",
    );
    console.log(`Found ${rows.length} inactive users`);

    const external = rows.filter((u) => u.email != null && !u.email.endsWith("@example.com"));
    console.log(`Filtered ${external.length} external users`);
  } finally {
    await db.close();
  }
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});

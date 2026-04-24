import { Client } from "@modelcontextprotocol/sdk/client/index.js";
import { StdioClientTransport } from "@modelcontextprotocol/sdk/client/stdio.js";

async function connect(command: string, args: string[]) {
  const client = new Client({ name: "bulk-sync", version: "1.0.0" });
  await client.connect(new StdioClientTransport({ command, args }));
  return client;
}

async function main() {
  const db = await connect("npx", ["-y", "@bytebase/dbhub", "--dsn", process.env.DATABASE_URL!]);

  const result = await db.callTool({
    name: "execute_sql",
    arguments: { sql: "SELECT id, email FROM users WHERE last_order_at < NOW() - INTERVAL '30 days'" },
  });

  const rows = JSON.parse(result.content[0].text);
  console.log(`Found ${rows.length} inactive users`);

  const inactive = rows.filter((u: any) => !u.email.endsWith("@example.com"));
  console.log(`Filtered ${inactive.length} external users`);

  await db.close();
}

main().catch(console.error);

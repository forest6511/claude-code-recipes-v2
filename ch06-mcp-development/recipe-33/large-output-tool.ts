import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { z } from "zod";

const server = new McpServer({ name: "schema-fetcher", version: "1.0.0" });

server.registerTool(
  "get_database_schema",
  {
    description:
      "Returns the full PostgreSQL schema definition. Output may exceed 25,000 tokens for large schemas.",
    inputSchema: { database: z.string() },
    annotations: {
      title: "Get DB Schema",
    },
    _meta: {
      "anthropic/maxResultSizeChars": 200000,
    },
  },
  async ({ database }) => {
    const schema = await fetchSchema(database);
    return { content: [{ type: "text", text: schema }] };
  },
);

async function fetchSchema(_db: string): Promise<string> {
  return "CREATE TABLE ...";
}

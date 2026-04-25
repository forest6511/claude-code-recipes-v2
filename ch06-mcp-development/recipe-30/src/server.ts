import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import { z } from "zod";

const server = new McpServer({
  name: "company-knowledge",
  version: "1.0.0",
});

server.registerTool(
  "search_runbook",
  {
    description:
      "Search the internal runbook by keyword. Use this when investigating incidents, onboarding new engineers, or verifying deployment procedures. Do NOT use for code search: use ripgrep instead.",
    inputSchema: {
      query: z.string().describe("Keywords or error message to search for."),
      limit: z.number().int().min(1).max(20).default(5),
    },
  },
  async ({ query, limit }) => {
    const hits = await searchDb(query, limit);
    const summary = hits.map((h) => `- ${h.title}: ${h.snippet}`).join("\n");
    return {
      content: [{ type: "text", text: summary || "No results" }],
    };
  },
);

const transport = new StdioServerTransport();
await server.connect(transport);

async function searchDb(_q: string, _n: number) {
  return [{ title: "Deploy rollback", snippet: "..." }];
}

type ResponseFormat = "concise" | "detailed";

async function searchDocuments(
  query: string,
  format: ResponseFormat = "concise",
) {
  const docs = await db.search(query);
  if (format === "concise") {
    return docs.map(d => ({ name: d.name, summary: d.summary_100char }));
  }
  return docs.map(d => ({
    name: d.name,
    owner_name: d.owner.name,
    summary: d.summary_500char,
    updated_at: d.updated_at,
    tags: d.tags,
  }));
}

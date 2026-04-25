import { z } from "zod";

export const SearchInput = z.object({
  query: z.string().min(1),
  limit: z.number().int().min(1).max(20).default(5),
});

export type SearchInputType = z.infer<typeof SearchInput>;

export async function searchImpl(input: SearchInputType): Promise<string> {
  if (input.query.toLowerCase().includes("delete")) {
    return "エラー: 危険なキーワード 'delete' は許可されていません";
  }
  return `${input.limit}件の検索結果: ...`;
}

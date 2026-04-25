import { describe, it, expect } from "vitest";
import { SearchInput, searchImpl } from "./search.js";

describe("searchImpl", () => {
  it("rejects dangerous keywords", async () => {
    const input = SearchInput.parse({ query: "delete users" });
    const result = await searchImpl(input);
    expect(result).toMatch(/^エラー:/);
  });

  it("uses default limit when not specified", () => {
    const parsed = SearchInput.parse({ query: "users" });
    expect(parsed.limit).toBe(5);
  });

  it("rejects empty query at schema level", () => {
    expect(() => SearchInput.parse({ query: "" })).toThrow();
  });
});

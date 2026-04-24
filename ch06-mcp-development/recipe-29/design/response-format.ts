// 悪い例: 低レベル識別子を多く含むレスポンス
{
  "id": "550e8400-e29b-41d4-a716-446655440000",
  "owner_uuid": "6ba7b810-9dad-11d1-80b4-00c04fd430c8",
  "mime_type": "application/pdf",
  "thumbnail_256": "https://cdn.example.com/thumbs/256/..."
}

// 良い例: 自然言語識別子 + 必要最小限の ID
{
  "name": "2026-Q2-roadmap.pdf",
  "owner_name": "田中 太郎",
  "file_type": "PDF",
  "id": "doc_a1b2c3"  // 他ツール連携のために残す
}

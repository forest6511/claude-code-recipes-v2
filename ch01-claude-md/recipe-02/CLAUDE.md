# Project

このプロジェクトは TypeScript の strict mode でビルドし、ESM 形式で配布する。

## Commands

- `npm run build`: tsc でビルド
- `npm test`: vitest でユニットテスト

## Conventions

- API ハンドラは `src/api/handlers/` に配置する
- 環境変数は `.env` に定義し、コミットしない

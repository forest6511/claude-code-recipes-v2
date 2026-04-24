# Code Style

## Why

このプロジェクトは TypeScript の strict mode でビルドし、ES modules 形式で配布する。CommonJS との混在は配布時に解決エラーを引き起こすため、import/export 構文で統一する。

## What

- Use ES modules (`import`/`export`) syntax, not CommonJS (`require`)
- Destructure imports when possible (e.g., `import { foo } from 'bar'`)
- Prefer `async`/`await` over `.then()` chains

## How

- Run `npm run typecheck` before committing
- Run `npm run lint -- --fix` to auto-fix style issues

# Security

## What

- **IMPORTANT**: 環境変数は `.env` にのみ書き、コミットしない
- **YOU MUST**: API キーをソースコードに直書きしない

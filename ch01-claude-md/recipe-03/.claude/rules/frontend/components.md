---
paths:
  - "src/components/**/*.tsx"
---

# コンポーネント規約

- ファイル名は PascalCase で、既定 export を使う
- Props は interface で定義し、`ComponentNameProps` を命名する
- Tailwind CSS のユーティリティは JSX 内に記述し、別ファイルに抽出しない

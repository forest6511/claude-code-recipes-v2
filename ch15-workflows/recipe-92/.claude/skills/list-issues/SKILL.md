---
name: list-issues
description: 自分にアサインされた Open Issue を gh CLI で取得し、ラベルから優先度判定して並べる
disable-model-invocation: true
allowed-tools: Bash(gh issue list *) Bash(gh issue view *) Read
---
# Open Issue 一覧

`gh issue list --assignee @me --state open --json number,title,labels,createdAt --limit 50` を実行し、結果から下記ルールで優先度を付ける。

優先度ルール:

- `priority: high` → P0
- `bug` → P1
- `enhancement` → P2
- `good first issue` → P3
- それ以外 → P4

出力は 2 列のテーブル (Issue 番号 / タイトル) を P0 → P4 の順に並べ、各セクションの直前に件数だけ書き添える。各 Issue のラベル一覧は箇条書きで Issue 番号の下に展開する。

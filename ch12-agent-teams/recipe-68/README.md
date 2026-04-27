# レシピ68: native isolation: worktree でブランチ分離

サブエージェント定義の `isolation: worktree` フィールドで、各エージェントに自動で隔離された git worktree を割り当てるパターンの例です。サブエージェント・Agent Teams 双方で使えます。

## ファイル一覧

- `.claude/agents/feature-implementer.md`: `isolation: worktree` を持つサブエージェント定義
- `.gitignore`: `.claude/worktrees/` を untracked から除外
- `.worktreeinclude`: worktree 作成時にコピーする gitignored ファイル
- `.claude/settings.json`: `cleanupPeriodDays` と `WorktreeCreate` Hook の設定例
- `.claude/hooks/svn-worktree.sh`: SVN を使う場合の worktree 作成 Hook 例

## 使い方

### サブエージェントから worktree を起動する

`.claude/agents/feature-implementer.md` を配置すると、`feature-implementer` を起動するたびに `<repo>/.claude/worktrees/<name>/` に隔離された worktree が自動作成されます。

```text
> Use the feature-implementer subagent to implement the auth module.
```

### CLI フラグで worktree を起動する

```bash
# 名前付きで起動
claude --worktree feature-auth

# ランダム名で起動
claude -w

# tmux split panes と組み合わせ
claude -w feature-auth --tmux
```

### 自動クリーンアップの条件

サブエージェントの `isolation: worktree` で生成された worktree は、以下の3条件をすべて満たし、かつ `cleanupPeriodDays`（デフォルト30日）を超過した場合に自動削除されます。

- 未コミット変更がない
- 追跡外（untracked）ファイルがない
- 未 push のコミットがない

`--worktree` で作成した worktree は自動削除の対象外で、終了時に保持・削除を確認されます。

## 関連レシピ

- レシピ57「カスタムエージェント + initialPrompt + /agents tabbed」
- レシピ61「大規模リファクタリング + レガシーコード分析」
- レシピ65「Agent Teams基礎」
- レシピ66「並列レイヤー開発（複数パッケージ同時）」

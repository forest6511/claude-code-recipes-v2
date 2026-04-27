# レシピ71: 動的エージェント定義とランタイム生成

`--agents` フラグに JSON を渡し、ディスクに残さないセッション限りのサブエージェントを定義します。CI/CD・ヘッドレス・一回限りの調査タスクで `.claude/agents/` を汚さずに役割を組み立てるための仕組みです。

## ファイル一覧

- `scripts/single-agent.sh` — 単一サブエージェント定義の最小例
- `scripts/parallel-review.sh` — 複数サブエージェントを 1 コマンドで定義する例
- `scripts/ci-review.sh` — `-p` ヘッドレスモード + `--output-format json` の CI 実行例
- `scripts/run-from-file.sh` — 外部 JSON ファイルから定義を読み込む例
- `scripts/merge-agents.sh` — 複数 JSON を `jq -s 'add'` で結合するヘルパー
- `agents-config.json` — `--agents` に渡すサンプル定義
- `.claude/settings.json` — `permissions.deny` で個別サブエージェントを無効化する例

## 使い方

```bash
# 単一サブエージェントを起動セッションで有効化
./scripts/single-agent.sh

# 複数サブエージェントを同時定義
./scripts/parallel-review.sh

# CI/CD でのヘッドレスレビュー
./scripts/ci-review.sh 42

# 外部 JSON から読み込む
./scripts/run-from-file.sh
```

## `--agents` で指定できる主なフィールド

サブエージェント frontmatter と同じフィールドが使えます。

- `description` — 委譲判定で使われる説明（必須）
- `prompt` — システムプロンプト（frontmatter のマークダウン本文に対応）
- `tools` / `disallowedTools` — 利用可能ツールの allow / deny
- `model` — `sonnet` / `opus` / `haiku` / フルモデル ID / `inherit`
- `permissionMode` — `default` / `acceptEdits` / `auto` / `dontAsk` / `bypassPermissions` / `plan`
- `mcpServers` / `hooks` / `maxTurns` / `skills` / `memory`
- `effort` / `background` / `isolation` / `color` / `initialPrompt`

## 設計のポイント

- `--agents` で渡したサブエージェントはマネージド設定の次に高い優先度（同名のプロジェクト/ユーザ定義より優先）
- ディスクへ書かれず、セッション終了で消滅する
- `-p` ヘッドレスモードと組み合わせると CI ジョブ単位の隔離が自然に成立する
- `--agent <name>` を併用すると、メインスレッド全体をその定義で起動できる
- Agent Teams のチームメイトとしても同名で参照可能

## 関連レシピ

- レシピ57「カスタムエージェント + initialPrompt + /agents tabbed」
- レシピ65「Agent Teams基礎」
- レシピ69「Routingパターン」
- レシピ91「CI/CDパイプライン + /autofix-pr + PR auto-fix Web」

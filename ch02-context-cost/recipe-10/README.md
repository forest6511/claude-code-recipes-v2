# レシピ10: Fast Modeで反復速度を2.5倍にする

Claude Opus 4.6 の応答速度を 2.5 倍にする Fast Mode の永続設定と、組織向けのセッションごと opt-in 強制設定のサンプル。

## ファイル一覧

- `settings.json` — ユーザー設定で Fast Mode を毎セッション有効化（`~/.claude/settings.json` にマージ）
- `managed-settings.json` — 管理ポリシー設定で「セッションごとに `/fast` 明示必須」を強制

## 使い方

```bash
# ユーザー側で永続化したい場合
cp settings.json ~/.claude/settings.json  # 既存設定とマージ

# 組織側で制御したい場合（macOS の例）
sudo cp managed-settings.json "/Library/Application Support/ClaudeCode/managed-settings.json"
```

## 注意

- Fast Mode は Claude Code v2.1.36 以降、research preview
- Opus 4.6 専用（Opus 4.7 や他モデルでは使用不可）
- Anthropic Console API と有料プラン（Pro/Max/Team/Enterprise）限定
- Bedrock / Vertex AI / Foundry では利用不可
- extra usage 課金（プランの無料枠は消費しない）

## 関連

- レシピ09 モデル選択戦略
- レシピ12 `/cost` `/usage` `/stats`

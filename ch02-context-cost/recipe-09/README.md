# レシピ09: モデル選択戦略

モデル・エフォートレベル・サブエージェント用モデル・`opusplan` を `.claude/settings.json` で固定する3 つのバリアント。

## ファイル一覧

- `.claude/settings.json` — Opus 4.7 + `xhigh` エフォート、サブエージェントは Haiku で分離
- `.claude/settings-enterprise.json` — Sonnet 固定 + ピッカーを Sonnet/Haiku に制限、`high` エフォート
- `.claude/settings-opusplan.json` — Plan Mode のみ Opus、実行は Sonnet に自動切替

## 使い方

```bash
# いずれかのファイルの内容を .claude/settings.json にマージ
# 組織配布は managed-settings でも可
```

## 関連

- レシピ07 `/context` 監視
- レシピ10 Fast Mode（Opus 4.6 限定の高速化）
- レシピ12 `/cost` `/usage` `/stats`
- レシピ74 70/20/10 Advisor コスト最適化

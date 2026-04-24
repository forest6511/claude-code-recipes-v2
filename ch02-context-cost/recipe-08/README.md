# レシピ08: /compactカスタム圧縮指示 + PostCompact Hook

`/compact` のカスタム指示と `PostCompact` Hooks による圧縮結果のログ保存サンプル。

## ファイル一覧

- `CLAUDE.md` — `Compact Instructions` セクション付きのプロジェクト指示サンプル
- `.claude/settings.json` — `PostCompact` Hooks の登録（manual + auto 両方で発火）
- `.claude/hooks/log-compact.sh` — `compact_summary` を `.claude/logs/` に Markdown 形式で保存

## 使い方

```bash
# Hooks スクリプトに実行権限を付与
chmod +x .claude/hooks/log-compact.sh

# セッション内で /compact を実行
#   → .claude/logs/compact-<ISO8601>-manual.md が生成される
# 自動圧縮（95% 到達）発生時
#   → .claude/logs/compact-<ISO8601>-auto.md が生成される

# セッション単位で焦点を指定したい場合
# > /compact Focus on the API design decisions and unresolved test failures
```

## 関連

- レシピ07 `/context` でコンテキスト使用状況を監視
- レシピ78 Hooks マッチャーパターンでフィルタリング

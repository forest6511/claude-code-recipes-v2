# レシピ07: コンテキストウィンドウの仕組みと/contextで監視する

コンテキストウィンドウの使用状況をリアルタイムで監視するステータスラインと、自動圧縮のしきい値を前倒しする設定例。

## ファイル一覧

- `statusline.sh` — コンテキスト使用率をプログレスバーで表示するスクリプト。`~/.claude/statusline.sh` に配置する想定
- `settings.json` — ステータスラインを登録する `statusLine` 設定。`~/.claude/settings.json` にマージする
- `settings-autocompact.json` — 自動圧縮のしきい値を下げる `env` 設定例（`CLAUDE_AUTOCOMPACT_PCT_OVERRIDE` / `CLAUDE_CODE_AUTO_COMPACT_WINDOW`）

## 使い方

```bash
# スクリプトを配置して実行権限を付与
cp statusline.sh ~/.claude/statusline.sh
chmod +x ~/.claude/statusline.sh

# settings.json の statusLine セクションを既存の設定にマージ
# 自動圧縮しきい値を変えたい場合は settings-autocompact.json の env を同じ settings.json に追記
```

## 関連

- レシピ08 `/compact` カスタム圧縮指示 + PostCompact Hook
- レシピ12 `/cost` `/usage` `/stats` と per-model breakdown

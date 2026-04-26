# レシピ39: 公式・Plugin Marketplace からSkillsを安全導入

公式マーケットプレイス・サードパーティマーケットプレイス・直接コピーの3経路と、導入前のセキュリティ確認スクリプト。

## ファイル一覧

| ファイル | 説明 |
|---------|------|
| `check-third-party-skill.sh` | サードパーティ Skill の `allowed-tools` / `!command` / 起動制御を一括確認するシェルスクリプト |

## 使い方

```bash
# 1. 公式マーケットプレイスからインストール
> /plugin install github@claude-plugins-official

# 2. サードパーティマーケットプレイス追加 + インストール
> /plugin marketplace add owner/repo
> /plugin install plugin-name@marketplace-name

# 3. 公式リポからの直接コピー（要セキュリティ確認）
git clone https://github.com/anthropics/skills.git /tmp/anthropic-skills
cp -r /tmp/anthropic-skills/skills/code-review .claude/skills/code-review
rm -rf /tmp/anthropic-skills

# 導入前チェック
bash check-third-party-skill.sh .claude/skills/code-review
```

## 導入経路の使い分け

| 経路 | 利点 | 向く用途 |
|------|------|--------|
| `claude-plugins-official` | namespace 管理、`/plugin update` で一括更新 | 標準的なドメイン (GitHub / コードフォーマッタなど) |
| サードパーティ marketplace | 同上、組織独自の配布も可能 | チーム内共有、コミュニティ Skills |
| 直接コピー | 個別カスタマイズ、git で履歴追跡 | プロジェクト規約に合わせた改変版 |

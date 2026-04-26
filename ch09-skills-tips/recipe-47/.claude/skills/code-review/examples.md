# Code Review 出力例

このファイルは SKILL.md から参照される例集。Claude が必要と判断したときだけ Read される。

## 例1: Critical 指摘

```text
重要度: Critical
箇所: src/auth/login.ts:42
問題: パスワードを平文でログ出力している
推奨修正: console.log の引数からパスワードを除外し、ユーザーIDのみ記録する
```

## 例2: High 指摘

```text
重要度: High
箇所: src/api/users.ts:120
問題: SQL クエリに文字列連結でユーザー入力を埋め込んでいる
推奨修正: prepared statement または ORM のパラメータバインディングに変更する
```

## 例3: Medium 指摘

```text
重要度: Medium
箇所: src/utils/format.ts:55
問題: マジックナンバー 86400 が直接埋め込まれている
推奨修正: SECONDS_PER_DAY 定数として抽出する
```

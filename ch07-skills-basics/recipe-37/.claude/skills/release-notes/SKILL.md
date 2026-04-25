---
name: release-notes
description: リリースノートを生成する
disable-model-invocation: true
arguments: [version]
argument-hint: [version]
---

# リリースノート: v$version

## 前回リリースからの変更
!`git log $(git describe --tags --abbrev=0 2>/dev/null || echo "HEAD~20")..HEAD --oneline`

## 変更ファイル統計
!`git diff $(git describe --tags --abbrev=0 2>/dev/null || echo "HEAD~20")..HEAD --stat`

## 指示
上記の差分から、v$version のリリースノートを以下の形式でまとめてください。

### 新機能
### バグ修正
### その他の変更

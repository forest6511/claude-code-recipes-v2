## 2026-04-28 MenuBarStats E2E スモーク結果

実行: Claude Code v2.1.95 + Computer Use
所要: 8 分

| 項目 | 結果 |
|------|------|
| デバッグビルド成功 | OK |
| メニューバーアイコン表示 | OK (screenshot: menu-bar-icon.png) |
| Preferences ウィンドウ開閉 | OK (screenshot: preferences-window.png) |
| interval スライダー連動 | NG (label が 1 操作分遅延) |
| アプリ終了時プロセス終了 | OK |

## 失敗詳細

interval スライダーの値変更が label に反映されるまで 1 操作分のラグがあり、
ユーザーが連続で動かすと最後の値ではなく 1 つ前の値が label に表示される。
原因仮説: PreferencesViewModel.swift の didSet で sink チェーンが組まれて
おり、ストリームの背圧で更新が 1 ステップ遅れる。修正案は別ターンで検討。

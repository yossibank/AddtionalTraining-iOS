## 書籍管理アプリ(追加研修)

## 概要
- 言語: Swift
- Xcode: 12.4
- 対応OS: iOS13以上
- 管理ライブラリ: CocoaPods

## 使用技術

### アーキテクチャ
  - MVVM + Repository + Router
  - DI(テスト設計)
  - Combine使用

### テスト
  - XCText(View以外のStaticな処理)
  - 正常系と異常系の1ケースを最低限用意する
 
### Firebase
  - Analytics
  - Crashlytics
  - CloudMessaging
  
### ImagePicker
  - 端末内画像とカメラで撮影した画像の両方を使用出来るようにする
  1. [画像を選択] →ImagePickerからPhotoLibraryを開き、画像を取得
  2. [写真を撮る] →ImagePickerからcameraを起動し、画像を撮影して取得
  
### FileManager
  - DBへの保存に利用
  - お気に入り登録した書籍をJson形式にデータをencodeし、Fileに保存する
  
### Lint
  - SwiftLintを使用
  
## 使用ライブラリ
  - R.swift
  - KeychainAccess
  - Nuke

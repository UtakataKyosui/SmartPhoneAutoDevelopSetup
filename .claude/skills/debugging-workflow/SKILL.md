---
name: debugging-workflow
description: Guide for efficient debugging process. Use when investigating bugs, analyzing errors, or troubleshooting issues. Covers systematic problem-solving approaches and debugging techniques.
---

# Debugging Workflow

このスキルは、効率的なデバッグプロセスをガイドします。

## デバッグの基本ステップ

```
デバッグフロー:
- [ ] 1. 問題の再現
- [ ] 2. 情報の収集
- [ ] 3. 仮説の立案
- [ ] 4. 仮説の検証
- [ ] 5. 修正の実装
- [ ] 6. テストの作成
- [ ] 7. ドキュメント化
```

## 1. 問題の再現

### 再現手順の確立

**最小限の再現手順を特定**:
- [ ] 問題を引き起こす最小限の操作を特定
- [ ] 不要なステップを削除
- [ ] 再現率を確認（100%再現が理想）

**環境条件の記録**:
- [ ] OS・ブラウザ・デバイス
- [ ] ソフトウェアバージョン
- [ ] 環境変数
- [ ] ネットワーク状態

**入力データの保存**:
- [ ] テストデータを保存
- [ ] エッジケースを特定
- [ ] 境界値を確認

**期待される動作の明確化**:
- [ ] 正しい動作を定義
- [ ] 現在の動作との差分を明確化

## 2. 情報の収集

### ログ分析

**エラーメッセージの収集**:
```bash
# アプリケーションログ
tail -f /var/log/app.log

# システムログ
journalctl -u service-name -f

# ブラウザコンソール
F12 → Console タブ
```

**スタックトレースの分析**:
- [ ] エラーが発生した場所を特定
- [ ] 呼び出し元を追跡
- [ ] 関連するコードを確認

**ログレベルの調整**:
```typescript
// ログレベルを DEBUG に変更
logger.setLevel('DEBUG');

// 詳細なログを出力
logger.debug('Variable value:', variable);
```

### デバッグツールの使用

**ブレークポイント**:
- [ ] 問題が発生する前にブレークポイントを設定
- [ ] 変数の値を確認
- [ ] ステップ実行で処理を追跡

**ウォッチ式**:
- [ ] 重要な変数をウォッチ
- [ ] 条件付きブレークポイントを使用

## 3. 仮説の立案

### 原因の推定

**一般的な原因**:
- [ ] ロジックエラー
- [ ] 型の不一致
- [ ] null/undefined参照
- [ ] 非同期処理のタイミング
- [ ] リソースリーク
- [ ] 競合状態（Race Condition）

**仮説の優先順位付け**:
1. **最も可能性が高い原因**から検証
2. **影響範囲が大きい原因**を優先
3. **検証が容易な仮説**から試す

## 4. 仮説の検証

### 二分探索法

問題が発生する範囲を半分ずつ絞り込む:

```
1. コードの中間地点にログを追加
2. 問題が前半か後半かを特定
3. 該当する範囲を再度二分
4. 問題箇所を特定するまで繰り返す
```

### 分離テスト

**最小限のテストケース作成**:
```typescript
// 問題を再現する最小限のコード
test('reproduce bug', () => {
  const result = problematicFunction(input);
  expect(result).toBe(expected);
});
```

### デバッガーの活用

**TypeScript/JavaScript**:
```typescript
// Node.js デバッガー
node --inspect-brk app.js

// Chrome DevTools
debugger; // この行で停止
```

**Rust**:
```bash
# lldb を使用
rust-lldb target/debug/app

# gdb を使用
rust-gdb target/debug/app
```

## 5. 修正の実装

### 修正の原則

**最小限の変更**:
- [ ] 問題を解決する最小限の変更
- [ ] 副作用を最小化
- [ ] 既存の動作を壊さない

**防御的プログラミング**:
```typescript
// 入力検証を追加
function processData(data: Data | null) {
  if (!data) {
    logger.warn('Data is null');
    return defaultValue;
  }
  
  // 処理
}
```

**エラーハンドリングの改善**:
```typescript
try {
  await riskyOperation();
} catch (error) {
  logger.error('Operation failed:', error);
  // 適切なフォールバック処理
  return fallbackValue;
}
```

## 6. テストの作成

### 回帰テストの作成

**バグを再現するテスト**:
```typescript
test('should handle null input', () => {
  // このテストは修正前は失敗する
  const result = processData(null);
  expect(result).toBe(defaultValue);
});
```

**エッジケースのテスト**:
- [ ] 境界値のテスト
- [ ] 異常系のテスト
- [ ] 並行処理のテスト

## 7. ドキュメント化

### バグレポートの更新

**修正内容の記録**:
```markdown
## 原因
非同期処理の完了を待たずに次の処理に進んでいた

## 修正内容
await を追加して非同期処理の完了を待つように変更

## テスト
- 単体テストを追加
- 手動テストで動作確認
```

### コードコメントの追加

```typescript
// Bug fix: #123 - null チェックを追加
// 以前は null の場合にエラーが発生していた
if (data === null) {
  return defaultValue;
}
```

## デバッグテクニック

### ラバーダック デバッグ

問題を誰か（またはラバーダック）に説明することで解決策が見つかることがある:

1. 問題を声に出して説明
2. コードの動作を1行ずつ説明
3. 説明中に矛盾や誤りに気づく

### バイナリサーチ

Gitの履歴から問題が発生したコミットを特定:

```bash
# バイナリサーチ開始
git bisect start

# 現在のコミットは問題あり
git bisect bad

# 過去の正常なコミット
git bisect good <commit-hash>

# 自動的に中間のコミットに移動
# テストして good/bad を報告
git bisect good  # または git bisect bad

# 問題のコミットを特定
git bisect reset
```

### プリントデバッグ

シンプルだが効果的:

```typescript
console.log('DEBUG: variable =', variable);
console.log('DEBUG: entering function');
console.log('DEBUG: condition =', condition);
```

**注意**: 本番環境にデバッグログを残さない

## 言語別のデバッグツール

### TypeScript/JavaScript

**ブラウザ DevTools**:
- Chrome DevTools
- Firefox Developer Tools
- Safari Web Inspector

**Node.js デバッガー**:
```bash
# 組み込みデバッガー
node inspect app.js

# Chrome DevTools
node --inspect app.js
```

**VS Code デバッガー**:
`.vscode/launch.json` を設定

### Rust

**デバッガー**:
- lldb (macOS/Linux)
- gdb (Linux)
- Visual Studio Debugger (Windows)

**デバッグビルド**:
```bash
# デバッグ情報付きでビルド
cargo build

# リリースビルドでもデバッグ情報を含める
cargo build --release --config profile.release.debug=true
```

## トラブルシューティング

### 再現できない問題

**対処法**:
1. より多くの情報を収集（ログ、環境情報）
2. 統計的アプローチ（複数回試行）
3. 本番環境のログを詳細化

### 複雑すぎる問題

**対処法**:
1. 問題を小さな部分に分割
2. 各部分を個別にテスト
3. チームメンバーに相談

### パフォーマンス問題

**対処法**:
1. プロファイラーを使用
2. ボトルネックを特定
3. ベンチマークで効果を測定

## 関連Skill

- **testing-typescript**: [testing-typescript](../testing-typescript/SKILL.md) - デバッグテストの作成
- **testing-rust**: [testing-rust](../testing-rust/SKILL.md) - Rustデバッグテスト
- **code-review-workflow**: [code-review-workflow](../code-review-workflow/SKILL.md) - バグの早期発見

## 参考リソース

- [Chrome DevTools](https://developer.chrome.com/docs/devtools/)
- [Node.js Debugging Guide](https://nodejs.org/en/docs/guides/debugging-getting-started/)
- [Rust Debugging](https://doc.rust-lang.org/book/ch09-00-error-handling.html)

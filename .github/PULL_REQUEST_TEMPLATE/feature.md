# 🚀 機能実装 Pull Request

## 📋 機能概要 / Feature Overview

<!-- この機能の目的と価値を簡潔に説明してください -->

### 🎯 実装された機能 / Implemented Features

<!-- 実装された具体的な機能を列挙してください -->

-
-
-

### 🔗 関連Issue / Related Issues

- Closes #(issue番号)
- Implements #(issue番号)


### 📋 完了した開発フェーズ / Completed Phases



### 🧪 TDD実装サイクル / TDD Implementation Cycle

<!-- TDDサイクルの実施状況を記載してください -->

- [ ] **Red**: テストファーストで失敗するテストを作成
- [ ] **Green**: テストを通すための最小限の実装
- [ ] **Refactor**: コード品質向上のリファクタリング

**TDDサイクル実行回数**: X回

## 📝 実装詳細 / Implementation Details

### 🔄 主要な変更 / Main Changes

<!-- 実装された主要な変更を詳しく説明してください -->

1. **機能A**: 詳細説明
2. **機能B**: 詳細説明
3. **機能C**: 詳細説明

### 🗂️ 新規追加ファイル / New Files

<!-- 新規追加されたファイルとその目的 -->

- `src/features/feature-name/` - 機能のメインディレクトリ
- `src/features/feature-name/components/` - UI コンポーネント
- `src/features/feature-name/hooks/` - カスタムフック
- `src/features/feature-name/types.ts` - 型定義
- `tests/features/feature-name/` - テストファイル

### 🔧 修正ファイル / Modified Files

<!-- 修正されたファイルとその変更理由 -->

- `src/app/routes.tsx` - 新機能のルーティング追加
- `src/lib/api/index.ts` - API エンドポイント追加
- `package.json` - 新規依存関係追加

## 🧪 テスト実装 / Test Implementation

### 📊 テストカバレッジ / Test Coverage

- **ユニットテスト**: XX% (目標: 80%以上)
- **統合テスト**: XX% (目標: 70%以上)
- **E2Eテスト**: XX% (目標: 主要フロー100%)

### 🔍 テストケース / Test Cases

#### ユニットテスト
- [ ] コンポーネントの正常レンダリング
- [ ] フォームバリデーション
- [ ] ビジネスロジック
- [ ] エラーハンドリング
- [ ] エッジケース

#### 統合テスト
- [ ] API連携
- [ ] データフロー
- [ ] 状態管理
- [ ] 外部サービス連携

#### E2Eテスト
- [ ] ユーザージャーニー
- [ ] 主要ワークフロー
- [ ] クロスブラウザ対応

## ⚡ パフォーマンス / Performance

### 📊 パフォーマンス指標 / Performance Metrics

<!-- パフォーマンステストの結果を記載してください -->

- **初期読み込み時間**: XXXms (目標: <3000ms)
- **フリップサイズ**: XXkB (目標: <500kB)
- **メモリ使用量**: XXMb (目標: <100MB)
- **Core Web Vitals**:
  - LCP: XXXms (目標: <2500ms)
  - FID: XXms (目標: <100ms)
  - CLS: X.XX (目標: <0.1)

### 🚀 パフォーマンス最適化 / Performance Optimizations

- [ ] コンポーネントの遅延読み込み
- [ ] 画像の最適化
- [ ] バンドルサイズの最適化
- [ ] キャッシュ戦略の実装
- [ ] メモ化の適用

## 📱 モバイル対応 / Mobile Responsiveness

### 📊 モバイルテスト / Mobile Testing

<!-- モバイル対応の確認状況 -->

- [ ] **iPhone** (iOS Safari)
- [ ] **Android** (Chrome)
- [ ] **タブレット** (iPad, Android Tablet)
- [ ] **レスポンシブデザイン** (320px〜1920px)

### 🎨 UI/UX改善 / UI/UX Improvements

- [ ] タッチフレンドリーなインターフェース
- [ ] 適切なタップターゲットサイズ (44px以上)
- [ ] スワイプジェスチャーサポート
- [ ] オフライン対応

## 🔒 セキュリティ / Security

### 🛡️ セキュリティチェック / Security Checks

- [ ] 入力値の検証とサニタイゼーション
- [ ] XSS対策
- [ ] CSRF対策
- [ ] SQLインジェクション対策
- [ ] 認証・認可の適切な実装
- [ ] 機密情報の適切な取り扱い

### 🔐 セキュリティテスト / Security Testing

- [ ] 脆弱性スキャン実行
- [ ] セキュリティエージェントによるレビュー
- [ ] セキュリティベストプラクティス適用

## ♿ アクセシビリティ / Accessibility

### 📋 アクセシビリティチェック / Accessibility Checks

- [ ] **WCAG 2.1 AA準拠** (目標: 100%)
- [ ] キーボードナビゲーション対応
- [ ] スクリーンリーダー対応
- [ ] 適切なARIAラベル
- [ ] コントラスト比の確認 (4.5:1以上)
- [ ] フォーカス管理

### 🧪 アクセシビリティテスト / Accessibility Testing

- [ ] axe-core による自動テスト
- [ ] 手動アクセシビリティテスト
- [ ] スクリーンリーダーでの動作確認

## 🤖 Claude Code Actions

### 🚀 使用されたワークフロー / Used Workflows

<!-- 使用されたClaude Code Actionsワークフローを記載 -->

- [ ] `@claude plan` - 仕様策定・計画ワークフロー
- [ ] `@claude` - 基本実装ワークフロー
- [ ] `@claude review` - コードレビューワークフロー

### 🎯 実行されたコマンド / Executed Commands

```bash

# 開発支援コマンド
/development:code-review
/testing:test-gen --unit --integration
```

### 🤖 活用した専門エージェント / Specialist Agents Used

- [ ] 🌐 web-developer - フロントエンド開発
- [ ] 🦀 rust-expert - Rust実装
- [ ] 📱 mobile-developer - モバイル対応
- [ ] 🔒 security-expert - セキュリティレビュー

## 📸 UI変更のスクリーンショット / UI Screenshots

### Before / After

| Before | After |
|--------|-------|
| ![before](URL) | ![after](URL) |

### 📱 レスポンシブ対応 / Responsive Design

| Desktop | Tablet | Mobile |
|---------|--------|--------|
| ![desktop](URL) | ![tablet](URL) | ![mobile](URL) |

## 🚀 デプロイ・リリース / Deployment & Release

### 📋 デプロイ前チェックリスト / Pre-deployment Checklist

- [ ] 全テストが通過
- [ ] セキュリティチェック完了
- [ ] パフォーマンス要件を満たしている
- [ ] アクセシビリティ要件を満たしている
- [ ] ドキュメント更新完了

### 🌍 リリース影響範囲 / Release Impact

- [ ] **フロントエンド**: 新機能追加
- [ ] **バックエンド**: API拡張
- [ ] **データベース**: マイグレーション不要
- [ ] **インフラ**: 変更なし
- [ ] **外部サービス**: 新規連携あり

### 🔄 ロールバック計画 / Rollback Plan

1. フィーチャーフラグによる即座の無効化
2. 前バージョンへのデプロイ巻き戻し
3. データベースロールバック（該当する場合）

## 📋 レビューポイント / Review Points

### 🔍 特に確認してほしい点 / Focus Areas for Review

- **機能仕様**: 要件通りに実装されているか
- **コード品質**: SOLID原則、DRY原則に従っているか
- **テスト品質**: エッジケースまで網羅されているか
- **パフォーマンス**: 目標値を達成しているか
- **セキュリティ**: 脆弱性がないか
- **UX**: ユーザビリティが向上しているか

### ✅ コードレビューチェックリスト / Code Review Checklist

#### 🏗️ アーキテクチャ
- [ ] 単一責任原則に従っている
- [ ] 適切な層分離ができている
- [ ] 依存性注入が適切に使用されている

#### 💻 コード品質
- [ ] 命名規則が統一されている
- [ ] コメントが適切に記載されている
- [ ] マジックナンバーが排除されている
- [ ] エラーハンドリングが適切

#### 🧪 テスト
- [ ] テストケースが十分
- [ ] モックが適切に使用されている
- [ ] テストの実行時間が適切

## 📝 今後の課題 / Future Improvements

### 🔮 次期リリースでの改善点 / Next Release Improvements

-
-
-

### 📚 学んだ教訓 / Lessons Learned

-
-
-

---

## 📋 マージ前最終確認 / Final Pre-merge Checklist

- [ ] 全CIチェックが通過
- [ ] コードレビュー完了
- [ ] QAテスト完了
- [ ] セキュリティレビュー完了
- [ ] ドキュメント更新完了
- [ ] ステークホルダー承認完了


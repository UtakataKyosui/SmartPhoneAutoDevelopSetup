# 専門サブエージェント詳細ガイド

このファイルは、Claude Codeで利用可能な専門サブエージェントの詳細な機能と使用方法を説明します。

## 利用可能なサブエージェント

### `rust-expert` - Rust開発専門家
```
@claude rust-expert: 所有権エラーを修正してください
@claude rust-expert: パフォーマンスを最適化してください
```
**専門分野:**
- 所有権システムとライフタイム管理
- 非同期プログラミング（async/await、tokio）
- WebAssembly開発
- システムプログラミング

**得意なタスク:**
- Clippy warnings の修正
- メモリ効率の最適化
- Unsafe Rust コードレビュー
- Cargo エコシステムの活用

### `web-developer` - Web開発専門家
```
@claude web-developer: レスポンシブデザインを実装してください
@claude web-developer: PWAに対応させてください
```
**専門分野:**
- フロントエンド開発（React、Vue、Angular）
- バックエンド開発（Node.js、Express、Fastify）
- フルスタック開発
- PWA・SPA開発

**得意なタスク:**
- レスポンシブデザイン実装
- API設計・実装
- パフォーマンス最適化
- SEO対応

### `mobile-developer` - モバイルアプリ開発専門家
```
@claude mobile-developer: iOS対応を追加してください
@claude mobile-developer: プッシュ通知を実装してください
```
**専門分野:**
- iOS開発（Swift、SwiftUI）
- Android開発（Kotlin、Jetpack Compose）
- クロスプラットフォーム開発（React Native、Flutter）
- ハイブリッドアプリ開発

**得意なタスク:**
- ネイティブ機能の統合
- プッシュ通知実装
- アプリストア申請対応
- デバイス最適化

### `devops-engineer` - DevOpsインフラ専門家
```
@claude devops-engineer: CI/CDパイプラインを構築してください
@claude devops-engineer: Dockerコンテナ化してください
```
**専門分野:**
- CI/CD パイプライン構築
- コンテナ化・オーケストレーション
- クラウドインフラ（AWS、Azure、GCP）
- 監視・ログ管理

**得意なタスク:**
- GitHub Actions / GitLab CI設定
- Docker・Kubernetes設定
- インフラ as Code（Terraform、CloudFormation）
- 監視・アラート設定

### `data-scientist` - データサイエンス専門家
```
@claude data-scientist: データ分析を実装してください
@claude data-scientist: 機械学習モデルを作成してください
```
**専門分野:**
- データ分析・可視化
- 機械学習・深層学習
- 統計解析
- ビッグデータ処理

**得意なタスク:**
- データ前処理・クリーニング
- 予測モデル作成
- データ可視化
- A/Bテスト設計

### `security-expert` - セキュリティ専門家
```
@claude security-expert: 脆弱性を検査してください
@claude security-expert: 認証システムを強化してください
```
**専門分野:**
- アプリケーションセキュリティ
- インフラセキュリティ
- 脆弱性診断・ペネトレーションテスト
- セキュアコーディング

**得意なタスク:**
- OWASP Top 10対応
- 認証・認可システム設計
- 暗号化実装
- セキュリティ監査

## 使用時のベストプラクティス

1. **具体的な指示を出す** - 「〇〇を実装してください」「〇〇を修正してください」
2. **専門分野に適したエージェントを選択**
3. **既存コードとの整合性を重視**
4. **セキュリティとパフォーマンスを考慮**
5. **テストコードも合わせて依頼**
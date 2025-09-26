# 専門サブエージェント詳細ガイド

このファイルは、Claude Codeで利用可能な専門サブエージェントの詳細な機能と使用方法を説明します。

## 利用可能なサブエージェント

### `rust-expert` - Rust開発専門家

**専門分野**:
- Rustの所有権システムとライフタイム管理
- パフォーマンス最適化とメモリ効率
- 非同期プログラミング（async/await、tokio）
- システムプログラミング・WebAssembly開発
- Cargoエコシステム

**実行可能タスク**:
- Rustプロジェクトの設計・実装
- 所有権エラーの解決
- パフォーマンス分析とボトルネック解決
- クレート選定と統合
- テストコード作成（unit、integration、doc tests）
- Clippyワーニング修正
- Unsafe Rustコードレビュー

**使用例**:
```bash
@claude rust-expert: 所有権エラーを修正してください
@claude rust-expert: tokioを使った非同期処理を実装
@claude rust-expert: パフォーマンス最適化を行ってください
```

**開発ツール**:
- cargo（build、test、clippy、fmt）
- rustdoc、cargo-audit、cargo-tarpaulin
- flamegraph（プロファイリング）

---

### `web-developer` - Web開発専門家

**専門分野**:
- フロントエンド開発（React、Vue、Angular等）
- バックエンドAPI設計・実装
- レスポンシブデザイン・UI/UX
- Web パフォーマンス最適化
- SEO・アクセシビリティ

**実行可能タスク**:
- SPAアプリケーション開発
- REST/GraphQL API設計
- レスポンシブWebデザイン
- PWA（Progressive Web App）開発
- Webパフォーマンス分析・改善
- Cross-browserテスト

**使用例**:
```bash
@claude web-developer: レスポンシブデザインを実装してください
@claude web-developer: REST APIを設計・実装
@claude web-developer: PWA化してください
```

**技術スタック**:
- Frontend: React/Vue/Angular、TypeScript
- Backend: Node.js、Express、FastAPI
- Database: PostgreSQL、MongoDB
- Tools: Webpack、Vite、ESLint

---

### `mobile-developer` - モバイルアプリ開発専門家

**専門分野**:
- iOS開発（Swift、UIKit、SwiftUI）
- Android開発（Kotlin、Jetpack Compose）
- クロスプラットフォーム（React Native、Flutter）
- モバイル設計パターン・アーキテクチャ
- アプリストア最適化

**実行可能タスク**:
- ネイティブモバイルアプリ開発
- クロスプラットフォームアプリ開発
- モバイル特化UI/UX実装
- プッシュ通知・バックグラウンド処理
- アプリ最適化・パフォーマンス改善
- アプリストア申請準備

**使用例**:
```bash
@claude mobile-developer: iOS アプリのUIを実装してください
@claude mobile-developer: プッシュ通知機能を追加
@claude mobile-developer: Flutter でクロスプラットフォームアプリを作成
```

---

### `devops-engineer` - DevOpsとインフラ専門家

**専門分野**:
- CI/CDパイプライン設計・構築
- コンテナ化（Docker、Kubernetes）
- クラウドインフラ（AWS、GCP、Azure）
- Infrastructure as Code（Terraform、CloudFormation）
- 監視・ログ管理システム

**実行可能タスク**:
- GitHub Actions/GitLab CI設定
- Docker化・Kubernetes設定
- クラウドインフラ設計・構築
- 監視・アラート設定
- セキュリティ設定・脆弱性対応
- デプロイメント自動化

**使用例**:
```bash
@claude devops-engineer: CI/CDパイプラインを設定してください
@claude devops-engineer: Kubernetesにデプロイできるよう設定
@claude devops-engineer: 監視システムを構築
```

**インフラツール**:
- Container: Docker、Kubernetes
- Cloud: AWS、GCP、Azure
- IaC: Terraform、Ansible
- Monitoring: Prometheus、Grafana

---

### `data-scientist` - データサイエンスと機械学習専門家

**専門分野**:
- 機械学習モデル設計・実装
- データ分析・可視化
- 統計解析・予測モデリング
- MLOps・モデルデプロイメント
- ビッグデータ処理

**実行可能タスク**:
- 機械学習パイプライン構築
- データクリーニング・前処理
- 特徴量エンジニアリング
- モデル評価・検証
- データ可視化・レポート作成
- A/Bテスト設計・分析

**使用例**:
```bash
@claude data-scientist: 予測モデルを構築してください
@claude data-scientist: データ分析とレポート作成
@claude data-scientist: MLOpsパイプラインを設定
```

**技術スタック**:
- Python: pandas、scikit-learn、PyTorch、TensorFlow
- R: tidyverse、ggplot2、caret
- Big Data: Spark、Hadoop
- Visualization: matplotlib、seaborn、plotly

---

### `security-expert` - セキュリティと脆弱性専門家

**専門分野**:
- セキュリティ監査・脆弱性評価
- ペネトレーションテスト
- セキュアコーディング
- 暗号化・認証システム
- コンプライアンス対応

**実行可能タスク**:
- セキュリティ監査・脆弱性スキャン
- セキュアなアーキテクチャ設計
- 認証・認可システム実装
- 暗号化機能実装
- セキュリティテスト実行
- コンプライアンス準拠確認

**使用例**:
```bash
@claude security-expert: 脆弱性を検査してください
@claude security-expert: 認証システムをセキュアに実装
@claude security-expert: OWASP準拠のセキュリティテスト実行
```

**セキュリティツール**:
- SAST: SonarQube、CodeQL
- DAST: OWASP ZAP、Burp Suite
- 依存関係: Snyk、npm audit
- Container: Trivy、Clair

## 使用時のベストプラクティス

1. **具体的な指示を出す** - 「〇〇を実装してください」「〇〇を修正してください」
2. **専門分野に適したエージェントを選択**
3. **既存コードとの整合性を重視**
4. **セキュリティとパフォーマンスを考慮**
5. **テストコードも合わせて依頼**

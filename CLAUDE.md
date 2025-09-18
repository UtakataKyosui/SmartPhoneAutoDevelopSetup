# CLAUDE.md

## プロジェクト概要
- このリポジトリは、スマホで開発できるテンプレートを提供する。
- READMEやIssueから、どのような機能・アプリを作るかClaude Codeが判断する。

## 開発ルール
- **共通ルール**: 変数命名、コードスタイル、コメントの書き方はプロジェクト内で統一する。
- **テスト駆動開発（TDD）** を基本とする。
- **Issue Driven 開発**: すべての開発はIssueから開始し、Issueに紐づけて進める。
- **MCPツールの使用必須**: 開発作業は基本的にMCPのツールを使用する。
- **Formatter/Linter実行**: コード整形や静的解析はClaude CodeのHooksから自動実行すること。
- **CLAUDE.mdの改善**: 開発を始める際には、READMEやIssueを参照して、そのプロジェクト用にCLAUDE.mdを必要に応じて改善する。

## 構成
- `.github/workflows/claude.yml` : Claude Codeを動作させるワークフロー
- `README.md` : プロジェクト概要と開発ガイド
- `CLAUDE.md` : Claude Codeへの指示

## 設定・制約
- 依存ライブラリの追加は最小限にとどめる。
- トリガー条件やワークフローの変更も最小限にする。

## テスト・検証
- `@claude` コメント付きIssue/PRで動作確認する。
- 実行結果はGitHub Actionsのログで確認する。
- TDDに従い、まずテストを書いてから機能を実装する。
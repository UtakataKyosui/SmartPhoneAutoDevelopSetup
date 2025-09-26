# /setup-project

新規プロジェクトの初期セットアップを行います。

## 実行内容
1. プロジェクト構造の分析
2. 必要な設定ファイルの確認・作成
3. 依存関係の解決
4. 開発環境の初期化
5. 基本的なCI/CD設定の確認

## 使用例
- `/setup-project` - 現在のディレクトリでプロジェクトセットアップを実行
- 言語やフレームワークを自動検出してセットアップを行う

## 対象言語・フレームワーク
- Rust (Cargo.toml)
- Node.js (package.json)
- Python (pyproject.toml, requirements.txt)
- Go (go.mod)
- Java/Kotlin (build.gradle, pom.xml)
- その他の一般的なプロジェクト構成
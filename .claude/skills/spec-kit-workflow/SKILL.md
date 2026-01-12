---
name: spec-kit-workflow
description: Guide for specification-driven development workflow using Spec Kit. Use when creating specifications, planning implementations, generating tasks, or managing project constitution. Integrates with .specify/ directory for template-based development.
---

# Spec Kit Workflow

このスキルは、Spec Kit を使用した仕様駆動開発のワークフローをガイドします。

## 概要

Spec Kitは、自然言語から正式仕様を作成し、実装計画、タスク生成、TDD実装までを体系的に進めるフレームワークです。

## ワークフロー

```
仕様駆動開発フロー:
- [ ] 1. Specify - 仕様作成
- [ ] 2. Clarify - 仕様明確化
- [ ] 3. Plan - 実装計画
- [ ] 4. Tasks - タスク生成
- [ ] 5. Implement - TDD実装
- [ ] 6. Analyze - 品質分析
- [ ] 7. Constitution - プロジェクト憲法管理
```

## 1. Specify - 仕様作成

### 目的
自然言語の機能説明から正式な仕様ドキュメントを作成します。

### 実行手順

1. **ブランチとファイルの初期化**
   ```bash
   .specify/scripts/bash/create-new-feature.sh --json "機能説明"
   ```
   
   出力されるJSON:
   - `BRANCH_NAME`: 新しいfeatureブランチ名
   - `SPEC_FILE`: 仕様ファイルのパス

2. **テンプレートの読み込み**
   ```bash
   # 仕様テンプレートを確認
   cat .specify/templates/spec-template.md
   ```

3. **仕様の作成**
   - テンプレート構造に従って仕様を記述
   - 必須セクション:
     - Overview/Context
     - Functional Requirements
     - Non-Functional Requirements
     - User Stories
     - Acceptance Criteria

4. **完了報告**
   - ブランチ名
   - 仕様ファイルパス
   - 次のフェーズへの準備完了

## 2. Clarify - 仕様明確化

### 目的
仕様の曖昧な部分を対話的に明確化し、実装前のリスクを削減します。

### 実行手順

1. **前提条件の確認**
   ```bash
   .specify/scripts/bash/check-prerequisites.sh --json --paths-only
   ```

2. **曖昧性スキャン**
   以下のカテゴリで仕様を分析:
   - 機能スコープと動作
   - ドメインとデータモデル
   - インタラクションとUXフロー
   - 非機能要件
   - 統合と外部依存
   - エッジケースと障害処理
   - 制約とトレードオフ
   - 用語の一貫性

3. **質問の生成と対話**
   - 最大5つの優先度の高い質問を生成
   - 1つずつ順番に質問
   - 回答を即座に仕様に統合

4. **仕様の更新**
   - `## Clarifications`セクションを追加
   - `### Session YYYY-MM-DD`で日付ごとに記録
   - 各回答を適切なセクションに反映

### 質問形式

**多肢選択式**:
| Option | Description |
|--------|-------------|
| A | オプションAの説明 |
| B | オプションBの説明 |

**短答式**:
Format: Short answer (≤5 words)

## 3. Plan - 実装計画

### 目的
仕様から具体的な実装計画を生成します。

### 実行手順

1. **セットアップ**
   ```bash
   .specify/scripts/bash/setup-plan.sh --json
   ```

2. **仕様の分析**
   - 機能要件とユーザーストーリー
   - 機能的・非機能的要件
   - 成功基準と受入基準
   - 技術的制約と依存関係

3. **憲法の確認**
   ```bash
   cat .specify/memory/constitution.md
   ```

4. **計画テンプレートの実行**
   ```bash
   cat .specify/templates/plan-template.md
   ```
   
   生成される成果物:
   - **Phase 0**: `research.md` - 技術調査
   - **Phase 1**: `data-model.md`, `contracts/`, `quickstart.md`
   - **Phase 2**: `tasks.md` - タスクリスト

5. **進捗追跡**
   - 各フェーズの完了を確認
   - すべての成果物が生成されたことを検証

## 4. Tasks - タスク生成

### 目的
設計成果物からTDD準拠のタスクリストを生成します。

### 実行手順

1. **前提条件の確認**
   ```bash
   .specify/scripts/bash/check-prerequisites.sh --json
   ```

2. **設計ドキュメントの読み込み**
   - `plan.md`: 技術スタックとライブラリ
   - `data-model.md`: エンティティ（存在する場合）
   - `contracts/`: APIエンドポイント（存在する場合）
   - `research.md`: 技術的決定（存在する場合）
   - `quickstart.md`: テストシナリオ（存在する場合）

3. **タスクの生成**
   テンプレート: `.specify/templates/tasks-template.md`
   
   タスクカテゴリ:
   - **Setup**: プロジェクト初期化、依存関係、リント
   - **Test [P]**: コントラクトごと、統合シナリオごと
   - **Core**: エンティティ、サービス、CLIコマンド、エンドポイント
   - **Integration**: DB接続、ミドルウェア、ログ
   - **Polish [P]**: ユニットテスト、パフォーマンス、ドキュメント

4. **タスク生成ルール**
   - 各コントラクトファイル → コントラクトテストタスク `[P]`
   - 各エンティティ → モデル作成タスク `[P]`
   - 各エンドポイント → 実装タスク（共有ファイルの場合は非並列）
   - 各ユーザーストーリー → 統合テスト `[P]`
   - 異なるファイル = 並列可能 `[P]`
   - 同じファイル = 順次（`[P]`なし）

5. **依存関係の順序**
   1. Setup → すべての前に
   2. Tests → 実装の前（TDD）
   3. Models → サービスの前
   4. Services → エンドポイントの前
   5. Core → 統合の前
   6. すべて → Polishの前

## 5. Implement - TDD実装

### 目的
タスクリストに従ってTDDサイクルで実装を進めます。

### 実行手順

1. **前提条件の確認**
   ```bash
   .specify/scripts/bash/check-prerequisites.sh --json --require-tasks --include-tasks
   ```

2. **実装コンテキストの読み込み**
   - **必須**: `tasks.md` - 完全なタスクリストと実行計画
   - **必須**: `plan.md` - 技術スタック、アーキテクチャ、ファイル構造
   - **存在する場合**: `data-model.md`, `contracts/`, `research.md`, `quickstart.md`

3. **タスク構造の解析**
   - タスクフェーズ: Setup, Tests, Core, Integration, Polish
   - タスク依存関係: 順次 vs 並列実行ルール
   - タスク詳細: ID、説明、ファイルパス、並列マーカー `[P]`

4. **実装の実行**
   - **フェーズごとの実行**: 各フェーズを完了してから次へ
   - **依存関係の尊重**: 順次タスクは順番に、並列タスク `[P]`は同時実行可能
   - **TDDアプローチ**: テストタスクを対応する実装タスクの前に実行
   - **ファイルベースの調整**: 同じファイルに影響するタスクは順次実行
   - **検証チェックポイント**: 各フェーズ完了を確認してから進行

5. **実装実行ルール**
   - **Setup first**: プロジェクト構造、依存関係、設定の初期化
   - **Tests before code**: コントラクト、エンティティ、統合シナリオのテストを書く
   - **Core development**: モデル、サービス、CLIコマンド、エンドポイントの実装
   - **Integration work**: DB接続、ミドルウェア、ログ、外部サービス
   - **Polish and validation**: ユニットテスト、パフォーマンス最適化、ドキュメント

6. **進捗追跡**
   - 各完了タスク後に進捗を報告
   - 非並列タスクが失敗した場合は実行を停止
   - 並列タスク `[P]`の場合、成功したタスクは継続、失敗したものを報告
   - **重要**: 完了したタスクは`tasks.md`で`[X]`としてマーク

## 6. Analyze - 品質分析

### 目的
実装前に成果物間の一貫性と品質を分析します。

### 実行手順

1. **前提条件の確認**
   ```bash
   .specify/scripts/bash/check-prerequisites.sh --json --require-tasks --include-tasks
   ```

2. **成果物の読み込み**
   - `spec.md`: 仕様
   - `plan.md`: 実装計画
   - `tasks.md`: タスクリスト
   - `.specify/memory/constitution.md`: プロジェクト憲法

3. **検出パス**
   
   **A. 重複検出**:
   - ほぼ重複する要件を特定
   
   **B. 曖昧性検出**:
   - 測定可能な基準がない曖昧な形容詞
   - 未解決のプレースホルダー（TODO、???など）
   
   **C. 不十分な仕様**:
   - 測定可能な結果がない要件
   - 受入基準が欠けているユーザーストーリー
   
   **D. 憲法との整合性**:
   - MUST原則に違反する要件や計画要素
   - 憲法で義務付けられたセクションや品質ゲートの欠落
   
   **E. カバレッジギャップ**:
   - タスクが関連付けられていない要件
   - 要件/ストーリーにマッピングされていないタスク
   
   **F. 不整合**:
   - 用語の不一致
   - データエンティティの不一致
   - タスク順序の矛盾

4. **重要度の割り当て**
   - **CRITICAL**: 憲法のMUST違反、コア仕様の欠落
   - **HIGH**: 重複または矛盾する要件、曖昧なセキュリティ/パフォーマンス属性
   - **MEDIUM**: 用語の不一致、非機能タスクカバレッジの欠落
   - **LOW**: スタイル/文言の改善、軽微な冗長性

5. **レポート生成**
   
   | ID | Category | Severity | Location(s) | Summary | Recommendation |
   |----|----------|----------|-------------|---------|----------------|
   
   追加セクション:
   - カバレッジサマリーテーブル
   - 憲法整合性の問題
   - マッピングされていないタスク
   - メトリクス

6. **次のアクション**
   - CRITICALな問題がある場合: 実装前に解決を推奨
   - LOW/MEDIUMのみの場合: 進行可能、改善提案を提供

**重要**: このコマンドは読み取り専用です。ファイルを変更しません。

## 7. Constitution - プロジェクト憲法管理

### 目的
プロジェクトの開発原則と品質基準を定義・管理します。

### 実行手順

1. **憲法テンプレートの読み込み**
   ```bash
   cat .specify/memory/constitution.md
   ```

2. **プレースホルダーの特定**
   - `[PROJECT_NAME]`
   - `[PRINCIPLE_1_NAME]`
   - など、すべての`[ALL_CAPS_IDENTIFIER]`形式のトークン

3. **値の収集**
   - ユーザー入力から値を取得
   - 既存のリポジトリコンテキストから推論
   - ガバナンス日付の設定

4. **バージョニング**
   - **MAJOR**: 後方互換性のない原則の削除または再定義
   - **MINOR**: 新しい原則/セクションの追加
   - **PATCH**: 明確化、文言修正、タイポ修正

5. **一貫性の伝播**
   以下のファイルとの整合性を確認:
   - `.specify/templates/plan-template.md`
   - `.specify/templates/spec-template.md`
   - `.specify/templates/tasks-template.md`
   - コマンドファイル
   - ランタイムガイダンスドキュメント

6. **同期影響レポート**
   - バージョン変更
   - 変更された原則のリスト
   - 追加/削除されたセクション
   - 更新が必要なテンプレート

7. **検証**
   - 説明されていないブラケットトークンがないこと
   - バージョン行がレポートと一致
   - 日付がISO形式（YYYY-MM-DD）
   - 原則が宣言的、テスト可能、曖昧でない

## .specify/ディレクトリとの連携

### ディレクトリ構造

```
.specify/
├── scripts/
│   └── bash/
│       ├── create-new-feature.sh
│       ├── setup-plan.sh
│       └── check-prerequisites.sh
├── templates/
│   ├── spec-template.md
│   ├── plan-template.md
│   └── tasks-template.md
└── memory/
    └── constitution.md
```

### スクリプトの使用

すべてのスクリプトは`--json`オプションでJSON出力をサポートします:

```bash
# 機能ブランチの作成
.specify/scripts/bash/create-new-feature.sh --json "機能説明"

# 計画のセットアップ
.specify/scripts/bash/setup-plan.sh --json

# 前提条件の確認
.specify/scripts/bash/check-prerequisites.sh --json
.specify/scripts/bash/check-prerequisites.sh --json --paths-only
.specify/scripts/bash/check-prerequisites.sh --json --require-tasks --include-tasks
```

## TDD統合

Spec Kit WorkflowはTDDと統合されています。

### TDDとの連携

1. **Tasks生成時**: テストタスクを実装タスクの前に配置
2. **Implement時**: Red-Green-Refactorサイクルに従う
3. **カバレッジ**: 非機能要件にテストカバレッジを含める

### 関連Skill

- **tdd-basics**: [tdd-basics](../tdd-basics/SKILL.md) - TDDの基本概念
- **testing-typescript**: [testing-typescript](../testing-typescript/SKILL.md) - TypeScriptテスト
- **testing-rust**: [testing-rust](../testing-rust/SKILL.md) - Rustテスト

## ベストプラクティス

### 1. 段階的な進行

各フェーズを完了してから次に進みます。スキップしないでください。

### 2. Clarifyの重要性

実装前に仕様を明確化することで、後戻りのリスクを大幅に削減できます。

### 3. 憲法の遵守

プロジェクト憲法は非交渉です。すべての決定は憲法に従う必要があります。

### 4. 並列実行の活用

タスクに`[P]`マーカーがある場合、並列実行で効率を向上できます。

### 5. 進捗の追跡

`tasks.md`で完了したタスクを`[X]`としてマークし、進捗を可視化します。

## トラブルシューティング

### スクリプトが見つからない

```bash
# .specify/ディレクトリが存在するか確認
ls -la .specify/

# スクリプトに実行権限があるか確認
chmod +x .specify/scripts/bash/*.sh
```

### JSON解析エラー

```bash
# --jsonオプションを使用しているか確認
.specify/scripts/bash/check-prerequisites.sh --json
```

### テンプレートが見つからない

```bash
# テンプレートディレクトリを確認
ls -la .specify/templates/
```

## 参考リソース

- [Spec Kit Documentation](.specify/)
- [Project Constitution](.specify/memory/constitution.md)
- [TDD Basics](../tdd-basics/SKILL.md)

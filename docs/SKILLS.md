# Agent Skills 詳細ガイド

このファイルは、Claude Codeで利用可能なAgent Skillsの詳細な使用方法を説明します。

## Agent Skills 構成

Agent Skillsは以下のディレクトリ構成で管理されています：

```
.claude/skills/
├── tdd-basics/                  # TDD基礎
├── testing-typescript/          # TypeScript/JavaScriptテスト
├── testing-rust/                # Rustテスト
├── ci-cd-setup/                 # CI/CD設定
├── library-research/            # ライブラリ調査
├── spec-kit-workflow/           # Spec Kitワークフロー
├── code-review-workflow/        # コードレビューワークフロー
├── debugging-workflow/          # デバッグワークフロー
├── refactoring-workflow/        # リファクタリングワークフロー
└── documentation-maintenance/   # ドキュメントメンテナンス
```

## Skills vs Commands

**Agent Skills**は、コマンドとは異なり、体系的なワークフローとベストプラクティスを提供します：

- **Skills**: ガイドライン、チェックリスト、ワークフローを提供
- **Commands**: 特定のアクションを実行（廃止）

現在のプロジェクトでは、スマートフォンまたはGitHub ActionsのCronから起動するため、コマンドは削除され、すべてSkillsとして再構成されています。

## 利用可能なSkills

### 1. TDD基礎（tdd-basics）

**概要**: Test-Driven Developmentの基本概念とワークフロー

**トリガー**: 「TDD」「Red-Green-Refactor」「テスト駆動開発」

**主な内容**:
- Red-Green-Refactorサイクル
- TDDベストプラクティス
- テスト戦略（言語非依存）

**参照**: [tdd-basics/SKILL.md](../.claude/skills/tdd-basics/SKILL.md)

---

### 2. TypeScript/JavaScriptテスト（testing-typescript）

**概要**: Jest/Playwrightを使用したテスト実装

**トリガー**: 「TypeScriptテスト」「Jest」「Playwright」

**主な内容**:
- Jest（単体・統合テスト）
- Playwright（E2Eテスト）
- モックとカバレッジ測定

**参照**: [testing-typescript/SKILL.md](../.claude/skills/testing-typescript/SKILL.md)

---

### 3. Rustテスト（testing-rust）

**概要**: cargo test/nextestを使用したテスト実装

**トリガー**: 「Rustテスト」「cargo test」「nextest」

**主な内容**:
- cargo test/nextest
- mockallによるモック
- cargo-llvm-covによるカバレッジ

**参照**: [testing-rust/SKILL.md](../.claude/skills/testing-rust/SKILL.md)

---

### 4. CI/CD設定（ci-cd-setup）

**概要**: GitHub Actionsを使用したCI/CDパイプライン

**トリガー**: 「CI/CD」「GitHub Actions」「デプロイ」

**主な内容**:
- ghatsによる型安全なワークフロー定義
- GitHub Actionsテスト自動化
- デプロイメント戦略

**参照**: [ci-cd-setup/SKILL.md](../.claude/skills/ci-cd-setup/SKILL.md)

---

### 5. ライブラリ調査（library-research）

**概要**: 最新ライブラリ情報の調査と比較

**トリガー**: 「ライブラリ調査」「最新バージョン」「比較」

**主な内容**:
- Context7 MCPを活用した最新情報収集
- ライブラリ比較・評価
- 調査結果のドキュメント化

**参照**: [library-research/SKILL.md](../.claude/skills/library-research/SKILL.md)

---

### 6. Spec Kitワークフロー（spec-kit-workflow）

**概要**: 仕様駆動開発の完全なワークフロー

**トリガー**: 「仕様作成」「Spec Kit」「実装計画」

**主な内容**:
1. **Specify**: 仕様作成
2. **Clarify**: 仕様明確化
3. **Plan**: 実装計画
4. **Tasks**: タスク生成
5. **Implement**: TDD実装
6. **Analyze**: 品質分析
7. **Constitution**: プロジェクト憲法

**参照**: [spec-kit-workflow/SKILL.md](../.claude/skills/spec-kit-workflow/SKILL.md)

---

### 7. コードレビューワークフロー（code-review-workflow）

**概要**: 体系的なコードレビュープロセス

**トリガー**: 「コードレビュー」「PR review」「品質チェック」

**主な内容**:
- レビュー観点チェックリスト
- セキュリティ・パフォーマンスチェック
- レビューコメントのベストプラクティス
- 自動化ツールの活用

**参照**: [code-review-workflow/SKILL.md](../.claude/skills/code-review-workflow/SKILL.md)

---

### 8. デバッグワークフロー（debugging-workflow）

**概要**: 効率的なデバッグプロセス

**トリガー**: 「デバッグ」「エラー解析」「問題調査」

**主な内容**:
- 7ステップのデバッグフロー
- 問題の再現と情報収集
- 仮説の立案と検証
- デバッグテクニック

**参照**: [debugging-workflow/SKILL.md](../.claude/skills/debugging-workflow/SKILL.md)

---

### 9. リファクタリングワークフロー（refactoring-workflow）

**概要**: 安全で効果的なリファクタリング

**トリガー**: 「リファクタリング」「コード改善」「技術的負債」

**主な内容**:
- テストファーストリファクタリング
- コードスメルの特定
- リファクタリングパターン
- 安全なリファクタリング手順

**参照**: [refactoring-workflow/SKILL.md](../.claude/skills/refactoring-workflow/SKILL.md)

---

### 10. ドキュメントメンテナンス（documentation-maintenance）

**概要**: 継続的なドキュメントメンテナンス

**トリガー**: 「ドキュメント」「README」「API docs」

**主な内容**:
- README・API ドキュメント作成
- ドキュメント品質チェック
- コードコメントのベストプラクティス
- ドキュメント生成ツールと自動化

**参照**: [documentation-maintenance/SKILL.md](../.claude/skills/documentation-maintenance/SKILL.md)

---

## Skillsの使用方法

### 自動トリガー

Skillsは、会話の内容に基づいて自動的にトリガーされます。特定のキーワードや文脈が検出されると、関連するSkillが読み込まれます。

### 明示的な参照

特定のSkillを明示的に参照することもできます：

```
「tdd-basicsのガイドに従ってテストを書きたい」
「spec-kit-workflowで仕様を作成してください」
「code-review-workflowのチェックリストを使ってレビューしてください」
```

## Skills間の連携

Skillsは相互に連携して、効率的な開発をサポートします：

- **tdd-basics** ↔ **testing-typescript/rust**: TDDの実践
- **spec-kit-workflow** ↔ **tdd-basics**: 仕様からTDD実装へ
- **code-review-workflow** ↔ **testing-typescript/rust**: テストカバレッジレビュー
- **debugging-workflow** ↔ **testing-typescript/rust**: デバッグテストの作成
- **refactoring-workflow** ↔ **tdd-basics**: テストファーストリファクタリング

## GitHub Actions統合

これらのSkillsはGitHub Actionsと統合して自動実行が可能です。詳細な仕様については、以下を参照してください：

- [CLAUDE_GITHUB_ACTIONS_SPECS.md](./CLAUDE_GITHUB_ACTIONS_SPECS.md)
- [GITHUB_ACTIONS_SETUP.md](./GITHUB_ACTIONS_SETUP.md)

## 関連ドキュメント

- [AGENTS.md](./AGENTS.md) - サブエージェント詳細ガイド
- [SPEC_KIT_TDD_WORKFLOW.md](./SPEC_KIT_TDD_WORKFLOW.md) - Spec Kit + TDD統合ワークフロー
- [GITHUB_ACTIONS_SETUP.md](./GITHUB_ACTIONS_SETUP.md) - GitHub Actions設定ガイド

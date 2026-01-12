# Claude Code GitHub Actions 仕様書

## 概要

## 1. 基本ワークフロー構成

### 1.1 ファイル構成
```
.github/workflows/
├── claude-spec-driven.yml    # 仕様駆動開発ワークフロー
├── claude-tdd.yml           # テスト駆動開発ワークフロー
├── claude-code-review.yml   # コードレビューワークフロー
└── claude-integration.yml   # 統合ワークフロー
```

## 2. 仕様駆動開発ワークフロー

### 2.1 トリガー条件
```yaml
name: Spec-Driven Development with Claude Code

on:
  issues:
    types: [opened, labeled]
  issue_comment:
    types: [created]
  pull_request:
    types: [opened, synchronize]

# ラベルベースのトリガー
- label: 'spec:new'     # 新規仕様作成
- label: 'spec:update'  # 仕様更新
- label: 'spec:review'  # 仕様レビュー
```

### 2.2 ワークフロー手順
```yaml
jobs:
  spec-driven-development:
    runs-on: ubuntu-latest
    if: contains(github.event.issue.labels.*.name, 'spec:') || contains(github.event.comment.body, '@claude /specify')
    
    steps:
    # 1. 環境準備
    - name: Checkout code
      uses: actions/checkout@v4
      
      run: |
        # .specify/ ディレクトリの確認・作成
        mkdir -p .specify/{templates,specs,outputs}
        
    # 3. Claude Code実行
    - name: Run Claude Code - Specification Phase
      uses: anthropics/claude-code-action@v1
      with:
        github-token: ${{ secrets.GITHUB_TOKEN }}
        claude-api-key: ${{ secrets.CLAUDE_API_KEY }}
        commands: |
          # 仕様作成フロー
          /specify ${{ github.event.issue.title }}
          /clarify
          /plan
          /analyze
        
    # 4. 仕様書生成・保存
    - name: Save Specifications
      run: |
        # .specify/specs/ に仕様書を保存
        # タイムスタンプ付きでバックアップ
        
    # 5. Issue/PRにフィードバック
    - name: Update Issue/PR
      uses: actions/github-script@v7
      with:
        script: |
          // 仕様作成結果をIssue/PRにコメント
          // 生成された仕様書へのリンク提供
```

### 2.3 コマンド仕様
```yaml
commands:
  - /specify    # 自然言語から仕様作成
  - /clarify    # 仕様の対話的明確化
  - /plan       # 仕様から実装計画作成
  - /analyze    # 既存仕様の分析
  - /tasks      # TDD準拠のタスクリスト生成
```

## 3. テスト駆動開発ワークフロー

### 3.1 トリガー条件
```yaml
name: Test-Driven Development with Claude Code

on:
  pull_request:
    types: [opened, synchronize]
  issue_comment:
    types: [created]

# TDD特有のトリガー
- comment: '@claude /implement'
- comment: '@claude /test-gen'
- label: 'tdd:red'      # Red フェーズ（失敗テスト作成）
- label: 'tdd:green'    # Green フェーズ（最小実装）
- label: 'tdd:refactor' # Refactor フェーズ（リファクタリング）
```

### 3.2 TDDサイクル実装
```yaml
jobs:
  tdd-cycle:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        phase: [red, green, refactor]
    
    steps:
    # Red Phase - 失敗テスト作成
    - name: TDD Red Phase
      if: matrix.phase == 'red'
      uses: anthropics/claude-code-action@v1
      with:
        github-token: ${{ secrets.GITHUB_TOKEN }}
        claude-api-key: ${{ secrets.CLAUDE_API_KEY }}
        commands: |
          /test-gen --failing --spec-based
          # 仕様書に基づく失敗テスト生成
        
    # Green Phase - 最小実装
    - name: TDD Green Phase
      if: matrix.phase == 'green'
      uses: anthropics/claude-code-action@v1
      with:
        commands: |
          /implement --minimal --test-driven
          # テストを通す最小限の実装
        
    # Refactor Phase - リファクタリング
    - name: TDD Refactor Phase
      if: matrix.phase == 'refactor'
      uses: anthropics/claude-code-action@v1
      with:
        commands: |
          /refactor --maintain-tests --improve-design
          # テストを維持しながら設計改善

    # テスト実行・検証
    - name: Run Tests
      run: |
        # プロジェクトに応じたテストコマンド
        npm test || cargo test || python -m pytest
        
    # カバレッジ測定
    - name: Test Coverage
      uses: codecov/codecov-action@v3
```

### 3.3 自動フィードバックループ
```yaml
    # TDDサイクル自動化
    - name: TDD Feedback Loop
      run: |
        # Red → Green → Refactor の自動サイクル
        if [[ "${{ matrix.phase }}" == "red" ]]; then
          # テストが失敗することを確認
          ! npm test && echo "RED_PHASE_SUCCESS=true" >> $GITHUB_ENV
        elif [[ "${{ matrix.phase }}" == "green" ]]; then
          # テストが成功することを確認
          npm test && echo "GREEN_PHASE_SUCCESS=true" >> $GITHUB_ENV
        elif [[ "${{ matrix.phase }}" == "refactor" ]]; then
          # リファクタリング後もテストが成功
          npm test && echo "REFACTOR_PHASE_SUCCESS=true" >> $GITHUB_ENV
        fi
```

## 4. 統合ワークフロー

```yaml
name: Integrated Spec-Driven TDD

on:
  issues:
    types: [opened]
  pull_request:
    types: [opened, synchronize]

jobs:
  integrated-development:
    runs-on: ubuntu-latest
    
    steps:
    # フェーズ1: 仕様作成
    - name: Specification Phase
      uses: anthropics/claude-code-action@v1
      with:
        commands: |
          /specify ${{ github.event.issue.title }}
          /clarify
          /plan
          
    # フェーズ2: タスク分解
    - name: Task Generation Phase
      uses: anthropics/claude-code-action@v1
      with:
        commands: |
          /tasks --tdd-ready --priority-sorted
          
    # フェーズ3: TDDサイクル実行
    - name: TDD Implementation Phase
      uses: anthropics/claude-code-action@v1
      with:
        commands: |
          /implement --tdd-cycle --spec-compliant
          
    # フェーズ4: 品質チェック
    - name: Quality Assurance Phase
      uses: anthropics/claude-code-action@v1
      with:
        commands: |
          /code-review --comprehensive
          /constitution --compliance-check
```

## 5. 環境設定仕様

### 5.1 必須シークレット
```yaml
secrets:
  CLAUDE_API_KEY:         # Claude API キー（必須）
  GITHUB_TOKEN:           # GitHub アクセストークン（自動設定）
  CODECOV_TOKEN:          # コードカバレッジ（オプション）
```

### 5.2 権限設定
```yaml
permissions:
  contents: write         # ファイル読み書き
  pull-requests: write    # PR操作
  issues: write          # Issue操作
  actions: read          # ワークフロー状態参照
  statuses: write        # ステータス更新
```

### 5.3 環境変数
```yaml
env:
  SPEC_KIT_VERSION: "latest"
  TDD_FRAMEWORK: "auto-detect"  # jest, pytest, cargo-test など
  CLAUDE_MODEL: "claude-3-sonnet-20240229"
  WORKFLOW_MODE: "integrated"   # spec-only, tdd-only, integrated
```

## 6. カスタマイゼーション仕様

### 6.1 プロジェクト固有設定
```yaml
# .claude/settings.json での設定
{
  "spec_kit": {
    "template_dir": ".specify/templates",
    "output_dir": ".specify/outputs",
    "auto_clarify": true,
    "spec_format": "markdown"
  },
  "tdd": {
    "test_framework": "auto",
    "coverage_threshold": 80,
    "red_green_refactor": true,
    "parallel_tests": true
  },
  "integration": {
    "spec_to_tasks": true,
    "auto_implement": false,
    "quality_gates": ["lint", "test", "coverage"]
  }
}
```

### 6.2 フック設定
```yaml
# .claude/hooks/ での実行フック
hooks:
  pre_specify: "hooks/pre-spec.sh"      # 仕様作成前処理
  post_specify: "hooks/post-spec.sh"    # 仕様作成後処理
  pre_implement: "hooks/pre-impl.sh"    # 実装前処理
  post_implement: "hooks/post-impl.sh"  # 実装後処理
  pre_test: "hooks/pre-test.sh"         # テスト前処理
  post_test: "hooks/post-test.sh"       # テスト後処理
```

## 7. モニタリング・ログ仕様

### 7.1 実行ログ
```yaml
# 各フェーズの実行ログ記録
logging:
  spec_phase: ".specify/logs/spec-{timestamp}.log"
  tdd_phase: ".specify/logs/tdd-{timestamp}.log"
  integration: ".specify/logs/integration-{timestamp}.log"
  
# 構造化ログ出力
log_format: "json"
log_level: "info"
```

### 7.2 メトリクス収集
```yaml
metrics:
  spec_completion_time: "仕様作成時間"
  tdd_cycle_duration: "TDDサイクル時間"
  test_coverage: "テストカバレッジ"
  code_quality_score: "コード品質スコア"
  spec_compliance: "仕様準拠率"
```

## 8. エラーハンドリング仕様

### 8.1 エラー分類
```yaml
error_types:
  spec_creation_failed: "仕様作成失敗"
  test_generation_failed: "テスト生成失敗"
  implementation_failed: "実装失敗"
  quality_check_failed: "品質チェック失敗"
```

### 8.2 自動リカバリ
```yaml
recovery_strategies:
  retry_with_clarification: "明確化を伴う再実行"
  fallback_to_manual: "手動フォールバック"
  partial_completion: "部分完了モード"
```

## 9. セキュリティ考慮事項

### 9.1 機密情報保護
- API キーの適切な管理
- 生成コードの機密情報スキャン
- 権限の最小化原則

### 9.2 脆弱性チェック
```yaml
security_checks:
  dependency_scan: "依存関係脆弱性スキャン"
  code_scan: "生成コード脆弱性スキャン"
  secret_scan: "機密情報漏洩チェック"
```

## 10. 実装例

### 10.1 最小構成ワークフロー
```yaml
# .github/workflows/claude-minimal.yml
name: Claude Code Minimal Integration

on:
  issues:
    types: [opened]
  issue_comment:
    types: [created]

jobs:
  claude-development:
    if: contains(github.event.comment.body, '@claude') || github.event_name == 'issues'
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v4
    - uses: anthropics/claude-code-action@v1
      with:
        github-token: ${{ secrets.GITHUB_TOKEN }}
        claude-api-key: ${{ secrets.CLAUDE_API_KEY }}
```

この仕様書に基づいて、プロジェクトの要件に応じてワークフローをカスタマイズして実装してください。
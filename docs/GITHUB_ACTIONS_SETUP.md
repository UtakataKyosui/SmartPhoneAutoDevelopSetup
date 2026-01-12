# GitHub Actions設定ガイド

このドキュメントでは、Claude CodeをGitHub Actionsで実行するための設定について説明します。

## 現在の設定概要

### ワークフローファイル
- **メインワークフロー**: `.github/workflows/claude.yml`
- **コードレビューワークフロー**: `.github/workflows/claude-code-review.yml`

### トリガー条件
Claude Codeは以下の条件でトリガーされます：

```yaml
on:
  issue_comment:
    types: [created]
  pull_request_review_comment:
    types: [created]
  issues:
    types: [opened, assigned]
  pull_request_review:
    types: [submitted]
```

**実行条件**:
- Issue/PRコメントに `@claude` が含まれる
- Issueのタイトルまたは本文に `@claude` が含まれる
- PRレビューに `@claude` が含まれる

### 権限設定
Claude Codeには以下の権限が付与されています：

```yaml
permissions:
  contents: write          # コード・ファイルアクセス
  pull-requests: write     # PR操作
  issues: write           # Issue操作
  actions: read           # ワークフロー状態閲覧
  statuses: write         # コミット・PRステータス設定
  repository-projects: write # プロジェクトボード操作
  id-token: write         # OIDC認証
```

### 必要なシークレット

以下のシークレットを設定する必要があります：

1. **`CLAUDE_CODE_OAUTH_TOKEN`**
   - Claude Code OAuthトークン
   - Claude Code WebUIで生成

2. **`ANTHROPIC_API_KEY`**
   - Anthropic APIキー
   - Anthropic Consoleで取得

### 設定ファイル

#### `.claude/settings.json`
Claude Codeの基本設定：

```json
{
  "allowedTools": ["*"],
  "customCommands": {
    "enabled": true,
    "directory": ".claude/commands"
  },
  "agents": {
    "enabled": true,
    "directory": ".claude/agents"
  },
  "hooks": {
    "enabled": true,
    "directory": ".claude/hooks"
  }
}
```

## ワークフローの動作

### 1. 環境セットアップ
```yaml
- name: Checkout repository
  uses: actions/checkout@v4
  with:
    fetch-depth: 0

- name: Setup Node.js
  uses: actions/setup-node@v4
  with:
    node-version: '20'

- name: Install uv CLI
  uses: astral-sh/setup-uv@v4
```

### 2. Git設定
```yaml
- name: Setup Git configuration
  run: |
    git config --global user.name "Claude Code"
    git config --global user.email "claude-code@anthropic.com"
    git config --global init.defaultBranch main
```

### 3. PR情報取得（PRの場合）
```yaml
- name: Get PR info (only if PR)
  if: ${{ github.event.issue.pull_request }}
  run: |
    if ! gh pr view ${{ github.event.issue.number }} --json number,title,body,baseRefName,headRefName > pr_info.json; then
      echo "Failed to get PR info, creating empty file"
      echo '{}' > pr_info.json
    fi
```

### 4. Claude Code実行
```yaml
- name: Run Claude Code
  uses: anthropics/claude-code-action@v1
  with:
    claude_code_oauth_token: ${{ secrets.CLAUDE_CODE_OAUTH_TOKEN }}
    anthropic_api_key: ${{ secrets.ANTHROPIC_API_KEY }}
    settings: ".claude/settings.json"
    track_progress: true
    branch_prefix: develop/claude/
    use_sticky_comment: true
```

## ブランチ戦略

### ブランチ命名規則
```
develop/claude/issue-{issue-number}-{timestamp}
```

例：`develop/claude/issue-5-20250926-1255`

### マージ戦略
1. Issueから自動ブランチ作成
2. 機能実装・テスト
3. PR作成（mainブランチへ）
4. レビュー・マージ

## カスタマイズ可能な設定

### 1. ブランチプレフィックス
```yaml
branch_prefix: develop/claude/
```

### 2. プログレス追跡
```yaml
track_progress: true
```

### 3. スティッキーコメント
```yaml
use_sticky_comment: true
```

### 4. プロンプトカスタマイズ
```yaml
prompt: |
  # Claude Code Prompt Template
  ## GitHub コンテキスト
  リポジトリ: ${{ github.repository }}
  実行ユーザー: ${{ github.actor }}
  
  [カスタムプロンプト内容]
```

## トラブルシューティング

### よくある問題

#### 1. 権限エラー
**症状**: `Permission denied` エラー
**解決**:
- シークレット設定の確認
- リポジトリ権限の確認
- workflows/の権限確認

#### 2. ワークフロー実行されない
**症状**: `@claude` コメント後に実行されない
**解決**:
- トリガー条件の確認
- イベントタイプの確認
- ワークフローファイル構文チェック

#### 3. Claude Codeタイムアウト
**症状**: ワークフロー途中で停止
**解決**:
- タスクの分割
- タイムアウト時間調整
- リソース使用量確認

### デバッグ方法

1. **ワークフローログ確認**
   - GitHub Actions画面でログ詳細確認

2. **設定ファイル検証**
   ```bash
   # settings.jsonの構文確認
   cat .claude/settings.json | jq .
   ```

3. **権限テスト**
   ```bash
   # GitHub CLIでの権限確認
   gh auth status
   gh repo view --json permissions
   ```

## ベストプラクティス

### 1. セキュリティ
- シークレットの定期更新
- 最小権限の原則
- 監査ログの確認

### 2. パフォーマンス
- キャッシュ活用
- 並列処理の最適化
- 不要なステップの削除

### 3. 保守性
- ワークフローの文書化
- 設定の標準化
- 定期的な依存関係更新

## まとめ

GitHub Actions設定により以下が実現されます：

- ✅ **自動化**: Issue/PRでの自動Claude Code実行
- ✅ **セキュリティ**: 適切な権限管理とシークレット保護
- ✅ **効率性**: ブランチ戦略とプログレス追跡
- ✅ **カスタマイズ**: プロジェクト固有の設定対応
- ✅ **可視性**: 実行ログとステータス追跡


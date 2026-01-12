# Claude Code Prompt Template

## GitHub コンテキスト
リポジトリ: ${GITHUB_REPOSITORY}
実行ユーザー: ${GITHUB_ACTOR}

### PR / Issue 情報
- PR番号: ${ISSUE_NUMBER}
- PRタイトル: ${PR_TITLE}
- PR本文: |
  ${PR_BODY}
- コメント本文: |
  ${COMMENT_BODY}

### ブランチ情報
- Baseブランチ: ${PR_BASE}
- Headブランチ: ${PR_HEAD}
- Baseブランチ (GitHub): ${GITHUB_BASE_REF}
- Headブランチ (GitHub): ${GITHUB_HEAD_REF}

${PROMPT}

#!/bin/bash
# デプロイ前チェックスクリプト
# すべてのテスト、リント、セキュリティチェック、ビルドを実行

set -e

# カラー出力
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 デプロイ前チェックスクリプト${NC}"
echo ""

ERRORS=0
WARNINGS=0

# プロジェクトタイプの検出
detect_project_type() {
    if [ -f "package.json" ]; then
        echo "typescript"
    elif [ -f "Cargo.toml" ]; then
        echo "rust"
    else
        echo "unknown"
    fi
}

PROJECT_TYPE=$(detect_project_type)

if [ "$PROJECT_TYPE" = "unknown" ]; then
    echo -e "${RED}❌ サポートされていないプロジェクトタイプです${NC}"
    exit 1
fi

echo -e "${GREEN}プロジェクトタイプ: $PROJECT_TYPE${NC}"
echo ""

# チェック1: テストの実行
check_tests() {
    echo -e "${YELLOW}1️⃣  テストの実行...${NC}"
    
    case $PROJECT_TYPE in
        typescript)
            if npm test; then
                echo -e "${GREEN}✓ すべてのテストがパスしました${NC}"
            else
                echo -e "${RED}✗ テストが失敗しました${NC}"
                ERRORS=$((ERRORS + 1))
            fi
            ;;
        rust)
            if command -v cargo-nextest &> /dev/null; then
                TEST_CMD="cargo nextest run"
            else
                TEST_CMD="cargo test"
            fi
            
            if $TEST_CMD; then
                echo -e "${GREEN}✓ すべてのテストがパスしました${NC}"
            else
                echo -e "${RED}✗ テストが失敗しました${NC}"
                ERRORS=$((ERRORS + 1))
            fi
            ;;
    esac
    echo ""
}

# チェック2: リントエラーの確認
check_lint() {
    echo -e "${YELLOW}2️⃣  リントの確認...${NC}"
    
    case $PROJECT_TYPE in
        typescript)
            if grep -q "\"lint\"" package.json; then
                if npm run lint; then
                    echo -e "${GREEN}✓ リントエラーなし${NC}"
                else
                    echo -e "${RED}✗ リントエラーがあります${NC}"
                    ERRORS=$((ERRORS + 1))
                fi
            else
                echo -e "${YELLOW}⚠ lintスクリプトが定義されていません${NC}"
                WARNINGS=$((WARNINGS + 1))
            fi
            ;;
        rust)
            if cargo clippy -- -D warnings; then
                echo -e "${GREEN}✓ Clippyエラーなし${NC}"
            else
                echo -e "${RED}✗ Clippyエラーがあります${NC}"
                ERRORS=$((ERRORS + 1))
            fi
            ;;
    esac
    echo ""
}

# チェック3: フォーマットの確認
check_format() {
    echo -e "${YELLOW}3️⃣  フォーマットの確認...${NC}"
    
    case $PROJECT_TYPE in
        typescript)
            if grep -q "\"format\"" package.json; then
                if npm run format -- --check; then
                    echo -e "${GREEN}✓ フォーマットエラーなし${NC}"
                else
                    echo -e "${RED}✗ フォーマットエラーがあります${NC}"
                    ERRORS=$((ERRORS + 1))
                fi
            else
                echo -e "${YELLOW}⚠ formatスクリプトが定義されていません${NC}"
                WARNINGS=$((WARNINGS + 1))
            fi
            ;;
        rust)
            if cargo fmt -- --check; then
                echo -e "${GREEN}✓ フォーマットエラーなし${NC}"
            else
                echo -e "${RED}✗ フォーマットエラーがあります${NC}"
                ERRORS=$((ERRORS + 1))
            fi
            ;;
    esac
    echo ""
}

# チェック4: セキュリティ脆弱性の確認
check_security() {
    echo -e "${YELLOW}4️⃣  セキュリティチェック...${NC}"
    
    case $PROJECT_TYPE in
        typescript)
            if npm audit --audit-level=high; then
                echo -e "${GREEN}✓ セキュリティ脆弱性なし${NC}"
            else
                echo -e "${RED}✗ セキュリティ脆弱性が見つかりました${NC}"
                echo "  実行: npm audit fix"
                ERRORS=$((ERRORS + 1))
            fi
            ;;
        rust)
            if command -v cargo-audit &> /dev/null; then
                if cargo audit; then
                    echo -e "${GREEN}✓ セキュリティ脆弱性なし${NC}"
                else
                    echo -e "${RED}✗ セキュリティ脆弱性が見つかりました${NC}"
                    ERRORS=$((ERRORS + 1))
                fi
            else
                echo -e "${YELLOW}⚠ cargo-auditがインストールされていません${NC}"
                echo "  インストール: cargo install cargo-audit"
                WARNINGS=$((WARNINGS + 1))
            fi
            ;;
    esac
    echo ""
}

# チェック5: ビルドの確認
check_build() {
    echo -e "${YELLOW}5️⃣  ビルドの確認...${NC}"
    
    case $PROJECT_TYPE in
        typescript)
            if grep -q "\"build\"" package.json; then
                if npm run build; then
                    echo -e "${GREEN}✓ ビルド成功${NC}"
                else
                    echo -e "${RED}✗ ビルドが失敗しました${NC}"
                    ERRORS=$((ERRORS + 1))
                fi
            else
                echo -e "${YELLOW}⚠ buildスクリプトが定義されていません${NC}"
                WARNINGS=$((WARNINGS + 1))
            fi
            ;;
        rust)
            if cargo build --release; then
                echo -e "${GREEN}✓ ビルド成功${NC}"
            else
                echo -e "${RED}✗ ビルドが失敗しました${NC}"
                ERRORS=$((ERRORS + 1))
            fi
            ;;
    esac
    echo ""
}

# チェック6: カバレッジの確認
check_coverage() {
    echo -e "${YELLOW}6️⃣  カバレッジの確認...${NC}"
    
    case $PROJECT_TYPE in
        typescript)
            if [ -f "coverage/coverage-summary.json" ]; then
                if command -v jq &> /dev/null; then
                    COVERAGE=$(jq '.total.lines.pct' coverage/coverage-summary.json)
                    echo -e "${GREEN}カバレッジ: ${COVERAGE}%${NC}"
                    
                    if (( $(echo "$COVERAGE < 80" | bc -l) )); then
                        echo -e "${YELLOW}⚠ カバレッジが目標（80%）を下回っています${NC}"
                        WARNINGS=$((WARNINGS + 1))
                    else
                        echo -e "${GREEN}✓ カバレッジ目標を達成${NC}"
                    fi
                else
                    echo -e "${YELLOW}⚠ jqがインストールされていません${NC}"
                    WARNINGS=$((WARNINGS + 1))
                fi
            else
                echo -e "${YELLOW}⚠ カバレッジレポートが見つかりません${NC}"
                echo "  実行: npm test -- --coverage"
                WARNINGS=$((WARNINGS + 1))
            fi
            ;;
        rust)
            echo -e "${YELLOW}⚠ Rustのカバレッジチェックはスキップされました${NC}"
            echo "  手動実行: cargo llvm-cov --lcov --output-path lcov.info"
            WARNINGS=$((WARNINGS + 1))
            ;;
    esac
    echo ""
}

# すべてのチェックを実行
check_tests
check_lint
check_format
check_security
check_build
check_coverage

# 結果サマリー
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}📋 チェック結果サマリー${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo -e "${GREEN}✅ すべてのチェックがパスしました${NC}"
    echo -e "${GREEN}🚀 デプロイ準備完了${NC}"
    exit 0
elif [ $ERRORS -eq 0 ]; then
    echo -e "${YELLOW}⚠️  $WARNINGS 件の警告があります${NC}"
    echo -e "${YELLOW}デプロイは可能ですが、警告を確認してください${NC}"
    exit 0
else
    echo -e "${RED}❌ $ERRORS 件のエラーが見つかりました${NC}"
    if [ $WARNINGS -gt 0 ]; then
        echo -e "${YELLOW}⚠️  $WARNINGS 件の警告もあります${NC}"
    fi
    echo -e "${RED}エラーを修正してから再度実行してください${NC}"
    exit 1
fi

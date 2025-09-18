#!/bin/bash
# Cargo clippy check hook for Claude Code
set -e

# Ensure Rust environment is loaded
if command -v cargo >/dev/null 2>&1; then
    echo "🔧 Running cargo clippy..."
    cargo clippy --quiet -- -D warnings
    if [ $? -eq 0 ]; then
        echo "✅ Clippy checks passed"
    else
        echo "❌ Clippy found issues"
        exit 1
    fi
else
    # Load Rust environment if not available
    if [ -f "$HOME/.cargo/env" ]; then
        source "$HOME/.cargo/env"
        echo "🔧 Running cargo clippy..."
        cargo clippy --quiet -- -D warnings
        if [ $? -eq 0 ]; then
            echo "✅ Clippy checks passed"
        else
            echo "❌ Clippy found issues"
            exit 1
        fi
    else
        echo "⚠️ Cargo not found, skipping clippy check"
        exit 0
    fi
fi

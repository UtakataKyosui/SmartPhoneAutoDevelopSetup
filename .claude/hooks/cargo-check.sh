#!/bin/bash
# Cargo check hook for Claude Code
set -e

# Ensure Rust environment is loaded
if command -v cargo >/dev/null 2>&1; then
    echo "🔍 Running cargo check..."
    cargo check --quiet
    if [ $? -eq 0 ]; then
        echo "✅ Cargo check passed"
    else
        echo "❌ Cargo check failed"
        exit 1
    fi
else
    # Load Rust environment if not available
    if [ -f "$HOME/.cargo/env" ]; then
        source "$HOME/.cargo/env"
        echo "🔍 Running cargo check..."
        cargo check --quiet
        if [ $? -eq 0 ]; then
            echo "✅ Cargo check passed"
        else
            echo "❌ Cargo check failed"
            exit 1
        fi
    else
        echo "⚠️ Cargo not found, skipping check"
        exit 0
    fi
fi

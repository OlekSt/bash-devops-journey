#!/usr/bin/env bash
#
# setup.sh - Initial environment setup for Bash Mastery project
#
# Usage: ./scripts/setup.sh

set -euo pipefail

echo "🚀 Setting up Bash Mastery development environment..."

# Check Bash version
if ((BASH_VERSINFO[0] < 4)); then
    echo "❌ Error: Bash 4.0+ required. Current version: $BASH_VERSION"
    exit 1
fi

echo "✅ Bash version: $BASH_VERSION"

# Check for required tools
command -v shellcheck >/dev/null 2>&1 || {
    echo "⚠️  Warning: shellcheck not found. Install with:"
    echo "   Ubuntu/Debian: sudo apt-get install shellcheck"
    echo "   macOS: brew install shellcheck"
}

command -v git >/dev/null 2>&1 || {
    echo "❌ Error: git is required but not installed"
    exit 1
}

# Create output directories if they don't exist
mkdir -p sentinel/output cerberus/output

# Set executable permissions on main scripts (will create placeholders)
touch sentinel/src/sentinel.sh cerberus/src/cerberus.sh
chmod +x sentinel/src/sentinel.sh cerberus/src/cerberus.sh

echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "  1. Review README.md for project overview"
echo "  2. Start with Day 1 learning log"
echo "  3. Begin building Sentinel monitoring core"

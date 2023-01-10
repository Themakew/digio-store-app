#!/bin/sh

# Brew
if ! which brew > /dev/null; then
echo "⌛️ Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# SwitfLint
if ! which brew > /dev/null; then
echo "⌛️ Installing Swiftlint..."
brew install swiftlint
fi

# Finished
echo "🚀 Bootstrap Finished!"

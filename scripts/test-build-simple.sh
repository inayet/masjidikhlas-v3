#!/usr/bin/env bash

# Simple build test script
set -e

echo "🕌 Masjid Ikhlas V3 - Simple Build Test"
echo "======================================"

# Clean up
rm -rf public

# Test 1: Nix environment
echo "Testing Nix environment..."
if nix develop --command echo 'OK' > /dev/null 2>&1; then
    echo "✅ Nix environment: PASSED"
else
    echo "❌ Nix environment: FAILED"
    exit 1
fi

# Test 2: Hugo build
echo "Testing Hugo build..."
if nix shell nixpkgs#hugo --command bash -c 'cd site && hugo --gc --minify' > /dev/null 2>&1; then
    echo "✅ Hugo build: PASSED"
else
    echo "❌ Hugo build: FAILED"
    exit 1
fi

# Test 3: Check output
echo "Testing output files..."
if [[ -f "site/public/index.html" ]]; then
    echo "✅ Output files: PASSED"
else
    echo "❌ Output files: FAILED"
    exit 1
fi

echo "🎉 All tests passed!"
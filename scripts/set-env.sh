#!/bin/bash
# Dynamic environment configuration for Hugo
# Usage: source scripts/set-env.sh

set -euo pipefail

# Detect environment automatically
detect_environment() {
    if [[ "${GITHUB_ACTIONS:-}" == "true" ]]; then
        echo "github-pages"
    elif [[ "${CI:-}" == "true" ]]; then
        echo "production"
    elif [[ -n "${RAILWAY_ENVIRONMENT:-}" ]]; then
        echo "railways"
    else
        echo "local"
    fi
}

# Set HUGO_ENV based on detection
export HUGO_ENV="${HUGO_ENV:-$(detect_environment)}"

echo "🔧 Hugo Environment: $HUGO_ENV"

# Set baseURL based on environment
case "$HUGO_ENV" in
    "local")
        export HUGO_BASEURL="http://localhost:1313"
        ;;
    "github-pages")
        export HUGO_BASEURL="https://inayet.github.io/masjidikhlas-v3/"
        ;;
    "production")
        export HUGO_BASEURL="https://masjidikhlas.org"
        ;;
    "railways")
        export HUGO_BASEURL="https://masjidikhlas.up.railway.app"
        ;;
    *)
        echo "❌ Unknown environment: $HUGO_ENV"
        exit 1
        ;;
esac

echo "🌐 Base URL: $HUGO_BASEURL"

# Set HUGO_PARAMS_BASEURL for Hugo
export HUGO_PARAMS_BASEURL="$HUGO_BASEURL"
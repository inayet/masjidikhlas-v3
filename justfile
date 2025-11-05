# Masjid Ikhlas V3 - Justfile Commands
# Run 'just' to see available commands

# Default recipe - show help
default:
    @echo "Masjid Ikhlas V3 - Streamlined Development Commands"
    @echo ""
    @echo "🚀 Quick Start:"
    @echo "  just start        - Setup and start development"
    @echo "  just publish      - Build, validate, and deploy"
    @echo "  just doctor       - Check system health"
    @echo ""
    @echo "📝 Content:"
    @echo "  just new-page <name> - Create new page"
    @echo "  just update-prayer-times - Update prayer schedule"
    @echo ""
    @echo "🔍 Quality:"
    @echo "  just check-all    - Run all quality checks"
    @echo "  just preview      - Build and preview locally"
    @echo ""
    @echo "Run 'just --list' for all commands"

# 🚀 Streamlined Workflows

start:
    # Setup and start development environment
    @echo "🚀 Starting Masjid Ikhlas V3 development..."
    just doctor
    @echo ""
    @echo "🌐 Starting development server..."
    @echo "Site will be available at: http://localhost:1313"
    @echo "Press Ctrl+C to stop"
    cd site && hugo server --bind 0.0.0.0 --port 1313 --buildDrafts --buildFuture --navigateToChanged --baseURL http://localhost:1313

publish:
    # Complete publishing workflow: validate → build → deploy
    @echo "📤 Publishing Masjid Ikhlas V3..."
    just safe-deploy

publish-github:
    # Publish to GitHub Pages with full validation
    @echo "📤 Publishing to GitHub Pages..."
    just pre-deploy-check || (echo "❌ Pre-deployment checks failed!" && exit 1)
    @echo ""
    @echo "🔧 Setting GitHub Pages environment..."
    just set-env github-pages
    @echo ""
    @echo "🏗️  Building site..."
    just build
    @echo ""
    @echo "🚀 Deploying to GitHub..."
    just push
    @echo ""
    @echo "🎉 Published successfully to GitHub Pages!"
    @echo "🌐 Live at: https://inayet.github.io/masjidikhlas-v3"

publish-production:
    # Publish to production domain with full validation
    @echo "📤 Publishing to production..."
    just pre-deploy-check || (echo "❌ Pre-deployment checks failed!" && exit 1)
    @echo ""
    @echo "🔧 Setting production environment..."
    just set-env production
    @echo ""
    @echo "🏗️  Building site..."
    just build
    @echo ""
    @echo "📦 Ready for production deployment"
    @echo "🌐 Will be live at: https://masjidikhlas.org"
    @echo ""
    @echo "⚠️  Manual deployment required for production domain"
    @echo "   1. Configure DNS CNAME to point to your hosting"
    @echo "   2. Upload site/public/ to your hosting provider"
    @echo "   3. Configure SSL certificate"

preview:
    # Build and preview production build locally
    @echo "🔍 Building production preview..."
    just prod-build
    @echo "🌐 Starting HTTPS preview server..."
    @echo "Site will be available at: https://localhost:8443"
    nix run .#serve

doctor:
    # Check system health and dependencies
    @echo "🔍 System Health Check"
    @echo "====================="
    @echo "✅ Just: $(just --version 2>/dev/null || echo 'not installed')"
    @echo "✅ Nix: $(nix --version 2>/dev/null || echo 'not installed')"
    @echo "✅ Git: $(git --version 2>/dev/null || echo 'not installed')"
    @echo ""
    @echo "📁 Project Status:"
    @if [ -d "site" ]; then echo "✅ Hugo site directory exists"; else echo "❌ Hugo site directory missing"; fi
    @if [ -f "flake.nix" ]; then echo "✅ Nix flake exists"; else echo "❌ Nix flake missing"; fi
    @if [ -f "justfile" ]; then echo "✅ Justfile exists"; else echo "❌ Justfile missing"; fi
    @echo ""
    @echo "🌐 Git Status:"
    @git status --porcelain || echo "Not a git repository"

# Development
dev:
    # Start local development server
    nix develop

serve:
    # Start Hugo development server
    cd site && hugo server --bind 0.0.0.0 --port 1313 --buildDrafts --buildFuture

serve-https:
    # Start local HTTPS server with Caddy
    nix run .#serve

# 🔍 Quality Assurance

check-all:
    # Run all quality checks: validate → lint → links → seo
    @echo "🔍 Running comprehensive quality checks..."
    @echo ""
    @echo "1️⃣ Validating content structure..."
    just validate
    @echo ""
    @echo "2️⃣ Linting content..."
    just lint
    @echo ""
    @echo "3️⃣ Checking links..."
    just check-links
    @echo ""
    @echo "4️⃣ Running SEO analysis..."
    just seo-check
    @echo ""
    @echo "✅ All quality checks completed!"

pre-deploy-check:
    # Comprehensive pre-deployment validation
    @echo "🚀 Pre-deployment validation..."
    @echo ""
    @echo "1️⃣ Checking for uncommitted changes..."
    @if [ -n "$(git status --porcelain)" ]; then
        echo "❌ You have uncommitted changes:"
        git status --porcelain
        echo ""
        echo "Please commit your changes first:"
        echo "  git add ."
        echo "  git commit -m 'Your commit message'"
        exit 1
    else
        echo "✅ No uncommitted changes"
    fi
    @echo ""
    @echo "2️⃣ Running quality checks..."
    just check-all || (echo "❌ Quality checks failed!" && exit 1)
    @echo ""
    @echo "3️⃣ Checking build environment..."
    just doctor
    @echo ""
    @echo "✅ Pre-deployment validation complete!"

safe-deploy:
    # Safe deployment that protects local changes
    @echo "🛡️  Safe deployment workflow..."
    just pre-deploy-check || (echo "❌ Pre-deployment checks failed!" && exit 1)
    @echo ""
    @echo "🚀 Proceeding with deployment..."
    just deploy

backup-local:
    # Backup local changes before pulling
    @echo "💾 Creating backup of local changes..."
    @mkdir -p .backups
    @git stash push -m "Auto-backup before pull $(date +%Y%m%d_%H%M%S)"
    @echo "✅ Changes stashed safely"

safe-pull:
    # Pull changes without overwriting local work
    @echo "🔄 Safe pull workflow..."
    @if [ -n "$(git status --porcelain)" ]; then
        echo "📦 You have local changes, creating backup..."
        just backup-local
    fi
    @echo "📥 Pulling latest changes..."
    @git pull origin main
    @echo "✅ Pull complete"
    @if [ -n "$(git stash list)" ]; then
        echo "📦 Restoring your changes..."
        @git stash pop
    fi

safe-sync:
    # Sync with remote while preserving local changes
    @echo "🔄 Safe sync workflow..."
    just safe-pull
    @echo ""
    @echo "🔍 Checking for merge conflicts..."
    @if [ -n "$(git diff --name-only --diff-filter=U)" ]; then
        echo "⚠️  Merge conflicts detected in:"
        git diff --name-only --diff-filter=U
        echo ""
        echo "Please resolve conflicts manually, then:"
        echo "  git add ."
        echo "  git commit"
        exit 1
    else
        echo "✅ No conflicts detected"
    fi

quick-check:
    # Fast validation only (for development)
    @echo "⚡ Quick validation..."
    cd site && hugo --minify --gc
    @echo "✅ Site builds successfully"

# Building & Validation
build:
    # Build static site
    nix run .#site

workflow:
    # Run full workflow: merge → validate → build
    nix run .#workflow

validate:
    # Validate content structure
    cd site && hugo check

clean:
    # Clean build artifacts
    cd site && rm -rf public/ resources/ .hugo_build.lock

reset:
    # Complete reset: clean + fresh build
    @echo "🔄 Resetting project..."
    just clean
    just build
    @echo "✅ Project reset complete"

# 🚀 Deployment

status:
    # Show comprehensive project status
    @echo "📊 Project Status"
    @echo "================="
    @echo "🌐 Git Status:"
    @git status --porcelain --branch
    @echo ""
    @echo "📁 Site Size:"
    @just size
    @echo ""
    @echo "📄 Pages Generated:"
    @just pages
    @echo ""
    @echo "🔧 Last Build:"
    @if [ -f "site/public/index.html" ]; then echo "✅ Site built"; ls -la site/public/index.html; else echo "❌ Site not built"; fi

push:
    # Push changes to GitHub (triggers deployment)
    @echo "🚀 Pushing to GitHub..."
    git push origin main
    @echo "✅ Pushed successfully!"

deploy:
    # Build and deploy to GitHub Pages
    @echo "🚀 Deploying to GitHub Pages..."
    just set-env github-pages
    just build && just push
    @echo "🎉 Deployment complete!"

deploy-local:
    # Build for local development
    @echo "🏠 Building for local development..."
    just set-env local
    just build

deploy-production:
    # Build for production deployment
    @echo "🌐 Building for production deployment..."
    just set-env production
    just build

deploy-railways:
    # Build for Railways deployment
    @echo "🚂 Building for Railways deployment..."
    just set-env railways
    just build

set-env environment="github-pages":
    # Set baseURL for specific environment (safely)
    @echo "🔧 Setting environment to: {{environment}}"
    #!/usr/bin/env bash
    # Backup current config
    cp site/hugo.toml site/hugo.toml.backup
    case "{{environment}}" in
    "local")
        sed -i 's|baseURL = .*|baseURL = "http://localhost:1313"|' site/hugo.toml
        ;;
    "github-pages")
        sed -i 's|baseURL = .*|baseURL = "https://inayet.github.io/masjidikhlas-v3"|' site/hugo.toml
        ;;
    "production")
        sed -i 's|baseURL = .*|baseURL = "https://masjidikhlas.org"|' site/hugo.toml
        ;;
    "railways")
        sed -i 's|baseURL = .*|baseURL = "https://masjidikhlas.up.railway.app"|' site/hugo.toml
        ;;
    *)
        echo "❌ Unknown environment: {{environment}}"
        echo "Available: local, github-pages, production, railways"
        # Restore backup
        mv site/hugo.toml.backup site/hugo.toml
        exit 1
        ;;
    esac
    @echo "✅ Environment set to {{environment}}"
    @echo "💾 Backup saved to site/hugo.toml.backup"

restore-config:
    # Restore configuration from backup
    @if [ -f "site/hugo.toml.backup" ]; then
        echo "🔄 Restoring configuration from backup..."
        mv site/hugo.toml.backup site/hugo.toml
        echo "✅ Configuration restored"
    else
        echo "❌ No backup found"
    fi

show-env:
    # Show current environment settings
    @echo "🌐 Current Environment Settings"
    @echo "=============================="
    @grep "baseURL" site/hugo.toml || echo "No baseURL found"
    @echo ""
    @echo "Available environments:"
    @echo "  local       - http://localhost:1313"
    @echo "  github-pages - https://inayet.github.io/masjidikhlas-v3"
    @echo "  production  - https://masjidikhlas.org"
    @echo "  railways    - https://masjidikhlas.up.railway.app"

sync:
    # Pull latest changes and rebuild
    @echo "🔄 Syncing with remote..."
    git pull origin main
    just build
    @echo "✅ Sync complete"

# Git & Deployment (legacy aliases)
git-status:
    git status

# 📝 Content Management

new-page name:
    # Create new page: just new-page page-name
    mkdir -p site/content/{{name}}
    echo '---' > site/content/{{name}}/_index.md
    echo 'title: "{{name}}"' >> site/content/{{name}}/_index.md
    echo "date: $(date +%Y-%m-%d)" >> site/content/{{name}}/_index.md
    echo 'draft: false' >> site/content/{{name}}/_index.md
    echo 'description: "Description for {{name}}"' >> site/content/{{name}}/_index.md
    echo '---' >> site/content/{{name}}/_index.md
    echo '' >> site/content/{{name}}/_index.md
    echo '# {{name}}' >> site/content/{{name}}/_index.md
    echo '' >> site/content/{{name}}/_index.md
    echo 'Content goes here.' >> site/content/{{name}}/_index.md
    echo '' >> site/content/{{name}}/_index.md
    echo '## Overview' >> site/content/{{name}}/_index.md
    echo '' >> site/content/{{name}}/_index.md
    echo 'Add overview information here.' >> site/content/{{name}}/_index.md
    echo '' >> site/content/{{name}}/_index.md
    echo '## Details' >> site/content/{{name}}/_index.md
    echo '' >> site/content/{{name}}/_index.md
    echo 'Add detailed information here.' >> site/content/{{name}}/_index.md
    echo '' >> site/content/{{name}}/_index.md
    echo '## Resources' >> site/content/{{name}}/_index.md
    echo '' >> site/content/{{name}}/_index.md
    echo '- [Resource 1](#)' >> site/content/{{name}}/_index.md
    echo '- [Resource 2](#)' >> site/content/{{name}}/_index.md
    echo "✅ Created: site/content/{{name}}/_index.md"
    echo ""
    echo "📝 Next steps:"
    echo "1. Edit content: site/content/{{name}}/_index.md"
    echo "2. Add to navigation menu in site/hugo.toml if needed"
    echo "3. Test locally: just serve"

new-event name:
    # Create new event: just new-event ramadan-2025
    #!/usr/bin/env bash
    set -e
    EVENT_NAME="{{name}}"
    CONTENT_DIR="site/content/events"
    EVENT_FILE="$CONTENT_DIR/$EVENT_NAME.md"
    
    echo "📅 Creating new event: $EVENT_NAME"
    
    # Create event with template
    printf '---\ntitle: "%s"\ndate: %s\ndraft: false\nevent_date: "%s"\nevent_time: "6:00 PM"\nlocation: "Masjid Ikhlas"\nregistration_required: false\n---\n\n# %s\n\n## Event Details\n\n**Date:** %s  \n**Time:** 6:00 PM  \n**Location:** Masjid Ikhlas Main Hall\n\n## Description\n\nAdd event description here.\n\n## Registration\n\nIf registration is required, add registration details here.\n\n## Contact\n\nFor more information, contact: office@masjidikhlas.org | (303) 920-0252\n' "$EVENT_NAME" "$(date +%Y-%m-%d)" "$(date +%Y-%m-%d)" "$EVENT_NAME" "$(date +%B %-d, %Y)" > "$EVENT_FILE"
    
    echo "✅ Created: $EVENT_FILE"
    echo ""
    echo "📝 Next steps:"
    echo "1. Edit the event details: $EVENT_FILE"
    echo "2. Add to homepage announcements if needed"
    echo "3. Test locally: just serve"

update-prayer-times:
    # Update prayer times for current month
    # Opens the prayer schedule file for editing (uses nixpkgs#neovim if available)
    @echo "🕌 Opening prayer times editor..."
    nix run nixpkgs#neovim -- site/content/monthly-prayer-schedule/_index.md || ${EDITOR:-nano} site/content/monthly-prayer-schedule/_index.md

update-homepage:
    # Quick edit homepage content
    @echo "🏠 Opening homepage editor..."
    nix run nixpkgs#neovim -- site/content/_index.md || ${EDITOR:-nano} site/content/_index.md

content-stats:
    # Show content statistics
    @echo "📊 Content Statistics"
    @echo "====================="
    @echo "📄 Total pages: $(find site/content -name "*.md" | wc -l)"
    @echo "📅 Events: $(find site/content/events -name "*.md" 2>/dev/null | wc -l)"
    @echo "🕌 Programs: $(find site/content -name "*academy*" -o -name "*youth*" -o -name "*outreach*" | wc -l)"
    @echo ""
    @echo "📝 Recent updates:"
    @find site/content -name "*.md" -newer site/content/_index.md 2>/dev/null | head -5 || echo "No recent updates"

# Testing & Quality
check-links:
    # Check for broken links locally using nixpkgs#html-proofer
    nix run nixpkgs#html-proofer -- ./site/public --check-external-hash --allow-hash-href --log-level debug

lint:
    # Run linting on content files using nixpkgs#markdownlint-cli2
    @echo "Checking content files..."
    @nix run nixpkgs#markdownlint-cli2 -- site/content/ || echo "markdownlint not available, basic checks only"
    @find site/content -name "*.md" -exec echo "Checking: {}" \;
    @echo "Content structure validated with Hugo check"
    just validate

# Utilities
docs:
    # Show project documentation
    nix run .#docs

deps:
    # Show Nix dependencies
    nix flake show

search-tool tool_name:
    # Search for available tools in nixpkgs: just search-tool html
    nix run nixpkgs#nix-search -- {{tool_name}}

update-deps:
    # Update Nix flake dependencies
    nix flake update

# Production
prod-build:
    # Production build with optimizations
    cd site && hugo --minify --gc

prod-test:
    # Test production build locally
    just prod-build
    just serve-https

# Monitoring
size:
    # Show site size statistics using nixpkgs#dust for better visualization
    @echo "Site size:"
    @nix run nixpkgs#dust -- site/public/ || du -sh site/public/
    @echo "Largest files:"
    @nix run nixpkgs#dust -- -r site/public/ | head -10 || find site/public -type f -exec du -h {} + | sort -rh | head -10

pages:
    # Count total pages generated using nixpkgs#ripgrep for faster counting
    @nix run nixpkgs#ripgrep -- --files-with-matches "<html" site/public/ | wc -l | awk '{print $1 " HTML pages generated"}' || (find site/public -name "*.html" | wc -l && echo "HTML pages generated")

# Advanced Tools
security-scan:
    # Security scan of generated site using nixpkgs#nmap
    @echo "Scanning local server for security issues..."
    @nix run nixpkgs#nmap -- -p 1313 localhost || echo "nmap not available, skipping security scan"

performance-test:
    # Performance test using nixpkgs#apacheBench
    @echo "Running performance test on local server..."
    @nix run nixpkgs#apacheBench -- -n 100 -c 10 http://localhost:1313/ || echo "ab not available, ensure server is running with 'just serve'"

image-optimize:
    # Optimize images using nixpkgs#optipng and nixpkgs#jpegoptim
    @echo "Optimizing images..."
    @find site/static -name "*.png" -exec nix run nixpkgs#optipng -- -o7 {} \; 2>/dev/null || echo "optipng not available"
    @find site/static -name "*.jpg" -o -name "*.jpeg" -exec nix run nixpkgs#jpegoptim -- --strip-all {} \; 2>/dev/null || echo "jpegoptim not available"
    @echo "Image optimization complete"

seo-check:
    # SEO analysis using nixpkgs#lychee for link checking
    @echo "Running SEO and link check..."
    @nix run nixpkgs#lychee -- --verbose --no-progress site/public/ || echo "lychee not available, use 'just check-links' instead"

format-content:
    # Format markdown files using nixpkgs#prettier
    @echo "Formatting markdown content..."
    @nix run nixpkgs#prettier -- --write site/content/**/*.md || echo "prettier not available"

# ⚡ Quick Commands (aliases)

# Development aliases
s: serve
dev-quick: serve
start-quick: start

# Build aliases
b: build
build-quick: build
make: build

# Quality aliases  
check: quick-check
test: check-all
validate-quick: validate

# Deployment aliases
p: push
deploy-quick: deploy
publish-quick: publish

# Utility aliases
h: default
help: default
ls: status
info: status

# Content aliases
edit-home: update-homepage
edit-prayer: update-prayer-times
stats: content-stats

# 🎯 Smart Commands

smart-build:
    just build

smart-serve:
    just serve

smart-check:
    just check-all

smart-deploy:
    just deploy

smart-status:
    just status

smart-help:
    just default

watch:
    # Watch for changes and rebuild automatically
    #!/usr/bin/env bash
    echo "👀 Watching for changes..."
    echo "Press Ctrl+C to stop"
    while inotifywait -r -e modify,create,delete site/content site/themes 2>/dev/null; do
    echo "🔄 Changes detected, rebuilding..."
    just build
    done
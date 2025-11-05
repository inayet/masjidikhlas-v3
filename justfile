# Masjid Ikhlas V3 - Simple Development Commands
# Run 'just' to see available commands

# Default recipe - show help
default:
    @echo "🕌 Masjid Ikhlas V3 - Website Management"
    @echo ""
    @echo "🚀 Quick Start:"
    @echo "  just start      - Start development server"
    @echo "  just publish    - Build and deploy to GitHub Pages"
    @echo "  just status     - Check project health"
    @echo ""
    @echo "📝 Content:"
    @echo "  just edit-home  - Update homepage content"
    @echo "  just edit-prayer - Update prayer times"
    @echo "  just new-page <name> - Create new page"
    @echo ""
    @echo "🔧 Tools:"
    @echo "  just preview    - Preview production build locally"
    @echo "  just clean      - Clean build files"
    @echo "  just help       - Show this help"

# 🚀 Main Workflows

start:
    # Start local development server
    @echo "🚀 Starting Masjid Ikhlas development server..."
    @echo "📍 Site will be available at: http://localhost:1313"
    @echo "💡 Press Ctrl+C to stop the server"
    @echo ""
    @echo "🔧 Checking system..."
    @if ! command -v hugo >/dev/null 2>&1; then echo "❌ Hugo not found. Run: nix develop"; exit 1; fi
    @echo "✅ System ready"
    @echo ""
    cd site && hugo server --bind 0.0.0.0 --port 1313 --buildDrafts --buildFuture --navigateToChanged

publish:
    # Complete deployment to GitHub Pages
    @echo "📤 Publishing Masjid Ikhlas website..."
    @echo ""
    @echo "🔍 Checking for uncommitted changes..."
    @if [ -n "$(git status --porcelain)" ]; then \
        echo "❌ You have uncommitted changes:"; \
        git status --porcelain; \
        echo ""; \
        echo "Please commit first:"; \
        echo "  git add ."; \
        echo "  git commit -m 'Your message'"; \
        exit 1; \
    fi
    @echo "✅ No uncommitted changes"
    @echo ""
    @echo "🏗️  Building site for GitHub Pages..."
    cd site && hugo --minify --gc --baseURL "https://inayet.github.io/masjidikhlas-v3"
    @echo ""
    @echo "🚀 Deploying to GitHub..."
    git push origin main
    @echo ""
    @echo "🎉 Published successfully!"
    @echo "🌐 Live at: https://inayet.github.io/masjidikhlas-v3"
    @echo "⏱️  Deployment may take 1-2 minutes to update"

preview:
    # Preview production build locally with HTTPS
    @echo "🔍 Building production preview..."
    cd site && hugo --minify --gc
    @echo ""
    @echo "🌐 Starting HTTPS preview server..."
    @echo "📍 Site will be available at: https://localhost:8443"
    @echo "💡 Press Ctrl+C to stop"
    @echo "⚠️  Browser may show security warning (self-signed certificate)"
    nix run .#serve

status:
    # Show comprehensive project status
    @echo "📊 Masjid Ikhlas V3 - Project Status"
    @echo "===================================="
    @echo ""
    @echo "🌐 Git Status:"
    @git status --porcelain --branch
    @echo ""
    @echo "🔧 Environment:"
    @grep "baseURL" site/hugo.toml 2>/dev/null || echo "❌ Configuration not found"
    @echo ""
    @echo "📁 Site Build:"
    @if [ -f "site/public/index.html" ]; then \
        echo "✅ Site built successfully"; \
        echo "📄 Pages: $(find site/public -name "*.html" | wc -l)"; \
        echo "📦 Size: $(du -sh site/public 2>/dev/null | cut -f1)"; \
    else \
        echo "❌ Site not built (run 'just start' or 'just preview')"; \
    fi
    @echo ""
    @echo "📝 Content:"
    @echo "📄 Total pages: $(find site/content -name "*.md" | wc -l)"
    @echo "📅 Events: $(find site/content/events -name "*.md" 2>/dev/null | wc -l)"
    @echo ""
    @echo "🔗 Quick Links:"
    @echo "🏠 Local: http://localhost:1313 (run 'just start')"
    @echo "🌐 Live: https://inayet.github.io/masjidikhlas-v3"

# 📝 Content Management

edit-home:
    # Quick edit homepage content
    @echo "🏠 Opening homepage editor..."
    @echo "📝 Editing: site/content/_index.md"
    @echo "💡 Save and refresh browser to see changes"
    nix run nixpkgs#neovim -- site/content/_index.md || ${EDITOR:-nano} site/content/_index.md

edit-prayer:
    # Update prayer times for current month
    @echo "🕌 Opening prayer times editor..."
    @echo "📝 Editing: site/content/monthly-prayer-schedule/_index.md"
    @echo "💡 Update times for current month"
    nix run nixpkgs#neovim -- site/content/monthly-prayer-schedule/_index.md || ${EDITOR:-nano} site/content/monthly-prayer-schedule/_index.md

new-page name:
    # Create new page with template
    @echo "📄 Creating new page: {{name}}"
    @mkdir -p site/content/{{name}}
    @printf '---\ntitle: "%s"\ndate: %s\ndraft: false\ndescription: "Description for %s"\n---\n\n# %s\n\n## Overview\n\nAdd overview information here.\n\n## Details\n\nAdd detailed information here.\n\n## Resources\n\n- [Resource 1](#)\n- [Resource 2](#)\n' "{{name}}" "$(date +%Y-%m-%d)" "{{name}}" "{{name}}" > site/content/{{name}}/_index.md
    @echo "✅ Created: site/content/{{name}}/_index.md"
    @echo ""
    @echo "📝 Next steps:"
    @echo "1. Edit the page content"
    @echo "2. Add to navigation menu in site/hugo.toml if needed"
    @echo "3. Test locally: just start"

# 🔧 Utilities

clean:
    # Clean build artifacts and temporary files
    @echo "🧹 Cleaning build files..."
    @cd site && rm -rf public/ resources/ .hugo_build.lock
    @echo "✅ Build files cleaned"
    @echo ""
    @echo "💡 Run 'just start' to rebuild and start development"

doctor:
    # Check system health and dependencies
    @echo "🔍 System Health Check"
    @echo "====================="
    @echo "✅ Just: $(just --version 2>/dev/null || echo 'not installed')"
    @echo "✅ Nix: $(nix --version 2>/dev/null || echo 'not installed')"
    @echo "✅ Git: $(git --version 2>/dev/null || echo 'not installed')"
    @echo ""
    @echo "📁 Project Files:"
    @if [ -d "site" ]; then echo "✅ Hugo site exists"; else echo "❌ Hugo site missing"; fi
    @if [ -f "flake.nix" ]; then echo "✅ Nix flake exists"; else echo "❌ Nix flake missing"; fi
    @if [ -f "justfile" ]; then echo "✅ Justfile exists"; else echo "❌ Justfile missing"; fi
    @echo ""
    @echo "🌐 Remote Status:"
    @git remote -v 2>/dev/null || echo "❌ No git remote configured"

help:
    # Show detailed help information
    @echo "🕌 Masjid Ikhlas V3 - Detailed Help"
    @echo "=================================="
    @echo ""
    @echo "🚀 Development Workflow:"
    @echo "1. just start     - Start local development server"
    @echo "2. Edit content   - Use edit-* commands to update content"
    @echo "3. just preview   - Test production build locally"
    @echo "4. just publish  - Deploy to GitHub Pages"
    @echo ""
    @echo "📝 Content Management:"
    @echo "• just edit-home    - Edit homepage content"
    @echo "• just edit-prayer  - Update prayer schedule"
    @echo "• just new-page name - Create new page"
    @echo ""
    @echo "🔧 Maintenance:"
    @echo "• just status      - Check project health"
    @echo "• just clean       - Clean build files"
    @echo "• just doctor      - System health check"
    @echo ""
    @echo "🌐 Deployment:"
    @echo "• Local: http://localhost:1313"
    @echo "• GitHub Pages: https://inayet.github.io/masjidikhlas-v3"
    @echo ""
    @echo "💡 Tips:"
    @echo "• Changes auto-refresh in browser during development"
    @echo "• Git commits are required before publishing"
    @echo "• GitHub Pages auto-deploys on push to main branch"
    @echo "• Use 'just status' to check current project state"

# ⚡ Quick Aliases

s: start
serve: start
dev: start

p: publish
deploy: publish
push: publish

h: help
info: status
check: status

edit: edit-home
prayer: edit-prayer
page: new-page

# 🔍 Advanced Commands (for power users)

build:
    # Build site for production
    @echo "🏗️  Building site..."
    cd site && hugo --minify --gc
    @echo "✅ Build complete"

logs:
    # Show recent git history
    @echo "📜 Recent Changes:"
    @git log --oneline -10
    @echo ""
    @echo "🌐 Remote Status:"
    @git status --porcelain --branch

sync:
    # Pull latest changes and rebuild
    @echo "🔄 Syncing with remote..."
    git pull origin main
    @echo "✅ Sync complete"
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
    @echo "📝 Edit Pages:"
    @echo "  just edit-home      - Update homepage"
    @echo "  just edit-about     - Edit About Us page"
    @echo "  just edit-contact   - Edit Contact page"
    @echo "  just edit-donate    - Edit Donation page"
    @echo "  just edit-events    - Edit Events page"
    @echo "  just edit-academy  - Edit Academy page"
    @echo "  just edit-youth     - Edit Youth Department"
    @echo "  just edit-outreach  - Edit Outreach page"
    @echo "  just edit-services  - Edit Services page"
    @echo "  just edit-prayer    - Update prayer times"
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
    @echo "🔧 Setting up environment..."
    @if ! command -v hugo >/dev/null 2>&1; then \
        echo "📦 Entering Nix development environment..."; \
        nix develop -c "cd site && hugo server --bind 0.0.0.0 --port 1313 --buildDrafts --buildFuture --navigateToChanged --baseURL http://localhost:1313"; \
        exit 0; \
    fi
    @echo "✅ Hugo ready"
    @echo ""
    cd site && hugo server --bind 0.0.0.0 --port 1313 --buildDrafts --buildFuture --navigateToChanged --baseURL http://localhost:1313

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
    @echo "🔧 Building site for deployment..."
    @if ! command -v hugo >/dev/null 2>&1; then \
        nix develop -c "cd site && hugo --minify --gc"; \
    else \
        cd site && hugo --minify --gc; \
    fi
    @echo ""
    @echo "🚀 Deploying to remote..."
    git push origin main
    @echo ""
    @echo "🎉 Published successfully!"
    @echo "🌐 Repository: $(git remote get-url origin 2>/dev/null || echo 'Not configured')"
    @echo "⏱️  Deployment may take 1-2 minutes to update"

preview:
    # Preview production build locally with HTTPS
    @echo "🔍 Building production preview..."
    @if ! command -v hugo >/dev/null 2>&1; then \
        nix develop -c cd site && hugo --minify --gc; \
    else \
        cd site && hugo --minify --gc; \
    fi
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
    @echo "🌐 Repository:"
    @git remote get-url origin 2>/dev/null || echo "  ⚠️  No remote configured"

# 📝 Content Management

edit-home:
    # Quick edit homepage content
    @echo "🏠 Opening homepage editor..."
    @echo "📝 Editing: site/content/_index.md"
    @echo "💡 Save file, then run 'just start' to see changes"
    @echo "🔄 Auto-refresh: Changes appear in browser automatically"
    nix run nixpkgs#neovim -- site/content/_index.md || ${EDITOR:-nano} site/content/_index.md

edit-about:
    # Edit About Us page
    @echo "📖 Opening About Us editor..."
    @echo "📝 Editing: site/content/about/_index.md"
    @echo "💡 Update masjid information, history, and mission"
    nix run nixpkgs#neovim -- site/content/about/_index.md || ${EDITOR:-nano} site/content/about/_index.md

edit-contact:
    # Edit Contact page
    @echo "📞 Opening Contact editor..."
    @echo "📝 Editing: site/content/contact/_index.md"
    @echo "💡 Update address, phone, email, and office hours"
    nix run nixpkgs#neovim -- site/content/contact/_index.md || ${EDITOR:-nano} site/content/contact/_index.md

edit-donate:
    # Edit Donation page
    @echo "💝 Opening Donation editor..."
    @echo "📝 Editing: site/content/donate/_index.md"
    @echo "💡 Update donation methods, campaigns, and zakat information"
    nix run nixpkgs#neovim -- site/content/donate/_index.md || ${EDITOR:-nano} site/content/donate/_index.md

edit-events:
    # Edit Events page
    @echo "📅 Opening Events editor..."
    @echo "📝 Editing: site/content/events/_index.md"
    @echo "💡 Update regular programs and special events"
    nix run nixpkgs#neovim -- site/content/events/_index.md || ${EDITOR:-nano} site/content/events/_index.md

edit-academy:
    # Edit Ikhlas Academy page
    @echo "🎓 Opening Academy editor..."
    @echo "📝 Editing: site/content/ikhlas-academy/_index.md"
    @echo "💡 Update educational programs and class schedules"
    nix run nixpkgs#neovim -- site/content/ikhlas-academy/_index.md || ${EDITOR:-nano} site/content/ikhlas-academy/_index.md

edit-youth:
    # Edit Youth Department page
    @echo "👥 Opening Youth Department editor..."
    @echo "📝 Editing: site/content/ikhlas-youth-department/_index.md"
    @echo "💡 Update youth programs, activities, and schedules"
    nix run nixpkgs#neovim -- site/content/ikhlas-youth-department/_index.md || ${EDITOR:-nano} site/content/ikhlas-youth-department/_index.md

edit-outreach:
    # Edit Outreach Department page
    @echo "🤝 Opening Outreach editor..."
    @echo "📝 Editing: site/content/outreach-department/_index.md"
    @echo "💡 Update community programs and interfaith activities"
    nix run nixpkgs#neovim -- site/content/outreach-department/_index.md || ${EDITOR:-nano} site/content/outreach-department/_index.md

edit-services:
    # Edit Services page
    @echo "🛎️  Opening Services editor..."
    @echo "📝 Editing: site/content/services/_index.md"
    @echo "💡 Update masjid services and facilities"
    nix run nixpkgs#neovim -- site/content/services/_index.md || ${EDITOR:-nano} site/content/services/_index.md

edit-prayer:
    # Update prayer times for current month
    @echo "🕌 Opening prayer times editor..."
    @echo "📝 Editing: site/content/monthly-prayer-schedule/_index.md"
    @echo "💡 Update prayer times for current month"
    nix run nixpkgs#neovim -- site/content/monthly-prayer-schedule/_index.md || ${EDITOR:-nano} site/content/monthly-prayer-schedule/_index.md

new-page name:
    # Create new page with template
    @echo "📄 Creating new page: {{name}}"
    @mkdir -p site/content/{{name}}
    @echo '---' > site/content/{{name}}/_index.md
    @echo 'title: "{{name}}"' >> site/content/{{name}}/_index.md
    @echo "date: $(date +%Y-%m-%d)" >> site/content/{{name}}/_index.md
    @echo 'draft: false' >> site/content/{{name}}/_index.md
    @echo 'description: "Description for {{name}}"' >> site/content/{{name}}/_index.md
    @echo '---' >> site/content/{{name}}/_index.md
    @echo '' >> site/content/{{name}}/_index.md
    @echo '# {{name}}' >> site/content/{{name}}/_index.md
    @echo '' >> site/content/{{name}}/_index.md
    @echo '## Overview' >> site/content/{{name}}/_index.md
    @echo '' >> site/content/{{name}}/_index.md
    @echo 'Add overview information here.' >> site/content/{{name}}/_index.md
    @echo '' >> site/content/{{name}}/_index.md
    @echo '## Details' >> site/content/{{name}}/_index.md
    @echo '' >> site/content/{{name}}/_index.md
    @echo 'Add detailed information here.' >> site/content/{{name}}/_index.md
    @echo '' >> site/content/{{name}}/_index.md
    @echo '## Resources' >> site/content/{{name}}/_index.md
    @echo '' >> site/content/{{name}}/_index.md
    @echo '- [Resource 1](#)' >> site/content/{{name}}/_index.md
    @echo '- [Resource 2](#)' >> site/content/{{name}}/_index.md
    @echo "✅ Created: site/content/{{name}}/_index.md"
    @echo ""
    @echo "📝 Next steps:"
    @echo "1. Edit page content"
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
    @echo "4. just publish  - Deploy to your repository"
    @echo ""
    @echo "📝 Content Management:"
    @echo "• just edit-home      - Edit homepage content"
    @echo "• just edit-about     - Edit About Us page"
    @echo "• just edit-contact   - Edit Contact page"
    @echo "• just edit-donate    - Edit Donation page"
    @echo "• just edit-events    - Edit Events page"
    @echo "• just edit-academy  - Edit Academy page"
    @echo "• just edit-youth     - Edit Youth Department"
    @echo "• just edit-outreach  - Edit Outreach page"
    @echo "• just edit-services  - Edit Services page"
    @echo "• just edit-prayer    - Update prayer schedule"
    @echo "• just new-page name   - Create new page"
    @echo ""
    @echo "🔧 Maintenance:"
    @echo "• just status      - Check project health"
    @echo "• just clean       - Clean build files"
    @echo "• just doctor      - System health check"
    @echo ""
    @echo "🌐 Deployment:"
    @echo "• Local: http://localhost:1313"
    @echo "• Local: http://localhost:1313"
    @echo "• Repository: $(git remote get-url origin 2>/dev/null || echo 'Not configured')"
    @echo ""
    @echo "💡 Tips:"
    @echo "• Changes auto-refresh in browser during development"
    @echo "• Git commits are required before publishing"
    @echo "• GitHub Pages auto-deploys on push to main branch"
    @echo "• Use 'just status' to check current project state"
    @echo "• Commands automatically detect your repository settings"
    @echo ""
    @echo "🔄 Typical Workflow:"
    @echo "1. just start           # Start development server"
    @echo "2. just edit-*          # Edit content (auto-refreshes)"
    @echo "3. just preview         # Test production build"
    @echo "4. just publish         # Deploy to GitHub Pages"

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

# Page editing aliases
edit: edit-home
home: edit-home
about: edit-about
contact: edit-contact
donate: edit-donate
events: edit-events
academy: edit-academy
youth: edit-youth
outreach: edit-outreach
services: edit-services
prayer: edit-prayer

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
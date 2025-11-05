# Masjid Ikhlas V3 - Website Management Commands

default:
    # Show available commands
    @echo "🕌 Masjid Ikhlas V3 Commands:"
    @echo "  start       - Start development server"
    @echo "  publish     - Build and deploy to GitHub Pages"
    @echo "  edit-*      - Edit content pages"
    @echo "  new-page    - Create new page"
    @echo "  preview     - Preview production build"
    @echo "  status      - Check project health"
    @echo "  test        - Run test suite"
    @echo "  clean       - Clean build files"
    @echo "  help        - Show detailed help"

# 🚀 Main Workflows

start:
    # Start local development server (always in Nix environment)
    @echo "🚀 Starting Masjid Ikhlas development server..."
    @echo "📍 Site will be available at: http://localhost:1313"
    @echo "💡 Press Ctrl+C to stop the server"
    @echo ""
    @echo "📦 Starting Hugo server..."
    nix develop -c bash -c 'cd "$(git rev-parse --show-toplevel)" && source scripts/set-env.sh && cd site && hugo server --bind 0.0.0.0 --port 1313 --buildDrafts --buildFuture --navigateToChanged --disableFastRender'

publish:
    # Complete deployment to GitHub Pages (always in Nix environment)
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
    @echo "📦 Building site in Nix development environment..."
    nix develop -c bash -c 'cd "$(git rev-parse --show-toplevel)" && source scripts/set-env.sh && cd site && hugo --minify --gc'
    @echo ""
    @echo "🚀 Deploying to remote..."
    git push origin main
    @echo ""
    @echo "🎉 Published successfully!"
    @echo "🌐 Repository: $(git remote get-url origin 2>/dev/null || echo 'Not configured')"
    @echo "🌐 Live Site: https://$(git config --get remote.origin.url | sed -n 's|.*github.com[:/]\([^/]*\)/\(.*\)\.git|\1.github.io/\2|p')/"
    @echo "⏱️  Deployment may take 1-2 minutes to update"

preview:
    @echo "🔍 Building production preview..."
    @echo "📦 Building in Nix development environment..."
    nix develop -c bash -c 'cd "$(git rev-parse --show-toplevel)" && source scripts/set-env.sh && cd site && hugo --minify --gc'
    @echo ""
    @echo "🌐 Starting HTTP preview server..."
    @echo "📍 Site will be available at: http://localhost:8080"
    @echo "💡 Press Ctrl+C to stop"
    nix develop -c bash -c 'cd "$(git rev-parse --show-toplevel)/site" && hugo server --port 8080 --bind 0.0.0.0 --disableFastRender --baseURL http://localhost:8080/'

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
    #!/usr/bin/env bash
    echo "🏠 Opening homepage editor..."
    echo "📝 Editing: site/content/_index.md"
    echo "💡 Save file, then run 'just start' to see changes"
    echo "🔄 Auto-refresh: Changes appear in browser automatically"
    echo "📝 Using editor: ${EDITOR:-code --wait}"
    nix develop -c bash -c '"${EDITOR:-code --wait}" "site/content/_index.md"'

edit-about:
    # Edit About Us page
    #!/usr/bin/env bash
    echo "📖 Opening About Us editor..."
    echo "📝 Editing: site/content/about/_index.md"
    echo "💡 Update masjid information, history, and mission"
    echo "📝 Using editor: ${EDITOR:-code --wait}"
    nix develop -c bash -c '"${EDITOR:-code --wait}" "site/content/about/_index.md"'

edit-contact:
    # Edit Contact page
    #!/usr/bin/env bash
    echo "📞 Opening Contact editor..."
    echo "📝 Editing: site/content/contact/_index.md"
    echo "💡 Update address, phone, email, and office hours"
    echo "📝 Using editor: ${EDITOR:-code --wait}"
    nix develop -c bash -c '"${EDITOR:-code --wait}" "site/content/contact/_index.md"'

edit-donate:
    # Edit Donation page
    #!/usr/bin/env bash
    echo "💝 Opening Donation editor..."
    echo "📝 Editing: site/content/donate/_index.md"
    echo "💡 Update donation methods, campaigns, and zakat information"
    echo "📝 Using editor: ${EDITOR:-code --wait}"
    nix develop -c bash -c '"${EDITOR:-code --wait}" "site/content/donate/_index.md"'

edit-events:
    # Edit Events page
    #!/usr/bin/env bash
    echo "📅 Opening Events editor..."
    echo "📝 Editing: site/content/events/_index.md"
    echo "💡 Update regular programs and special events"
    echo "📝 Using editor: ${EDITOR:-code --wait}"
    nix develop -c bash -c '"${EDITOR:-code --wait}" "site/content/events/_index.md"'

edit-academy:
    # Edit Ikhlas Academy page
    #!/usr/bin/env bash
    echo "🎓 Opening Academy editor..."
    echo "📝 Editing: site/content/ikhlas-academy/_index.md"
    echo "💡 Update educational programs and class schedules"
    echo "📝 Using editor: ${EDITOR:-code --wait}"
    nix develop -c bash -c '"${EDITOR:-code --wait}" "site/content/ikhlas-academy/_index.md"'

edit-youth:
    # Edit Youth Department page
    #!/usr/bin/env bash
    echo "👥 Opening Youth Department editor..."
    echo "📝 Editing: site/content/ikhlas-youth-department/_index.md"
    echo "💡 Update youth programs, activities, and schedules"
    echo "📝 Using editor: ${EDITOR:-code --wait}"
    nix develop -c bash -c '"${EDITOR:-code --wait}" "site/content/ikhlas-youth-department/_index.md"'

edit-outreach:
    # Edit Outreach Department page
    #!/usr/bin/env bash
    echo "🤝 Opening Outreach editor..."
    echo "📝 Editing: site/content/outreach-department/_index.md"
    echo "💡 Update community programs and interfaith activities"
    echo "📝 Using editor: ${EDITOR:-code --wait}"
    nix develop -c bash -c '"${EDITOR:-code --wait}" "site/content/outreach-department/_index.md"'

edit-services:
    # Edit Services page
    #!/usr/bin/env bash
    echo "🛎️  Opening Services editor..."
    echo "📝 Editing: site/content/services/_index.md"
    echo "💡 Update masjid services and facilities"
    echo "📝 Using editor: ${EDITOR:-code --wait}"
    nix develop -c bash -c '"${EDITOR:-code --wait}" "site/content/services/_index.md"'

edit-prayer:
    # Update prayer times for current month
    #!/usr/bin/env bash
    echo "🕌 Opening prayer times editor..."
    echo "📝 Editing: site/content/monthly-prayer-schedule/_index.md"
    echo "💡 Update prayer times for current month"
    echo "📝 Using editor: ${EDITOR:-code --wait}"
    nix develop -c bash -c '"${EDITOR:-code --wait}" "site/content/monthly-prayer-schedule/_index.md"'

new-page name:
    # Create new page with template
    #!/usr/bin/env bash
    set -euo pipefail
    [[ ! -f "justfile" ]] && echo "❌ Error: Run from project root directory" && exit 1
    echo "📄 Creating new page: {{name}}"
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
    echo "1. Edit page content"
    echo "2. Add to navigation menu in site/hugo.toml if needed"
    echo "3. Test locally: just start"

# 🔧 Utilities

clean:
    # Clean build artifacts and temporary files
    @echo "🧹 Cleaning build files..."
    nix develop -c bash -c 'cd "$(git rev-parse --show-toplevel)/site" && rm -rf public/ resources/ .hugo_build.lock'
    @echo "✅ Build files cleaned"
    @echo ""
    @echo "💡 Run 'just start' to rebuild and start development"

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
    @echo "• just test        - Run comprehensive test suite"
    @echo "• just test-build  - Run build tests only"
    @echo "• just test-content- Run content validation only"
    @echo "• just test-quick  - Run quick validation"
    @echo "• just clean       - Clean build files"
    @echo "• just doctor      - System health check"
    @echo ""
    @echo "🌐 Deployment:"
    @echo "• Local: http://localhost:1313"
    @echo "• Repository: $(git remote get-url origin 2>/dev/null || echo 'Not configured')"
    @echo ""
    @echo "💡 Tips:"
    @echo "• All commands run in Nix development environment"
    @echo "• Uses your EDITOR environment variable (falls back to code --wait)"
    @echo "• Changes auto-refresh in browser during development"
    @echo "• Git commits are required before publishing"
    @echo "• GitHub Pages auto-deploys on push to main branch"
    @echo ""
    @echo "🔄 Typical Workflow:"
    @echo "1. just start           # Start development server"
    @echo "2. just edit-*          # Edit content (auto-refreshes)"
    @echo "3. just test-quick      # Quick validation"
    @echo "4. just preview         # Test production build"
    @echo "5. just test           # Full test suite"
    @echo "6. just publish         # Deploy to GitHub Pages"

# Quick Aliases (hidden from --list)

[private]
s: start
[private]
serve: start
[private]
dev: start

[private]
p: publish
[private]
deploy: publish
[private]
push: publish

[private]
h: help
[private]
info: status
[private]
check: status
[private]
t: test
[private]
tb: test-build
[private]
tc: test-content
[private]
tq: test-quick

[private]
test:
    # Run comprehensive test suite
    @echo "🧪 Running comprehensive test suite..."
    @if [ -f "scripts/run-tests.sh" ]; then \
        ./scripts/run-tests.sh; \
    else \
        echo "❌ Test scripts not found in scripts/ directory"; \
        exit 1; \
    fi

[private]
test-build:
    # Run build tests only
    @echo "🏗️  Running build tests..."
    @if [ -f "scripts/test-build.sh" ]; then \
        ./scripts/test-build.sh; \
    else \
        echo "❌ Build test script not found"; \
        exit 1; \
    fi

[private]
test-content:
    # Run content validation only
    @echo "📝 Running content validation..."
    @if [ -f "scripts/validate-content.sh" ]; then \
        ./scripts/validate-content.sh; \
    else \
        echo "❌ Content validation script not found"; \
        exit 1; \
    fi

[private]
test-quick:
    # Run quick validation
    @echo "⚡ Running quick validation..."
    @if [ -f "scripts/test-build-simple.sh" ]; then \
        ./scripts/test-build-simple.sh; \
    else \
        echo "❌ Quick test script not found"; \
        exit 1; \
    fi

[private]
edit: edit-home
[private]
home: edit-home
[private]
about: edit-about
[private]
contact: edit-contact
[private]
donate: edit-donate
[private]
events: edit-events
[private]
academy: edit-academy
[private]
youth: edit-youth
[private]
outreach: edit-outreach
[private]
services: edit-services
[private]
prayer: edit-prayer

# Advanced Commands (hidden from --list)

[private]
build:
    # Build site for production
    @echo "🏗️  Building site..."
    cd site && nix shell nixpkgs#hugo --command bash -c 'hugo --minify --gc'
    @echo "✅ Build complete"

[private]
logs:
    # Show recent git history
    @echo "📜 Recent Changes:"
    @git log --oneline -10
    @echo ""
    @echo "🌐 Remote Status:"
    @git status --porcelain --branch

[private]
sync:
    # Pull latest changes and rebuild
    @echo "🔄 Syncing with remote..."
    git pull origin main
    @echo "✅ Sync complete"

[private]
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
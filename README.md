# Masjid Ikhlas V3 - Metropolitan Denver North Islamic Center

A modern, static website for Masjid Ikhlas, built with Hugo and deployed via Nix for reproducible builds.

## 🕌 About

Masjid Ikhlas is committed to Islamic way of life based on Qur'an and life example of Prophet Muhammad (Peace be upon him). We serve as a center for religious development, social, educational, economic, and cultural enrichment in the Metropolitan Denver North area.

**Address:** 11141 N Irma Drive, Northglenn, CO 80233, USA  
**Phone:** 303-920-0252  
**Email:** office@masjidikhlas.org

## 🚀 Quick Start

### Development Environment
```bash
# Enter development environment
nix develop

# Start local development server
hugo server --bind 0.0.0.0 --port 1313
```

### Production Build & Deploy
```bash
# Build and validate site
nix run .#workflow

# Start local HTTPS server (for testing)
nix run .#serve

# Deploy to Netlify
nix run .#deployNetlify -- /path/to/build/output

# Deploy to GitHub Pages
nix run .#deployGitHub -- /path/to/build/output
```

## 📁 Project Structure

```
masjidikhlasV3/
├── flake.nix              # Nix configuration & build scripts
├── flake.lock             # Nix dependency lock file
├── justfile              # Task runner commands
├── .gitconfig            # Project-specific git aliases
├── site/                  # Hugo site source
│   ├── hugo.toml         # Site configuration
│   ├── content/           # Markdown content
│   ├── public/           # Generated site (gitignored)
│   └── themes/ikhlas/    # Custom theme
│       ├── layouts/      # HTML templates
│       └── static/       # CSS, JS, images
├── content/               # Additional content (merged during build)
├── .github/workflows/     # GitHub Actions
│   └── deploy.yml        # Auto-deployment to GitHub Pages
├── README.md             # This file
├── AGENTS.md             # Development guidelines for AI agents
├── DEVELOPMENT.md        # Detailed development setup
└── DEPLOYMENT.md         # Deployment instructions
```

## 🎨 Theme Features

- **Responsive Design:** Mobile-first, works on all devices
- **Modern CSS:** Custom properties, grid layouts, animations
- **SEO Optimized:** Meta tags, structured data, semantic HTML
- **Accessibility:** ARIA labels, keyboard navigation, screen reader support
- **Performance:** Minified assets, optimized images, fast loading

## 📄 Content Sections

- **Home:** Welcome message, prayer times, announcements
- **About Us:** History, mission, leadership, facilities
- **Prayer Schedule:** Monthly prayer times, Jumu'ah schedule
- **Programs:** Educational programs, youth activities, outreach
- **Donate:** Donation options, Zakat information, fundraising
- **Contact:** Contact form, directions, social media links

## 🛠️ Development Commands

### Testing & Validation
```bash
# Comprehensive testing
./scripts/run-tests.sh              # Run all tests with reporting
./scripts/test-build.sh             # Build process validation
./scripts/validate-content.sh        # Content quality checks
./scripts/test-build-simple.sh       # Quick validation

# Quick validation before deployment
./scripts/test-build-simple.sh && ./scripts/validate-content.sh
```

### Using Justfile (Recommended)
Install `just` and run `just` to see all available commands.

#### 🚀 Quick Start Workflow
```bash
# Start development (health check + server)
just start

# Complete publishing workflow (validate → build → deploy)
just publish

# Check system health
just doctor

# Smart command (detects intent)
just smart build    # or just smart serve, check, deploy, status
```

#### 📝 Content Management
```bash
# Create new content
just new-page events
just new-event ramadan-2025

# Quick editing
just update-homepage
just update-prayer-times

# Content statistics
just content-stats
```

#### 🔍 Quality Assurance
```bash
# Comprehensive checks
just check-all      # All quality checks
just quick-check    # Fast validation only

# Individual checks
just lint            # Lint content
just check-links     # Check broken links
just seo-check       # SEO analysis
just performance-test # Performance testing

# Script-based testing
./scripts/run-tests.sh              # Full test suite
./scripts/test-build.sh             # Build validation
./scripts/validate-content.sh        # Content validation
```

#### 🌐 Development & Deployment
```bash
# Development servers
just serve           # HTTP server (localhost:1313)
just serve-https     # HTTPS server (localhost:8443)
just preview         # Production preview with HTTPS

# Building
just build           # Build site
just prod-build      # Production build with optimizations
just workflow        # Full Nix workflow

# Deployment
just deploy          # Build and deploy
just push            # Push to GitHub
just sync            # Pull and rebuild

# Script-based deployment
./scripts/test-build-simple.sh && git push origin main
```

#### ⚡ Quick Aliases
```bash
just s               # serve
just b               # build
just p               # push
just check           # quick-check
just stats           # content-stats
just help            # show help
```

#### 🔧 Utilities
```bash
just status          # Project status overview
just doctor          # System health check
just size            # Site size analysis
just pages           # Page count
just search-tool <name> # Search nixpkgs packages
just watch           # Watch for changes and auto-rebuild
```

### Direct Nix Commands
| Command | Description |
|---------|-------------|
| `nix develop` | Enter development environment |
| `nix run .#serve` | Start local HTTPS server on https://localhost:8443 |
| `nix run .#workflow` | Build and validate site |
| `nix run .#site` | Build static site only |
| `nix run .#docs` | Show project documentation |

### Git Aliases
Project-specific git aliases are configured automatically:

```bash
git serve           # Start Hugo server
git build           # Build site with minification
git workflow        # Run Nix workflow
git deploy          # Push to GitHub
git new-page <name> # Create new page
git edit-prayer     # Edit prayer times
git check           # Validate content
git lint            # Lint content
git count-pages     # Count generated pages
git site-size       # Show site size
```

## 🌐 Deployment

### Automated GitHub Pages (Current)
- **Repository:** https://github.com/inayet/masjidikhlas-v3
- **Live Site:** https://inayet.github.io/masjidikhlas-v3/
- **Automatic:** Deployed on push to main branch via GitHub Actions

### Deployment Commands
```bash
# Quick deployment (build + push)
just deploy

# Or step by step
just build
just push

# Using git aliases
git quick-deploy
```

### Manual Deployment Options
```bash
# Build to local directory
just prod-build
# Output available in site/public/

# Export to custom directory
hugo --destination /path/to/output
```

### Production Domain Setup
To deploy to masjidikhlas.org:
1. Configure DNS CNAME to point to GitHub Pages
2. Add custom domain in GitHub repository settings
3. SSL certificate automatically provisioned by GitHub Pages

## 🔧 Configuration

### Site Settings (site/hugo.toml)
- `baseURL`: Production URL (https://masjidikhlas.org)
- `title`: Site title
- `params`: Contact info, social media links

### Theme Customization
- CSS: `site/themes/ikhlas/static/css/style.css`
- JavaScript: `site/themes/ikhlas/static/js/script.js`
- Layouts: `site/themes/ikhlas/layouts/`

## 📱 Content Management

### Quick Content Commands
```bash
# Create new page with template
just new-page events
git new-page announcements

# Update prayer times
just update-prayer-times
git edit-prayer

# Format content
just format-content
```

### Manual Content Management
1. Create markdown file in `site/content/` directory
2. Add front matter with title, date, draft status
3. Update menu in `site/hugo.toml` if needed

### Content Structure
```
site/content/
├── _index.md                    # Homepage
├── about/_index.md             # About page
├── contact/_index.md           # Contact information
├── donate/_index.md            # Donation options
├── monthly-prayer-schedule/    # Prayer times
├── services/_index.md          # Services overview
├── ikhlas-academy/_index.md    # Educational programs
├── outreach-department/_index.md # Outreach programs
└── ikhlas-youth-department/_index.md # Youth activities
```

### Front Matter Template
```yaml
---
title: "Page Title"
date: 2025-01-01
draft: false
---

# Page Title

Content goes here...
```

## 🎯 SEO & Performance

### Built-in Optimizations
- **Meta Tags:** Open Graph, Twitter Cards, structured data
- **Performance:** Minified CSS/JS, optimized images
- **Security:** HTTPS headers, CSP policies
- **Accessibility:** WCAG 2.1 AA compliance

### Quality Assurance Commands
```bash
# Link validation
just check-links      # Uses nixpkgs#html-proofer

# SEO analysis
just seo-check        # Uses nixpkgs#lychee

# Performance testing
just performance-test # Uses nixpkgs#apacheBench

# Content linting
just lint             # Uses nixpkgs#markdownlint-cli2

# Image optimization
just image-optimize   # Uses nixpkgs#optipng, nixpkgs#jpegoptim

# Security scanning
just security-scan    # Uses nixpkgs#nmap
```

### Site Statistics
```bash
just size             # Site size analysis
just pages            # Page count
git site-size         # Alternative size command
git count-pages       # Alternative page count
```

## 🤝 Contributing

### Streamlined Development Workflow

#### 🚀 For New Contributors
```bash
# 1. Quick health check and start development
just start

# 2. Make changes to content or theme
# Edit files in site/content/ or site/themes/

# 3. Quality checks (automated)
just check-all

# 4. Deploy when ready
just publish
```

#### ⚡ For Experienced Contributors
```bash
# Smart workflow - detects what you need
just smart serve     # Start development
just smart build     # Build site
just smart check     # Run checks
just smart deploy    # Deploy site

# Or use quick aliases
just s               # Start server
just b               # Build
just check           # Quick validation
just p               # Push/deploy
```

#### 📝 Content Updates
```bash
# Create new content
just new-page announcements
just new-event community-fundraiser

# Quick edits
just update-homepage
just update-prayer-times

# Check content status
just content-stats
```

#### 🔍 Quality Assurance Integration
```bash
# Before committing
just quick-check     # Fast validation

# Before deploying
just check-all       # Comprehensive checks

# Continuous monitoring
just watch           # Auto-rebuild on changes
```

### Pre-commit Checklist
```bash
# Automated pre-commit check
./scripts/run-tests.sh              # Runs all tests automatically

# Or manual checklist:
- [ ] Content validates: `./scripts/validate-content.sh`
- [ ] Build works: `./scripts/test-build.sh`
- [ ] Quick validation: `./scripts/test-build-simple.sh`
- [ ] No broken links: `just check-links`
- [ ] Images optimized: `just image-optimize`
- [ ] SEO checks pass: `just seo-check`
- [ ] Site builds: `just build`
- [ ] Local testing: `just serve`
```

### Smart Development Tips
```bash
# Use smart command for context-aware actions
just smart          # Detects what you probably want to do

# Watch mode for continuous development
just watch          # Auto-rebuilds on file changes

# Quick status overview
just status         # Shows git, build, and site status

# Health check if something seems wrong
just doctor         # System and project health
```

### Code Style
- Use 2-space indentation for YAML front matter
- Follow semantic HTML5 structure
- Keep content under 80 characters per line when possible
- Use descriptive alt text for images
- Include proper meta descriptions for pages

## 📞 Support

### Documentation
- **AGENTS.md:** Development guidelines for AI agents
- **DEVELOPMENT.md:** Detailed development setup
- **justfile:** All available commands (run `just`)
- **Git aliases:** Project-specific shortcuts (run `git config --list | grep alias`)

### Troubleshooting
```bash
# Check environment
just deps             # Show Nix dependencies
nix flake show        # Show all flake outputs

# Search for tools
just search-tool html-proofer  # Find available packages

# Run tests for debugging
./scripts/run-tests.sh              # Full test suite
./scripts/test-build.sh             # Build issues
./scripts/validate-content.sh        # Content issues

# Common issues
just clean            # Clean build artifacts
just validate         # Check content structure
just check-links      # Find broken links
```

### Getting Help
1. Check this README and documentation files
2. Run `just` to see all available commands
3. Test locally before deployment
4. Review GitHub Actions logs for deployment issues

## 📄 License

This project is maintained by Masjid Ikhlas for community use.

---

*"Faith in Allah, Simple Living, Hard Work & High Thinking."*
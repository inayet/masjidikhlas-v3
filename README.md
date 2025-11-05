# 🕌 Masjid/Community Website Template

> **A modern, static website template for mosques, community centers, and nonprofit organizations**  
> Built with Hugo and deployed via Nix for reproducible builds. Customize for any organization!

---

## 📋 Table of Contents

- [🚀 Quick Start](#-quick-start)
- [📁 Project Structure](#-project-structure)
- [🛠️ Development](#️-development)
- [🧪 Testing](#-testing)
- [🌐 Deployment](#-deployment)
- [📚 Documentation](#-documentation)
- [🎯 Features](#-features)
- [🔧 Configuration](#-configuration)
- [🤝 Contributing](#-contributing)
- [📞 Support](#-support)

---

## 🚀 Quick Start

### 🎯 For New Organizations (Recommended)
Get your customized website in 3 simple steps:

```bash
# 1. Clone and customize for your organization
git clone https://github.com/inayet/masjidikhlas-v3.git your-website
cd your-website
./scripts/setup.sh

# 2. Start development server
just start

# 3. Deploy to GitHub Pages
just deploy
```

**🔧 Setup Script Features:**
- Interactive prompts for organization information
- Automatic configuration of Hugo settings
- Updates GitHub Actions for automatic deployment
- Customizes content files with your organization details
- Updates documentation and contact information

### ⚡ Quick Start for Development
If you want to test the template without customization:

```bash
# 1. Clone and enter development environment
git clone https://github.com/inayet/masjidikhlas-v3.git
cd masjidikhlas-v3
nix develop

# 2. Start development server
just start

# 3. Make changes and deploy
just deploy
```

### ⚡ Quick Commands
```bash
just help              # Show all available commands
just start             # Start development server
just preview           # Production preview with HTTPS
just build             # Build site
just test              # Run test suite
just deploy            # Build and deploy
just status            # Project status
just doctor            # System health check
```

### 🔧 Using Nix Commands
```bash
nix develop            # Enter development environment
nix run .#serve       # HTTPS server (localhost:8443)
nix run .#workflow    # Build and validate
nix run .#site        # Static site build
nix run .#docs        # Show documentation
```

---

## 📁 Project Structure

```
masjidikhlasV3/
├── 📄 README.md                    # This file - Main project documentation
├── 📄 AGENTS.md                    # AI agent development guidelines
├── 📄 DEVELOPMENT.md               # Detailed development setup
├── 📄 TESTING.md                   # Testing framework and procedures
├── 📄 DEPLOYMENT.md                # Deployment instructions and options
├── 📄 DEPLOYMENT_SUMMARY.md        # Current deployment status
├── 📄 ORGANIZATION_SUMMARY.md      # Project organization overview
├── 🔧 flake.nix                   # Nix configuration & build scripts
├── 🔧 flake.lock                  # Nix dependency lock file
├── 🔧 justfile                     # Task runner commands
├── 🔧 .gitconfig                  # Project-specific git aliases
├── 📂 scripts/                    # Testing and validation scripts
│   ├── 📄 README.md               # Script documentation
│   ├── 📄 run-tests.sh            # Comprehensive test suite
│   ├── 📄 test-build.sh           # Build process validation
│   ├── 📄 test-build-simple.sh     # Quick build validation
│   └── 📄 validate-content.sh     # Content quality validation
├── 📂 site/                       # Hugo site source
│   ├── 🔧 hugo.toml               # Hugo configuration
│   ├── 📂 content/                # Markdown content
│   ├── 📂 public/                 # Generated site (gitignored)
│   └── 📂 themes/ikhlas/          # Custom theme
│       ├── 📂 layouts/             # HTML templates
│       └── 📂 static/              # CSS, JS, images
├── 📂 content/                    # Additional content (merged during build)
└── 📂 .github/workflows/           # GitHub Actions
    └── 📄 deploy.yml              # Auto-deployment to GitHub Pages
```

---

## 🛠️ Development

### 🎯 Development Workflow

#### For New Contributors
1. **Setup**: `just start` (health check + server)
2. **Develop**: Edit content in `site/content/` or theme in `site/themes/`
3. **Validate**: `just quick-check` (fast validation)
4. **Test**: `just test` (comprehensive testing)
5. **Deploy**: `just deploy` (build + push)

#### For Experienced Contributors
1. **Smart Workflow**: `just smart` (context-aware actions)
2. **Quick Commands**: `just s`, `just b`, `just check`, `just p`
3. **Watch Mode**: `just watch` (auto-rebuild on changes)
4. **Status Check**: `just status` (project overview)

### 📝 Content Management

#### Creating New Content
```bash
# Create new pages
just new-page events
just new-event ramadan-2025

# Quick editing
just update-homepage
just update-prayer-times

# Content statistics
just content-stats
```

#### Manual Content Management
- Create markdown file in `site/content/` directory
- Add front matter with title, date, draft status
- Update menu in `site/hugo.toml` if needed

### 🎨 Theme Customization

#### CSS & Styling
- **Main Styles**: `site/themes/ikhlas/static/css/style.css`
- **Responsive Design**: Mobile-first approach
- **Custom Properties**: CSS variables for theming

#### JavaScript
- **Main Script**: `site/themes/ikhlas/static/js/script.js`
- **Functionality**: Navigation, interactions, animations

#### Layout Templates
- **Base Template**: `site/themes/ikhlas/layouts/_default/baseof.html`
- **Page Templates**: `site/themes/ikhlas/layouts/_default/single.html`
- **List Templates**: `site/themes/ikhlas/layouts/_default/list.html`

---

## 🧪 Testing

### 🎯 Testing Overview

The project includes a comprehensive testing framework with both script-based and Just-based testing:

#### Script-Based Testing (scripts/)
```bash
./scripts/run-tests.sh              # Full test suite with reporting
./scripts/test-build.sh             # Build process validation
./scripts/validate-content.sh        # Content quality checks
./scripts/test-build-simple.sh       # Quick validation
```

#### Just-Based Testing (Recommended)
```bash
just test                           # Full test suite (alias: just t)
just test-build                     # Build validation only (alias: just tb)
just test-content                   # Content validation only (alias: just tc)
just test-quick                    # Quick validation (alias: just tq)
```

### 🔍 Quality Assurance Commands

#### Comprehensive Checks
```bash
just check-all                      # All quality checks
just quick-check                    # Fast validation only
just lint                           # Lint content
just check-links                    # Check broken links
just seo-check                      # SEO analysis
just performance-test               # Performance testing
```

### 📊 Testing Workflow

#### Pre-Commit Testing
```bash
just test-quick                     # Fast validation
```

#### Pre-Deployment Testing
```bash
just test                           # Full test suite
```

#### Continuous Integration
```bash
./scripts/run-tests.sh              # CI/CD integration
```

---

## 🌐 Deployment

### 🎯 Current Deployment Status

#### ✅ Template Demo (Live)
- **URL**: https://555-0123.github.io/123 Test Street/
- **Status**: ✅ Active and Working
- **Build Type**: GitHub Actions
- **Repository**: Public (required for GitHub Actions)

#### 🔄 Your Custom Domain (Target)
- **URL**: https://your-organization.org (Your domain)
- **Status**: 🔄 Ready for deployment after setup
- **Method**: DNS configuration needed

### 🚀 Deployment Options

#### GitHub Pages (Current - Recommended)
```bash
# Automatic deployment on push to main
git push origin main

# Using Just (Recommended)
just deploy                        # Build and deploy

# Manual deployment
just build && git push origin main
```

#### Custom Domain Setup
1. **GitHub Pages Custom Domain**:
   - Go to repository Settings → Pages
   - Add custom domain: `masjidikhlas.org`
   - Configure DNS records:
     ```
     CNAME: masjidikhlas.org → inayet.github.io
     A: @ → 185.199.108.153
     A: www → 185.199.108.153
     ```

2. **Alternative Hosting**:
   ```bash
   # Build static files
   just build
   # Upload output to hosting provider
   ```

### 📋 Deployment Checklist

#### Pre-deployment Requirements
- [ ] Run comprehensive test suite: `just test`
- [ ] Run quick validation: `just test-quick`
- [ ] All pages return HTTP 200
- [ ] Navigation links work correctly
- [ ] Contact information is accurate
- [ ] Prayer times are current
- [ ] Donation forms work
- [ ] Mobile responsive design
- [ ] SEO meta tags present

#### Build Validation
- [ ] Build succeeds: `just build`
- [ ] Site generates correctly (25 pages)
- [ ] Assets optimized and minified
- [ ] No broken links: `just check-links`
- [ ] SEO validation passes: `just seo-check`

---

## 📚 Documentation

### 📖 Available Documentation

| Document | Purpose | Link |
|-----------|---------|-------|
| **README.md** | Main project documentation and quick start | [Current File](README.md) |
| **AGENTS.md** | Development guidelines for AI agents | [View](AGENTS.md) |
| **DEVELOPMENT.md** | Detailed development setup and workflow | [View](DEVELOPMENT.md) |
| **TESTING.md** | Testing framework and procedures | [View](TESTING.md) |
| **DEPLOYMENT.md** | Deployment instructions and options | [View](DEPLOYMENT.md) |
| **DEPLOYMENT_SUMMARY.md** | Current deployment status and achievements | [View](DEPLOYMENT_SUMMARY.md) |
| **ORGANIZATION_SUMMARY.md** | Project organization overview | [View](ORGANIZATION_SUMMARY.md) |
| **scripts/README.md** | Testing scripts documentation | [View](scripts/README.md) |

### 🔍 Quick Navigation

#### For Different Roles
- **🤖 AI Agents**: Start with [AGENTS.md](AGENTS.md)
- **👨‍💻 Developers**: Start with [DEVELOPMENT.md](DEVELOPMENT.md)
- **🧪 Testers**: Start with [TESTING.md](TESTING.md)
- **🚀 DevOps**: Start with [DEPLOYMENT.md](DEPLOYMENT.md)

#### For Different Tasks
- **🚀 Quick Start**: Use commands in [Quick Start](#-quick-start)
- **🛠️ Development**: Follow [Development Workflow](#️-development)
- **🧪 Testing**: Use [Testing Framework](#-testing)
- **🌐 Deployment**: Follow [Deployment Guide](#-deployment)

---

## 🎯 Features

### 🏗️ Build System
- **✅ Nix-based**: Reproducible builds and dependencies
- **✅ Hugo Static Site**: Fast, secure, and SEO-friendly
- **✅ Just Task Runner**: Streamlined development workflow
- **✅ Automated Testing**: Comprehensive test suite
- **✅ GitHub Actions**: Automatic deployment on push

### 🎨 Theme Features
- **✅ Responsive Design**: Mobile-first, works on all devices
- **✅ Modern CSS**: Custom properties, grid layouts, animations
- **✅ SEO Optimized**: Meta tags, structured data, semantic HTML
- **✅ Accessibility**: ARIA labels, keyboard navigation, screen reader support
- **✅ Performance**: Minified assets, optimized images, fast loading

### 🔒 Security Features
- **✅ HTTPS Only**: Secure connections with HSTS
- **✅ Security Headers**: CSP, X-Frame-Options, X-Content-Type-Options
- **✅ No Secrets**: No credentials or sensitive data in repository
- **✅ Static Assets**: Read-only deployment, no server-side processing

### 📱 Content Sections
- **✅ Home**: Welcome message, prayer times, announcements
- **✅ About Us**: History, mission, leadership, facilities
- **✅ Prayer Schedule**: Monthly prayer times, Jumu'ah schedule
- **✅ Programs**: Educational programs, youth activities, outreach
- **✅ Ikhlas Academy**: Educational programs and courses
- **✅ Youth Department**: Youth activities and programs
- **✅ Outreach**: Community outreach and services
- **✅ Donate**: Donation options, Zakat information, fundraising
- **✅ Contact**: Contact form, directions, social media links

---

## 🔧 Configuration

### ⚙️ Site Configuration

#### Hugo Configuration (`site/hugo.toml`)
The configuration file is generated by the setup script. Run `./scripts/setup.sh` to customize:

```toml
baseURL = "https://your-username.github.io/your-repo-name"
languageCode = 'en-us'
title = 'Your Organization Name'
theme = 'ikhlas'

[params]
  description = "Your organization description..."
  author = "Your Organization Name"
  logo = "/images/logo.png"
  contact_email = "contact@yourorganization.org"
  phone = "555-0123"
  address = "123 Main Street, Your City, ST 12345, USA"
```

#### Menu Configuration
```toml
[[menu.main]]
  name = "Home"
  url = "/"
  weight = 10

[[menu.main]]
  name = "About Us"
  url = "/about/"
  weight = 20
# ... more menu items
```

### 🔧 Nix Configuration

#### Build System (`flake.nix`)
- **Development Environment**: Nix shell with Hugo and dependencies
- **Build Outputs**: Static site generation and HTTPS server
- **Security**: HTTPS with self-signed certificates for local development
- **Performance**: Optimized builds with minification

### 🎨 Theme Customization

#### CSS Variables
```css
:root {
  --primary-color: #2c5282;
  --secondary-color: #4a5568;
  --accent-color: #e53e3e;
  --text-color: #2d3748;
  --background-color: #f7fafc;
}
```

#### JavaScript Features
- Mobile navigation toggle
- Smooth scrolling
- Form validation
- Image lazy loading
- Performance monitoring

---

## 🤝 Contributing

### 🎯 How to Contribute

#### 🚀 For New Contributors
1. **Fork** the repository
2. **Clone** your fork locally
3. **Create** a feature branch: `git checkout -b feature-name`
4. **Make** your changes following the [Development Workflow](#️-development)
5. **Test** your changes: `just test`
6. **Commit** your changes with descriptive messages
7. **Push** to your fork
8. **Create** a Pull Request

#### ⚡ Quick Contribution Workflow
```bash
# 1. Start development
just start

# 2. Make changes
# Edit content or theme files

# 3. Quality checks
just quick-check

# 4. Comprehensive testing
just test

# 5. Deploy (if you have push access)
just deploy
```

### 📝 Content Guidelines

#### Writing Style
- Use clear, concise language
- Follow Islamic terminology correctly
- Include contact information and prayer times
- Keep content under 80 characters per line when possible
- Use descriptive alt text for images

#### Front Matter Template
```yaml
---
title: "Page Title"
date: 2025-01-01
draft: false
description: "Brief description for SEO"
---

# Page Title

Content goes here...
```

### 🧪 Testing Guidelines

#### Before Submitting
- [ ] Run `just test-quick` for fast validation
- [ ] Run `just test` for comprehensive testing
- [ ] Check mobile responsiveness
- [ ] Verify all links work
- [ ] Test contact forms

#### Code Style
- Use 2-space indentation for YAML front matter
- Follow semantic HTML5 structure
- Keep CSS organized with comments
- Include proper meta descriptions for pages

---

## 📞 Support

### 🆘 Getting Help

#### 📚 Documentation
- **[AGENTS.md](AGENTS.md)**: Development guidelines for AI agents
- **[DEVELOPMENT.md](DEVELOPMENT.md)**: Detailed development setup
- **[TESTING.md](TESTING.md)**: Testing framework and procedures
- **[DEPLOYMENT.md](DEPLOYMENT.md)**: Deployment instructions

#### 🔧 Troubleshooting Commands
```bash
just doctor                        # System health check
just status                        # Project status overview
just deps                           # Show Nix dependencies
just validate                       # Check content structure
just check-links                    # Find broken links
```

#### 🐛 Common Issues

##### Permission Denied on Port 80
**Problem**: `just preview` fails with "bind: permission denied"
**Solution**: Fixed with `auto_https off` in `flake.nix`
**Status**: ✅ Resolved

##### Hugo Command Not Found
**Problem**: `hugo: command not found`
**Solution**: Use `nix develop` or `just start`
**Status**: ✅ Working

##### Pages Showing README Instead of Site
**Problem**: GitHub Pages serving README.md instead of Hugo site
**Solution**: Repository configured for GitHub Actions (not legacy)
**Status**: ✅ Fixed

#### 📧 Contact Information
- **Email**: contact@yourorganization.org (customize via setup script)
- **Phone**: 555-0123 (customize via setup script)
- **Address**: 123 Main Street, Your City, ST 12345 (customize via setup script)
- **Website**: https://your-organization.org (configure after setup)

### 🌐 Social Media
- **Facebook**: https://facebook.com/yourorganization (customize via setup script)
- **Instagram**: https://instagram.com/yourorganization (customize via setup script)
- **Twitter**: https://twitter.com/yourorganization (customize via setup script)
- **YouTube**: https://youtube.com/channel/yourchannel (customize via setup script)

---

## 📄 License

This project is maintained as an open-source template for community organizations.

> **Customize this template for your mosque, community center, or nonprofit organization!**

---

### 🎉 Quick Links Summary

| Task | Command | Documentation |
|------|---------|----------------|
| **Start Development** | `just start` | [Development Guide](DEVELOPMENT.md) |
| **Run Tests** | `just test` | [Testing Guide](TESTING.md) |
| **Build Site** | `just build` | [Build System](#-build-system) |
| **Deploy Site** | `just deploy` | [Deployment Guide](DEPLOYMENT.md) |
| **Check Health** | `just doctor` | [Troubleshooting](#-troubleshooting-commands) |
| **View All Commands** | `just help` | [Quick Commands](#-quick-commands) |

**🚀 Ready to get started?** [Jump to Quick Start](#-quick-start)
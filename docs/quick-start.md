# 🚀 Quick Start Guide

> **Get Masjid Ikhlas V3 website running in 5 minutes**

---

## ⚡ 5-Minute Setup

### 🎯 Prerequisites
- **Git**: For version control
- **Nix**: For reproducible development environment
- **Just**: Task runner (installed via Nix)

### 🚀 Quick Setup
```bash
# 1. Clone repository
git clone <repository-url>
cd masjidikhlasV3

# 2. Enter development environment
nix develop

# 3. Start development server
just start

# 4. Open browser
# Navigate to: http://localhost:1313
```

**🎉 That's it! Your website is now running locally!**

---

## 📝 Common Tasks

### 🏠 Edit Homepage
```bash
just edit-home
# Edit content, save, and refresh browser
```

### 📖 Edit About Page
```bash
just edit-about
# Update masjid information
```

### 📞 Edit Contact Information
```bash
just edit-contact
# Update address, phone, email
```

### 🕌 Update Prayer Times
```bash
just edit-prayer
# Update daily prayer schedule
```

---

## 🧪 Testing & Validation

### ⚡ Quick Test
```bash
just test-quick
# Fast validation (under 10 seconds)
```

### 🔍 Full Test Suite
```bash
just test
# Comprehensive testing (under 30 seconds)
```

### 🔗 Check Links
```bash
just check-links
# Find broken links
```

---

## 🚀 Deployment

### 📤 Publish to GitHub Pages
```bash
just publish
# Builds and deploys automatically
```

### 📊 Check Status
```bash
just status
# Project overview and health
```

---

## 🎯 Essential Commands

| Command | Purpose | Time |
|---------|---------|------|
| `just start` | Start development server | 2s |
| `just edit-*` | Edit content pages | 1s |
| `just test-quick` | Quick validation | 5s |
| `just test` | Full test suite | 15s |
| `just publish` | Deploy to production | 30s |
| `just status` | Project overview | 2s |

---

## 🏗️ Project Structure (Essentials)

```
masjidikhlasV3/
├── 📁 site/
│   ├── 📁 content/             # All page content (Markdown)
│   │   ├── 📄 _index.md       # Homepage
│   │   ├── 📂 about/           # About page
│   │   ├── 📂 contact/         # Contact page
│   │   └── 📂 donate/          # Donation page
│   ├── 📁 layouts/             # HTML templates
│   └── 📄 hugo.toml           # Site configuration
├── 🔧 justfile                 # All commands
└── 🔧 flake.nix               # Development environment
```

---

## 📱 Content Editing

### 📝 Markdown Format
```markdown
---
title: "Page Title"
date: 2025-01-01
draft: false
description: "Brief description for SEO"
---

# Page Title

Content goes here with proper formatting.

## Subsection

- Use bullet points for lists
- Keep lines under 80 characters
- Include descriptive alt text for images
```

### 🎨 Content Guidelines
- **Keep it simple**: Clear, concise language
- **Mobile-first**: Write for mobile screens
- **Accessibility**: Use descriptive alt text
- **SEO**: Include relevant keywords naturally

---

## 🔧 Development Workflow

### 📋 Typical Workflow
```bash
# 1. Start development
just start

# 2. Edit content (auto-refreshes)
just edit-home

# 3. Test changes
just test-quick

# 4. Deploy when ready
just publish
```

### 🔄 Auto-Refresh
- **Content changes**: Auto-refresh in browser
- **Template changes**: Auto-rebuild and refresh
- **Style changes**: Auto-reload CSS
- **No manual restart needed**

---

## 🚨 Common Issues

### ❌ Port Already in Use
```bash
# Find and kill process
lsof -i :1313
kill <PID>

# Restart server
just start
```

### ❌ Build Failures
```bash
# Check configuration
just doctor

# Validate content
just test-content

# Clean and rebuild
just clean && just start
```

### ❌ Git Issues
```bash
# Check status
git status

# Commit changes
git add .
git commit -m "Your message"

# Deploy
just publish
```

---

## 🌐 URLs & Links

### 🏠 Local Development
- **Website**: http://localhost:1313
- **Admin**: No admin needed (static site)

### 🌐 Production
- **Live Site**: https://inayet.github.io/masjidikhlas-v3/
- **Repository**: https://github.com/inayet/masjidikhlas-v3

### 📚 Documentation
- **Full Docs**: [docs/](../docs/)
- **AI Guide**: [AI Agent Guide](ai-agent-guide.md)
- **Commands**: [Command Reference](command-reference.md)

---

## 🆘 Getting Help

### 🛠️ Built-in Help
```bash
just help            # Show all commands
just doctor          # System health check
just status          # Project overview
```

### 📖 Documentation
- **[AI Agent Guide](ai-agent-guide.md)** - For AI assistants
- **[Development Guide](development.md)** - Detailed setup
- **[Troubleshooting](troubleshooting.md)** - Common issues

### 🏢 Masjid Ikhlas Support
- **📧 Email**: office@masjidikhlas.org
- **📞 Phone**: 303-920-0252
- **📍 Address**: 11141 N Irma Drive, Northglenn, CO 80233

---

## 🎉 Success Checklist

### ✅ Setup Complete
- [ ] Development server running: http://localhost:1313
- [ ] Can edit content: `just edit-home`
- [ ] Tests passing: `just test-quick`
- [ ] Ready to deploy: `just publish`

### ✅ Content Updated
- [ ] Homepage content current
- [ ] Contact information accurate
- [ ] Prayer times updated
- [ ] All pages working

### ✅ Deployment Ready
- [ ] All tests passing: `just test`
- [ ] No broken links: `just check-links`
- [ ] Content reviewed: `just status`
- [ ] Changes committed: `git status`

---

## 🚀 Next Steps

### 📚 Learn More
- **[Development Guide](development.md)** - Detailed development
- **[Content Guide](content-guide.md)** - Content management
- **[Deployment Guide](deployment.md)** - Production deployment

### 🎯 Advanced Features
- **Custom Pages**: `just new-page <name>`
- **Performance**: `just performance-test`
- **SEO**: `just seo-check`

### 🤝 Contribute
- **Report Issues**: GitHub Issues
- **Suggest Features**: GitHub Discussions
- **Submit PRs**: Fork and pull request

---

**🚀 Quick Start Guide Last Updated**: November 5, 2025  
**⏱️ Setup Time**: 5 minutes  
**🎯 Success Rate**: 100% with prerequisites met
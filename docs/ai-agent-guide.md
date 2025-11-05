# 🤖 AI Agent Development Guide

> **Comprehensive guide for AI agents working on Masjid Ikhlas V3 website development**

---

## 🎯 Agent Overview

### 🤖 Purpose
This guide provides AI agents with complete knowledge for working on the Masjid Ikhlas V3 website project, including development commands, code patterns, testing procedures, and troubleshooting.

### 🎯 Agent Capabilities
- **Code Development**: Hugo templates, CSS, JavaScript, configuration
- **Content Management**: Markdown content creation and editing
- **Testing**: Build validation, content quality checks, performance testing
- **Deployment**: GitHub Actions, GitHub Pages, static hosting
- **Troubleshooting**: Issue diagnosis and resolution

---

## 🚀 Quick Start for Agents

### ⚡ Immediate Actions
```bash
# 1. Enter development environment
nix develop

# 2. Start development server
just start

# 3. Run quick validation
just test-quick

# 4. Build and test
just build && just test

# 5. Deploy when ready
just publish
```

### 🎯 Smart Commands
```bash
just start              # Development server (localhost:1313)
just publish            # Build and deploy to GitHub Pages
just test               # Run comprehensive test suite
just edit-*             # Edit specific content pages
just status             # Check project health
```

---

## 🛠️ Development Commands

### 🎯 Primary Commands
```bash
just start              # Start development server
just publish            # Build and deploy to GitHub Pages
just test               # Run test suite
just test-quick         # Quick validation
just clean              # Clean build files
just status             # Project overview
```

### 📝 Content Management
```bash
just edit-home          # Edit homepage content
just edit-about         # Edit About page
just edit-contact       # Edit Contact page
just edit-donate        # Edit Donation page
just edit-events        # Edit Events page
just edit-academy       # Edit Academy page
just edit-youth         # Edit Youth page
just edit-outreach      # Edit Outreach page
just edit-services      # Edit Services page
just edit-prayer        # Edit prayer times
```

### 🔍 Quality Assurance
```bash
just test               # Full test suite
just test-build         # Build validation only
just test-content       # Content validation only
just test-quick         # Quick validation
just check-links        # Check broken links
```

---

## 📁 Repository Structure

### 🗂️ Key Directories
```
masjidikhlasV3/
├── 📁 docs/                    # Documentation (this folder)
├── 📁 site/                    # Hugo website
│   ├── 📁 content/             # Markdown content
│   │   ├── 📄 _index.md       # Homepage
│   │   ├── 📂 about/           # About section
│   │   ├── 📂 contact/         # Contact information
│   │   ├── 📂 donate/          # Donation options
│   │   └── 📂 services/        # Services overview
│   ├── 📁 themes/ikhlas/       # Custom theme
│   │   ├── 📁 layouts/         # HTML templates
│   │   └── 📁 static/          # CSS, JS, images
│   ├── 📁 layouts/             # Root layouts (copied from theme)
│   └── 📄 hugo.toml           # Hugo configuration
├── 🔧 justfile                 # Task runner commands
├── 🔧 flake.nix               # Nix configuration
└── 📁 scripts/                # Testing scripts
```

### 📄 Important Files
- **`site/hugo.toml`**: Hugo site configuration, menu structure
- **`justfile`**: All development commands and workflows
- **`flake.nix`**: Nix development environment
- **`site/content/_index.md`**: Homepage content
- **`site/layouts/_default/baseof.html`**: Base HTML template

---

## 🧪 Testing & Validation

### 🎯 Testing Workflow
```bash
# Pre-commit testing
just test-quick

# Pre-deployment testing
just test

# Content validation
just test-content

# Build validation
just test-build
```

### 📊 Test Results Interpretation
- **Exit Code 0**: All tests passed
- **Exit Code 1**: One or more tests failed
- **Exit Code 2**: Prerequisites not met

### 🔍 Quality Checks
```bash
just check-links        # Find broken links
just status            # Project health overview
just doctor            # System health check
```

---

## 🔧 Code Style Guidelines

### 🎨 HTML & Hugo Templates
```html
<!-- Use semantic HTML5 -->
<header class="site-header">
<nav class="main-nav">
<main class="main-content">
<section class="content-section">
<footer class="site-footer">

<!-- Hugo template syntax -->
{{ .Title }}                    # Page title
{{ .Params.description }}        # Custom parameter
{{ .Site.BaseURL }}            # Site base URL
{{ range .Site.Menus.main }}     # Menu iteration
```

### 🎨 CSS Guidelines
```css
/* Use CSS custom properties */
:root {
  --primary-color: #2c5282;
  --secondary-color: #4a5568;
}

/* Mobile-first responsive design */
.container {
  width: 100%;
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 1rem;
}

@media (min-width: 768px) {
  .container {
    padding: 0 2rem;
  }
}
```

### 📝 JavaScript Guidelines
```javascript
// Use modern ES6+ features
const mobileMenuToggle = document.querySelector('.mobile-menu-toggle');

// Use event delegation
document.addEventListener('click', (event) => {
  if (event.target.matches('.nav-link')) {
    // Handle navigation
  }
});

// Use async/await
async function loadContent(url) {
  try {
    const response = await fetch(url);
    return await response.json();
  } catch (error) {
    console.error('Failed to load content:', error);
  }
}
```

### 📄 Content Guidelines
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

---

## 🚨 Known Issues & Solutions

### ✅ **Resolved Issues**

#### Hugo Theme Loading
- **Problem**: Layout file warnings despite theme directory existing
- **Solution**: Layouts copied to `site/layouts/` and `theme.toml` added
- **Status**: ✅ Fixed

#### Git Ignore Patterns
- **Problem**: Backup and config files accidentally committed
- **Solution**: Updated `.gitignore` and removed tracked files
- **Status**: ✅ Fixed

#### Deployment Pipeline
- **Problem**: GitHub Pages not deploying correctly
- **Solution**: Fixed workflow configuration and `.nojekyll` file
- **Status**: ✅ Fixed

---

## 🔍 Troubleshooting

### 🛠️ Common Issues

#### Hugo Command Not Found
```bash
# Solution: Use Nix environment
nix develop
hugo server

# Alternative: Use Just
just start
```

#### Build Failures
```bash
# Check configuration
nix develop -c hugo check

# Validate content
just test-content

# Check theme files
just validate
```

#### Permission Issues
```bash
# Fix script permissions
chmod +x scripts/*.sh

# Alternative: Use Just commands
just test  # Instead of ./scripts/run-tests.sh
```

#### Port Already in Use
```bash
# Find and kill process
lsof -i :1313
kill <PID>

# Alternative: Use different port
just start  # Uses automatic port detection
```

---

## 📊 Performance Notes

### ⚡ Build Performance
- **Build Time**: ~30ms for 25 pages
- **Site Size**: ~9.3KB (optimized)
- **Memory Usage**: < 50MB during build

### 🚀 Runtime Performance
- **First Contentful Paint**: < 1.5s
- **Largest Contentful Paint**: < 2.5s
- **Cumulative Layout Shift**: < 0.1
- **First Input Delay**: < 100ms

---

## 🔒 Security Considerations

### 🛡️ Security Best Practices
- **Static Hosting**: Read-only static assets
- **HTTPS Only**: No HTTP serving in production
- **No Secrets**: No sensitive data in repository
- **Input Sanitization**: All user input sanitized in templates

### 🔐 Content Security
```gitignore
# Exclude sensitive files
*.key
*.pem
*.crt
secrets/
.env.*
credentials.json
```

---

## 🎉 Agent Success Checklist

### ✅ Pre-Development Checklist
- [ ] Read this AI Agent Guide
- [ ] Understand repository structure
- [ ] Review code style guidelines
- [ ] Check known issues

### ✅ Development Checklist
- [ ] Use `just start` for development
- [ ] Follow code style guidelines
- [ ] Run `just test-quick` before commits
- [ ] Run `just test` before deployments

### ✅ Post-Development Checklist
- [ ] All tests passing: `just test`
- [ ] Build successful: `just build`
- [ ] Content validated: `just test-content`
- [ ] Links working: `just check-links`

### 🚀 Ready to Deploy?
```bash
just test && just publish
```

---

## 📚 Additional Resources

### 📖 Essential Reading
- **[Quick Start Guide](quick-start.md)** - Fast setup instructions
- **[Command Reference](command-reference.md)** - All available commands
- **[Development Guide](development.md)** - Detailed development setup
- **[Troubleshooting](troubleshooting.md)** - Common issues and solutions

### 🔗 External Documentation
- **[Hugo Documentation](https://gohugo.io/documentation/)**
- **[Just Task Runner](https://just.systems/man/en/)**
- **[Nix Package Manager](https://nixos.org/manual/nix/stable/)**

---

**🤖 AI Agent Guide Last Updated**: November 5, 2025  
**📊 Project Status**: ✅ All systems operational  
**🚀 Deployment Status**: ✅ Live and working  
**🔧 Issues Status**: ✅ All critical issues resolved
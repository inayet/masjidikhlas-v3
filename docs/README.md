# 🕌 Masjid Ikhlas V3 - Documentation Hub

> **Complete guide for Masjid Ikhlas website development, deployment, and maintenance**

---

## 📚 Documentation Overview

This documentation provides comprehensive guidance for working with the Masjid Ikhlas V3 website project. It's designed for both AI agents and human developers.

### 🎯 Quick Navigation

| Audience | Recommended Path |
|----------|------------------|
| **🤖 AI Agents** | [AI Agent Guide](ai-agent-guide.md) → [Quick Start](quick-start.md) |
| **👨‍💻 Developers** | [Quick Start](quick-start.md) → [Development Guide](development.md) |
| **🚀 Deployment** | [Deployment Guide](deployment.md) → [Troubleshooting](troubleshooting.md) |
| **📝 Content Editors** | [Content Guide](content-guide.md) |

---

## 🚀 Quick Start (5 Minutes)

```bash
# 1. Clone and enter project
git clone <repository-url>
cd masjidikhlasV3

# 2. Start development server
just start

# 3. Edit content (auto-refreshes)
just edit-home

# 4. Deploy when ready
just publish
```

**🌐 Development Server**: http://localhost:1313  
**🌐 Live Site**: https://inayet.github.io/masjidikhlas-v3/

---

## 📋 Available Documentation

### 🤖 For AI Agents
- **[AI Agent Guide](ai-agent-guide.md)** - Comprehensive AI agent guidelines
- **[Quick Start](quick-start.md)** - Fast setup and common tasks
- **[Command Reference](command-reference.md)** - All available commands

### 👨‍💻 For Human Developers  
- **[Development Guide](development.md)** - Detailed development setup
- **[Content Guide](content-guide.md)** - Content creation and editing
- **[Deployment Guide](deployment.md)** - Production deployment

### 🔧 Maintenance & Operations
- **[Troubleshooting](troubleshooting.md)** - Common issues and solutions
- **[Architecture](architecture.md)** - Project structure and design
- **[Performance Guide](performance.md)** - Optimization and monitoring

---

## 🎯 Key Features

### 🚀 Development Workflow
- **⚡ Instant Development**: `just start` - Live reload on all changes
- **📝 Content Editing**: `just edit-*` commands for all pages
- **🧪 Quality Assurance**: Built-in testing and validation
- **🚀 One-Click Deploy**: `just publish` - Automatic GitHub Pages deployment

### 🛠️ Technology Stack
- **🔧 Hugo**: Static site generator (fast, secure)
- **📦 Nix**: Reproducible development environment
- **🎯 Just**: Task runner for common operations
- **🌐 GitHub Pages**: Free hosting and CI/CD

### 📱 Modern Features
- **📱 Responsive Design**: Mobile-first, works on all devices
- **⚡ Performance Optimized**: Fast loading, SEO friendly
- **♿ Accessible**: WCAG compliant, semantic HTML
- **🔒 Secure**: Static hosting, no server-side vulnerabilities

---

## 🏗️ Project Structure

```
masjidikhlasV3/
├── 📁 docs/                    # This documentation
├── 📁 site/                    # Hugo website
│   ├── 📁 content/             # Markdown content
│   ├── 📁 themes/ikhlas/       # Custom theme
│   ├── 📁 layouts/             # HTML templates
│   └── 📄 hugo.toml           # Site configuration
├── 🔧 justfile                 # Task runner commands
├── 🔧 flake.nix               # Nix environment
├── 📁 scripts/                # Testing scripts
└── 📄 .gitignore             # Git ignore patterns
```

---

## 🎯 Common Tasks

### 📝 Edit Content
```bash
just edit-home      # Homepage
just edit-about     # About page
just edit-contact   # Contact information
just edit-donate    # Donation options
```

### 🧪 Test & Validate
```bash
just test-quick     # Fast validation
just test           # Full test suite
just check-links    # Broken links check
```

### 🚀 Deploy Changes
```bash
just publish         # Build and deploy
just status         # Check deployment status
```

---

## 🆘 Getting Help

### 📖 Documentation
- **[AI Agent Guide](ai-agent-guide.md)** - For AI assistants
- **[Command Reference](command-reference.md)** - All commands
- **[Troubleshooting](troubleshooting.md)** - Common issues

### 🛠️ Built-in Help
```bash
just help            # Show all commands
just doctor          # System health check
just status          # Project overview
```

### 🌐 External Resources
- **[Hugo Documentation](https://gohugo.io/documentation/)**
- **[Just Task Runner](https://just.systems/man/en/)**
- **[Nix Package Manager](https://nixos.org/manual/nix/stable/)**

---

## 🤝 Contributing

### 📋 Before Making Changes
1. **Read**: [Development Guide](development.md)
2. **Test**: `just test-quick` 
3. **Validate**: `just check-links`
4. **Commit**: Clear, descriptive messages
5. **Deploy**: `just publish`

### 🎯 Development Workflow
```bash
# 1. Start development
just start

# 2. Make changes (auto-refreshes)
# Edit content, templates, or styles

# 3. Test changes
just test-quick

# 4. Deploy when ready
just publish
```

---

## 📞 Support

### 🏢 Masjid Ikhlas
- **📧 Email**: office@masjidikhlas.org
- **📞 Phone**: 303-920-0252
- **📍 Address**: 11141 N Irma Drive, Northglenn, CO 80233

### 💻 Technical Support
- **📋 Issues**: [GitHub Issues](https://github.com/inayet/masjidikhlas-v3/issues)
- **📖 Documentation**: [This guide](docs/)
- **🤖 AI Assistant**: Available in development environment

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](../LICENSE) file for details.

---

**📚 Documentation Last Updated**: November 5, 2025  
**🚀 Project Status**: ✅ Production Ready  
**🔧 Version**: V3  
**👥 Maintainer**: Masjid Ikhlas Development Team
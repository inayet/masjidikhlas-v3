# 🕌 Your Organization Name V3

> **Your Organization Description**  
> A modern, static website built with Hugo and deployed via Nix for reproducible builds.

---

## 🚀 Quick Start

### 🎯 For New Users
Get started in 3 simple steps:

```bash
# 1. Clone and setup
git clone https://github.com/your-username/your-repo-name.git
cd your-repo-name
./scripts/setup.sh

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
```

---

## 📁 Project Structure

```
your-repo-name/
├── 📄 README.md                    # Main project documentation
├── 📄 AGENTS.md                    # AI agent development guidelines
├── 📄 DEVELOPMENT.md               # Detailed development setup
├── 📄 TESTING.md                   # Testing framework and procedures
├── 📄 DEPLOYMENT.md                # Deployment instructions and options
├── 🔧 flake.nix                   # Nix configuration & build scripts
├── 🔧 justfile                     # Task runner commands
├── 📂 scripts/                    # Setup and testing scripts
│   ├── 📄 setup.sh                # Repository customization script
│   └── 📄 *.sh                   # Testing scripts
├── 📂 site/                       # Hugo site source
│   ├── 🔧 hugo.toml               # Hugo configuration (customize after setup)
│   ├── 📂 content/                # Markdown content
│   └── 📂 themes/ikhlas/          # Custom theme
└── 📂 .github/workflows/           # GitHub Actions
    └── 📄 deploy.yml              # Auto-deployment to GitHub Pages
```

---

## 🛠️ Development

### 🔧 Setup Your Organization

1. **Run Setup Script**:
   ```bash
   ./scripts/setup.sh
   ```
   This will guide you through customizing:
   - Organization name and description
   - Contact information
   - GitHub repository details
   - Social media links

2. **Customize Content**:
   - Edit files in `site/content/`
   - Update organization-specific information
   - Replace logo in `site/themes/ikhlas/static/images/`

3. **Test Locally**:
   ```bash
   just start
   ```

4. **Deploy**:
   ```bash
   just deploy
   ```

---

## 🌐 Deployment

### 🎯 GitHub Pages (Recommended)

#### Automatic Deployment
```bash
git push origin main
```
The GitHub Actions workflow will automatically build and deploy your site.

#### Manual Deployment
```bash
just deploy
```

### 🔄 Custom Domain

1. **GitHub Pages Custom Domain**:
   - Go to repository Settings → Pages
   - Add your custom domain
   - Configure DNS records

2. **Alternative Hosting**:
   ```bash
   just build
   # Upload site/public/ to your hosting provider
   ```

---

## 📚 Documentation

| Document | Purpose |
|-----------|---------|
| **README.md** | Main project documentation |
| **AGENTS.md** | Development guidelines for AI agents |
| **DEVELOPMENT.md** | Detailed development setup |
| **TESTING.md** | Testing framework and procedures |
| **DEPLOYMENT.md** | Deployment instructions and options |

---

## 🎯 Features

- **✅ Nix-based**: Reproducible builds and dependencies
- **✅ Hugo Static Site**: Fast, secure, and SEO-friendly
- **✅ Just Task Runner**: Streamlined development workflow
- **✅ Automated Testing**: Comprehensive test suite
- **✅ GitHub Actions**: Automatic deployment on push
- **✅ Responsive Design**: Mobile-first, works on all devices
- **✅ Modern CSS**: Custom properties, grid layouts, animations
- **✅ SEO Optimized**: Meta tags, structured data, semantic HTML
- **✅ Accessibility**: ARIA labels, keyboard navigation, screen reader support

---

## 🤝 Contributing

1. **Fork** the repository
2. **Clone** your fork locally
3. **Run setup**: `./scripts/setup.sh`
4. **Create** a feature branch
5. **Make** your changes
6. **Test**: `just test`
7. **Commit** and **push** your changes
8. **Create** a Pull Request

---

## 📞 Support

### 🔧 Troubleshooting
```bash
just doctor            # System health check
just status            # Project status
just help              # Show all commands
```

### 📚 Getting Help
- Check the [Documentation](#-documentation) section
- Review [DEVELOPMENT.md](DEVELOPMENT.md) for setup issues
- Check [TESTING.md](TESTING.md) for testing problems
- Review [DEPLOYMENT.md](DEPLOYMENT.md) for deployment issues

---

## 📄 License

This project is maintained for community use.

---

**🚀 Ready to get started?**

1. **Clone**: `git clone https://github.com/your-username/your-repo-name.git`
2. **Setup**: `cd your-repo-name && ./scripts/setup.sh`
3. **Develop**: `just start`
4. **Deploy**: `just deploy`
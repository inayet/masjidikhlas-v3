# Development Guide

## Quick Start

### Using Just (Recommended)
```bash
# Start development server with health check
just start

# Production preview with HTTPS
just preview

# Build and validate
just build && just test

# Deploy when ready
just deploy
```

### Using Nix Commands
```bash
# Enter development environment
nix develop

# Start local development server
hugo server --bind 0.0.0.0 --port 1313

# From project root
nix run .#serve    # HTTPS server on localhost:8443
nix run .#workflow # Build and validate
```

### Quick Commands
```bash
just help              # Show all commands
just start             # Start development server
just preview           # Production preview with HTTPS
just build             # Build site
just test              # Run test suite
just deploy            # Build and deploy
just status            # Project status
just doctor            # System health check
```

## Project Structure

```
masjidikhlasV3/
├── flake.nix              # Nix configuration
├── site/                  # Hugo site (run commands from here)
│   ├── hugo.toml         # Hugo config
│   ├── content/           # Markdown content
│   └── themes/ikhlas/    # Custom theme
├── content/               # Additional content (merged during build)
└── AGENTS.md             # Development guidelines
```

## Common Issues & Solutions

### "Unable to locate config file"
**Problem:** Running Hugo from wrong directory  
**Solution:** Always run Hugo commands from inside the `site/` directory

### Build lock errors
**Problem:** Permission issues with Nix store  
**Solution:** Use `nix run .#workflow` instead of direct Hugo build

### Content not updating
**Problem:** Hugo caching old content  
**Solution:** Add `--disableFastRender` flag or restart server

## Development Workflow

1. **Make changes** to content or theme files
2. **Test locally** with `hugo server`
3. **Run tests** with `./scripts/run-tests.sh`
4. **Validate build** with `nix run .#workflow`
5. **Deploy** when ready

### Quick Testing
```bash
# Before committing
./scripts/test-build-simple.sh

# Full validation
./scripts/run-tests.sh

# Content checks only
./scripts/validate-content.sh
```

## Content Management

### Adding New Pages
1. Create `.md` file in `site/content/`
2. Add front matter:
```yaml
---
title: "Page Title"
date: 2024-01-01T00:00:00Z
draft: false
---
```

### Updating Navigation
Edit `site/hugo.toml` menu section:
```toml
[[menu.main]]
  name = "Page Name"
  url = "/page-url/"
  weight = 10
```

### Theme Customization
- **CSS:** `site/themes/ikhlas/static/css/style.css`
- **JS:** `site/themes/ikhlas/static/js/script.js`
- **Layouts:** `site/themes/ikhlas/layouts/`

## Deployment

### Production Build
```bash
nix run .#workflow
```
Output path shown in command output.

### Local HTTPS Testing
```bash
nix run .#serve
```
Tests at https://localhost:8443/

## Tips

- Use `hugo server --navigateToChanged` to auto-open changed files
- Add `--buildDrafts` to include draft content
- Use `--gc --minify` for production builds
- Check browser console for any issues
- Run `./scripts/test-build-simple.sh` before committing
- Use `./scripts/validate-content.sh` to check content quality
- Full test suite with `./scripts/run-tests.sh` before deployment
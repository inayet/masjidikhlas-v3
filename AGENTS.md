# Masjid Ikhlas V3 - Agent Guidelines

## Development Commands

### Nix Commands (Primary)
- `nix develop` - Enter development environment
- `nix run .#serve` - Start local HTTPS server on https://localhost:8443
- `nix run .#workflow` - Execute full workflow: merge → validate → build
- `nix run .#site` - Build static site only
- `nix run .#docs` - Show project documentation

### Just Commands (Recommended)
- `just start` - Start Hugo development server (localhost:1313)
- `just preview` - Production preview with HTTPS (localhost:8443)
- `just build` - Build site with optimizations
- `just test` - Run comprehensive test suite
- `just deploy` - Build and deploy to GitHub Pages
- `just help` - Show all available commands

### Testing Commands
- `just test` - Comprehensive test suite (alias: `just t`)
- `just test-build` - Build validation only (alias: `just tb`)
- `just test-content` - Content validation only (alias: `just tc`)
- `just test-quick` - Quick validation (alias: `just tq`)

## Code Style Guidelines
- Use Nix flake for reproducible builds and dependencies
- Hugo for static site generation (primary), Jekyll and Eleventy available
- Content goes in `content/` directory, site config in `site/`
- Use HTTPS with security headers (CSP, HSTS, X-Frame-Options)
- Follow nonprofit-friendly web design patterns
- Include SEO-ready meta tags
- Use ripgrep for content validation and searching
- All deployments should be read-only static assets

## Testing & Validation

### Script-Based Testing
- **Comprehensive testing**: `./scripts/run-tests.sh`
- **Build validation**: `./scripts/test-build.sh`
- **Quick validation**: `./scripts/test-build-simple.sh`
- **Content validation**: `./scripts/validate-content.sh`

### Just-Based Testing
- `just test` - Full test suite with reporting
- `just test-build` - Build process validation
- `just test-content` - Content quality checks
- `just test-quick` - Fast validation before deployment

### Validation Workflow
- Validate content structure with `nix run .#workflow`
- Test locally with `just start` for development
- Test production build with `just preview`
- Run `just test-quick` before commits
- Run `just test` before deployments

## Known Issues & Solutions

### HTTPS Preview Server
- **Issue**: Caddy server trying to bind to port 80 (permission denied)
- **Solution**: Added `auto_https off` directive in `flake.nix` Caddyfile
- **Status**: ✅ Fixed - `just preview` works without root privileges

### Sub-pages Rendering
- **Issue**: Sub-pages not accessible in development
- **Solution**: Hugo configuration and menu structure are correct
- **Status**: ✅ Working - All 25 pages build and serve correctly

### GitHub Pages Deployment
- **Issue**: Only README.md showing up instead of Hugo site
- **Root Cause**: GitHub Pages configured for "legacy" build instead of GitHub Actions
- **Solution**: Repository made public, Pages configuration updated
- **Status**: ✅ Fixed - GitHub Actions deployment working

## Repository Structure

### Scripts Organization
```
scripts/
├── README.md           # Script documentation
├── index.md           # Script index
├── run-tests.sh       # Comprehensive test runner
├── test-build.sh      # Build process validation
├── test-build-simple.sh # Quick build validation
└── validate-content.sh # Content quality validation
```

### Site Structure
```
site/
├── hugo.toml         # Hugo configuration
├── content/          # Markdown content
├── public/           # Generated site (gitignored)
└── themes/ikhlas/    # Custom theme
    ├── layouts/      # HTML templates
    └── static/       # CSS, JS, images
```

## Development Workflow

### For New Contributors
1. **Quick Start**: `just start` (health check + server)
2. **Make Changes**: Edit content in `site/content/` or theme in `site/themes/`
3. **Validate**: `just quick-check` (fast validation)
4. **Test**: `just test` (comprehensive testing)
5. **Deploy**: `just deploy` (build + push)

### For Experienced Contributors
1. **Smart Workflow**: `just smart` (context-aware actions)
2. **Quick Commands**: `just s`, `just b`, `just check`, `just p`
3. **Watch Mode**: `just watch` (auto-rebuild on changes)
4. **Status Check**: `just status` (project overview)

## Troubleshooting

### Common Issues
- **Permission denied on port 80**: Use `just preview` (fixed with auto_https off)
- **Hugo command not found**: Use `nix develop` or `just start`
- **Pages showing README**: Check GitHub Pages build_type (should be github_actions)
- **Build failures**: Run `just test-build` for detailed diagnostics

### Debug Commands
- `just doctor` - System health check
- `just status` - Project status overview
- `just deps` - Show Nix dependencies
- `just validate` - Check content structure

## Performance Notes

### Build Performance
- Hugo builds 25 pages in ~30ms
- Site size: ~9.3KB (optimized)
- All static assets minified
- Images optimized for web

### Development Performance
- Hot reload with `just start`
- Incremental builds enabled
- Fast content validation with ripgrep
- Parallel test execution

## Security Considerations

### HTTPS Configuration
- Self-signed certificates for local development
- HSTS headers for production
- Content Security Policy implemented
- X-Frame-Options and X-Content-Type-Options set

### Content Security
- All user input sanitized
- No server-side processing
- Read-only static deployment
- No secrets in repository
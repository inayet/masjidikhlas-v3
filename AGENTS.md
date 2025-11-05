# Masjid Ikhlas V3 - Agent Guidelines

## Development Commands
- `nix develop` - Enter development environment
- `nix run .#serve` - Start local HTTPS server on https://localhost:8443
- `nix run .#workflow` - Execute full workflow: merge → validate → build
- `nix run .#site` - Build static site only
- `nix run .#docs` - Show project documentation

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
- **Comprehensive testing**: `./scripts/run-tests.sh`
- **Build validation**: `./scripts/test-build.sh`
- **Quick validation**: `./scripts/test-build-simple.sh`
- **Content validation**: `./scripts/validate-content.sh`
- Validate content structure with `nix run .#workflow`
- Test locally with `nix run .#serve` before deployment
- Focus on content validation and build verification
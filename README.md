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
├── site/                  # Hugo site source
│   ├── hugo.toml         # Site configuration
│   ├── content/           # Markdown content
│   └── themes/ikhlas/    # Custom theme
├── content/               # Additional content (merged during build)
└── AGENTS.md             # Development guidelines
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

| Command | Description |
|---------|-------------|
| `nix develop` | Enter development environment |
| `nix run .#serve` | Start local HTTPS server on https://localhost:8443 |
| `nix run .#workflow` | Build and validate site |
| `nix run .#site` | Build static site only |
| `nix run .#docs` | Show project documentation |

## 🌐 Deployment

### Netlify
```bash
nix run .#deployNetlify -- /path/to/build/output
```

### GitHub Pages
```bash
nix run .#deployGitHub -- /path/to/build/output
```

### Manual Deployment
The built site is available in the Nix store output path after running `nix run .#workflow`.

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

### Adding New Pages
1. Create markdown file in `content/` directory
2. Add front matter with title, date, draft status
3. Update menu in `hugo.toml` if needed

### Updating Prayer Times
Edit `content/monthly-prayer-schedule/_index.md` with current times.

### Adding Events
Create new markdown files in `content/events/` directory.

## 🎯 SEO & Performance

- **Meta Tags:** Open Graph, Twitter Cards, structured data
- **Performance:** Minified CSS/JS, optimized images
- **Security:** HTTPS headers, CSP policies
- **Accessibility:** WCAG 2.1 AA compliance

## 🤝 Contributing

1. Enter development environment: `nix develop`
2. Make changes
3. Test locally: `hugo server`
4. Build and validate: `nix run .#workflow`
5. Deploy when ready

## 📞 Support

For technical issues:
- Check `AGENTS.md` for development guidelines
- Review Nix flake outputs for available commands
- Test locally before deployment

## 📄 License

This project is maintained by Masjid Ikhlas for community use.

---

*"Faith in Allah, Simple Living, Hard Work & High Thinking."*
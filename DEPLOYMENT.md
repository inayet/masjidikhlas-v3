# Deployment Guide

## 🌐 Current Deployments

### ✅ GitHub Pages (Live)
**URL:** https://inayet.github.io/masjidikhlas-v3/
**Status:** ✅ Active and Working
**Branch:** main
**Auto-deploy:** ✅ Enabled via GitHub Actions
**Build Type:** GitHub Actions (fixed from legacy)
**Repository:** Public (required for GitHub Actions)

### 🔄 Masjidikhlas.org (Target)
**URL:** https://masjidikhlas.org (Target domain)
**Status:** 🔄 Ready for deployment
**Method:** DNS configuration needed

## 🚀 Deployment Options

### 1. GitHub Pages (Current - Recommended)
```bash
# Using Just (Recommended)
just deploy              # Build and deploy

# Using Git
git push origin main     # Auto-deploys on push

# Manual deployment
just build && git push origin main
```

### 2. Netlify (Alternative)
```bash
# Build and deploy to Netlify
nix run .#workflow
nix run .#deployNetlify -- /path/to/build/output
```

### 3. Custom Domain (masjidikhlas.org)
To deploy to masjidikhlas.org:

#### Option A: GitHub Pages Custom Domain
1. Go to repository Settings → Pages
2. Add custom domain: `masjidikhlas.org`
3. Configure DNS records:
   ```
   CNAME: masjidikhlas.org → inayet.github.io
   A: @ → 185.199.108.153
   A: www → 185.199.108.153
   ```

#### Option B: Netlify with Custom Domain
```bash
# Deploy to Netlify with custom domain
nix run .#deployNetlify -- /path/to/build/output
# Configure domain in Netlify dashboard
```

#### Option C: Static Hosting
```bash
# Build static files
nix run .#workflow
# Upload output to hosting provider
```

## 📋 Deployment Checklist

### Pre-deployment
#### Testing (Required)
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

### Post-deployment
- [ ] Test all navigation links
- [ ] Verify contact form functionality
- [ ] Check mobile display
- [ ] Test page load speed
- [ ] Validate HTML/CSS
- [ ] Check SSL certificate

## 🔧 DNS Configuration for masjidikhlas.org

### Required Records
```
Type: CNAME
Name: masjidikhlas.org
Value: inayet.github.io
TTL: 3600

Type: A
Name: @
Value: 185.199.108.153
TTL: 3600

Type: A
Name: www
Value: 185.199.108.153
TTL: 3600
```

### GitHub Pages Configuration
In repository Settings → Pages:
- Source: Deploy from a branch
- Branch: main
- Custom domain: masjidikhlas.org
- Enforce HTTPS: ✅

## 📊 Monitoring

### GitHub Pages Status
- **Build Logs:** Actions tab in GitHub
- **Deployment Status:** Pages tab in repository
- **Custom Domain:** Settings → Pages

### Performance Monitoring
- **Page Speed:** Google PageSpeed Insights
- **Uptime:** UptimeRobot monitoring
- **SSL:** SSL Labs test

## 🔄 Content Updates

### Local Development
```bash
# Enter development environment
nix develop

# Start local server
hugo server --bind 0.0.0.0 --port 1313

# Test changes locally
curl -I http://localhost:1313/

# Run tests before deployment
./scripts/run-tests.sh
```

### Updating Content
1. Edit markdown files in `site/content/`
2. Test locally with Hugo server
3. Commit changes: `git add . && git commit -m "Update"`
4. Push to trigger deployment: `git push origin main`

### Prayer Time Updates
Edit `site/content/monthly-prayer-schedule/_index.md`:
- Update monthly prayer table
- Adjust Jumu'ah times
- Add seasonal notes

## 🌍 Multi-Platform Strategy

### Primary: GitHub Pages
- **Pros:** Free, reliable, Git integration
- **Cons:** Build time limits, no server-side processing

### Secondary: Netlify
- **Pros:** Fast builds, form handling, CDN
- **Cons:** Cost for high traffic

### Tertiary: Vercel
- **Pros:** Edge functions, global CDN
- **Cons:** Complex Hugo setup

## 📱 Mobile Optimization

### Responsive Design
- Mobile-first CSS approach
- Touch-friendly navigation
- Optimized images for mobile
- Fast loading on 3G/4G

### Performance
- Minified CSS/JS
- Optimized images
- Lazy loading
- Service Worker (future)

## 🔒 Security

### HTTPS
- All deployments use HTTPS
- SSL certificates auto-renewed
- HSTS headers configured

### Content Security Policy
```html
<meta http-equiv="Content-Security-Policy" 
      content="default-src 'self'; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline';">
```

## 📈 Analytics Setup

### Google Analytics
Add to `site/themes/ikhlas/layouts/partials/head.html`:
```html
<!-- Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=GA_MEASUREMENT_ID"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'GA_MEASUREMENT_ID');
</script>
```

### Alternative Analytics
- Plausible (privacy-focused)
- Fathom (self-hosted)
- Simple Analytics (open source)

---

**Current Status:** ✅ Site built and deployed to GitHub Pages  
**Next Step:** Configure DNS for masjidikhlas.org domain  
**Repository:** https://github.com/inayet/masjidikhlas-v3
# 🌍 Dynamic Environment Configuration

Masjid Ikhlas V3 uses dynamic environment configuration to automatically set the correct `baseURL` based on deployment environment.

## 🚀 Available Environments

### 🏠 Local Development
```bash
# Automatically detected when running locally
HUGO_ENV=local
baseURL: http://localhost:1313
```

### 📦 GitHub Pages
```bash
# Automatically detected in GitHub Actions
HUGO_ENV=github-pages
baseURL: https://inayet.github.io/masjidikhlas-v3/
```

### 🌐 Production Domain
```bash
# For production deployment with custom domain
HUGO_ENV=production
baseURL: https://masjidikhlas.org
```

### 🚂 Railway (Optional)
```bash
# For Railway deployment
HUGO_ENV=railways
baseURL: https://masjidikhlas.up.railway.app
```

## 🔧 How It Works

### Automatic Detection
The system automatically detects the environment:

1. **GitHub Actions**: Sets `HUGO_ENV=github-pages`
2. **Local Development**: Sets `HUGO_ENV=local`
3. **Production CI/CD**: Sets `HUGO_ENV=production`
4. **Railway**: Sets `HUGO_ENV=railways`

### Manual Override
You can manually set the environment:

```bash
# Override environment
export HUGO_ENV=production

# Use with just commands
HUGO_ENV=production just preview
```

## 📋 Configuration Files

### `site/environments.toml`
Defines baseURL for each environment:

```toml
[environments.local]
baseURL = "http://localhost:1313"

[environments.github-pages]
baseURL = "https://inayet.github.io/masjidikhlas-v3/"

[environments.production]
baseURL = "https://masjidikhlas.org"
```

### `scripts/set-env.sh`
Environment detection and configuration script:

```bash
# Detects environment automatically
# Sets HUGO_ENV and HUGO_BASEURL
# Used by all build commands
```

### `site/config.toml` & `site/hugo.toml`
Fallback configuration files with default values.

## 🛠️ Usage Examples

### Local Development
```bash
# Start development server (automatically uses local environment)
just start

# Manual environment setting
HUGO_ENV=local just start
```

### Production Preview
```bash
# Build with production settings
just preview

# Manual environment setting
HUGO_ENV=production just preview
```

### GitHub Pages Deployment
```bash
# Deploy to GitHub Pages (automatic in CI/CD)
just publish

# Manual environment setting
HUGO_ENV=github-pages just publish
```

## 🔄 Environment Switching

### For Custom Domain Setup
When setting up `masjidikhlas.org`:

1. **Update production environment** in `site/environments.toml`:
   ```toml
   [environments.production]
   baseURL = "https://masjidikhlas.org"
   ```

2. **Deploy with production environment**:
   ```bash
   HUGO_ENV=production just publish
   ```

3. **Update DNS** to point to GitHub Pages

### For Testing Different Environments
```bash
# Test production build locally
HUGO_ENV=production just start

# Test GitHub Pages build locally
HUGO_ENV=github-pages just preview

# Check current environment
source scripts/set-env.sh
echo "Environment: $HUGO_ENV"
echo "BaseURL: $HUGO_BASEURL"
```

## 🎯 Benefits

- ✅ **Automatic**: No manual baseURL changes needed
- ✅ **Flexible**: Works across different deployment platforms
- ✅ **Consistent**: Same configuration everywhere
- ✅ **Error-proof**: Prevents wrong baseURL in production
- ✅ **Developer-friendly**: Easy local development setup

## 🔍 Troubleshooting

### Wrong baseURL in Production
```bash
# Check environment detection
source scripts/set-env.sh

# Force correct environment
export HUGO_ENV=production
just preview
```

### CSS/Assets Not Loading
```bash
# Check if baseURL is correct
curl -s https://yoursite.com/ | grep stylesheet

# Should show correct domain in CSS link
```

### Local Development Issues
```bash
# Ensure local environment is set
export HUGO_ENV=local
just start

# Check baseURL
echo $HUGO_BASEURL
```

## 📚 Related Documentation

- [DEPLOYMENT.md](DEPLOYMENT.md) - Deployment instructions
- [DEVELOPMENT.md](DEVELOPMENT.md) - Development setup
- [justfile](justfile) - Available commands
- [scripts/set-env.sh](scripts/set-env.sh) - Environment script
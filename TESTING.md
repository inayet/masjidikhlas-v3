# Testing Guide for Masjid Ikhlas V3

This document describes the testing framework and procedures for the Masjid Ikhlas V3 website.

## 🧪 Test Suite Overview

The project includes a comprehensive testing framework with both script-based and Just-based testing:

### Script-Based Testing (scripts/)
Four main components in the `scripts/` directory:

### Just-Based Testing (Recommended)
Modern task runner integration for streamlined testing:

### 1. Build Tests (`scripts/test-build.sh`)
Tests build process and validates output files.

**What it tests:**
- Nix development environment setup
- Hugo build functionality
- Essential file generation
- HTML structure validity
- CSS and JavaScript assets
- Image files
- File sizes and optimization

**Usage:**
```bash
./scripts/test-build.sh
```

### 2. Simple Build Test (`scripts/test-build-simple.sh`)
Quick validation of core build functionality.

**What it tests:**
- Nix environment availability
- Hugo build process
- Output file generation

**Usage:**
```bash
./scripts/test-build-simple.sh
```

### 3. Content Validation (`scripts/validate-content.sh`)
Validates content structure, quality, and SEO elements.

**What it validates:**
- Content directory structure
- Required content files
- Front matter completeness
- Content quality and length
- Image references and availability
- Theme file structure
- Hugo configuration
- Internal link integrity
- SEO meta tags

**Usage:**
```bash
./scripts/validate-content.sh
```

### 4. Comprehensive Test Runner (`scripts/run-tests.sh`)
Runs all test suites and generates a unified report.

**Features:**
- Prerequisites checking
- Sequential test execution
- Comprehensive reporting
- Exit codes for CI/CD integration

**Usage:**
```bash
./scripts/run-tests.sh
```

## Just-Based Testing (Recommended)

### 1. Comprehensive Test Suite (`just test`)
Runs all tests with comprehensive reporting.

**Features:**
- All script-based tests integrated
- Enhanced error reporting
- CI/CD friendly output
- Performance metrics

**Usage:**
```bash
just test          # Full test suite
just t             # Short alias
```

### 2. Build Testing (`just test-build`)
Focuses specifically on build process validation.

**Usage:**
```bash
just test-build    # Build validation only
just tb            # Short alias
```

### 3. Content Testing (`just test-content`)
Validates content structure and quality.

**Usage:**
```bash
just test-content  # Content validation only
just tc            # Short alias
```

### 4. Quick Testing (`just test-quick`)
Fast validation for pre-commit checks.

**Usage:**
```bash
just test-quick    # Quick validation
just tq            # Short alias
```

### 5. Quality Checks
Additional quality assurance commands:

```bash
just check-all      # All quality checks
just quick-check    # Fast validation only
just lint           # Lint content
just check-links    # Check broken links
just seo-check      # SEO analysis
just performance-test # Performance testing
```

## Testing Workflow

### Pre-Commit Testing
```bash
just test-quick     # Fast validation
```

### Pre-Deployment Testing
```bash
just test           # Full test suite
```

### Continuous Integration
```bash
./scripts/run-tests.sh    # CI/CD integration
```

## Troubleshooting

### Common Issues
- **Permission denied**: Ensure scripts are executable (`chmod +x scripts/*.sh`)
- **Nix not found**: Install Nix package manager
- **Hugo not found**: Use `nix develop` or `just start`
- **Test failures**: Check individual test outputs for details

### Debug Commands
```bash
just doctor        # System health check
just status        # Project status
just deps          # Show dependencies
```

## Test Results Interpretation

### Exit Codes
- **0**: All tests passed
- **1**: One or more tests failed
- **2**: Prerequisites not met

### Performance Benchmarks
- **Build time**: < 100ms
- **Site size**: < 10MB
- **Page count**: 25 pages
- **Load time**: < 2 seconds

## Integration with Development Workflow

### Smart Testing
```bash
just smart test     # Context-aware testing
```

### Watch Mode
```bash
just watch          # Auto-test on changes
```

### Before Deployment
```bash
just test && just deploy    # Test then deploy
```

### 2. Content Validation (`validate-content.sh`)
Validates content structure, quality, and SEO elements.

**What it validates:**
- Content directory structure
- Required content files
- Front matter completeness
- Content quality and length
- Image references and availability
- Theme file structure
- Hugo configuration
- Internal link integrity
- SEO meta tags

**Usage:**
```bash
./validate-content.sh
```

### 3. Comprehensive Test Runner (`run-tests.sh`)
Runs all test suites and generates a unified report.

**Features:**
- Prerequisites checking
- Sequential test execution
- Comprehensive reporting
- Exit codes for CI/CD integration

**Usage:**
```bash
./run-tests.sh
```

## 🚀 Quick Testing Commands

### Run All Tests
```bash
./scripts/run-tests.sh
```

### Run Individual Test Suites
```bash
# Test build process only
./scripts/test-build.sh

# Quick build validation
./scripts/test-build-simple.sh

# Validate content only
./scripts/validate-content.sh
```

### Quick Validation
```bash
# Quick build test
./scripts/test-build-simple.sh

# Manual build test
nix shell nixpkgs#hugo --command bash -c 'cd site && hugo --destination ../public --gc --minify'

# Check essential files
ls -la public/index.html public/css/style.css public/js/script.js
```

## 📊 Test Categories

### Build Tests
| Test | Description | Expected Outcome |
|------|-------------|------------------|
| Nix Environment | Development shell loads correctly | ✅ Shell loads without errors |
| Hugo Build | Site builds successfully | ✅ 25 pages generated |
| Essential Files | Core files present | ✅ HTML, CSS, JS, images exist |
| HTML Validity | Basic HTML structure | ✅ DOCTYPE, html, head, body tags |
| Assets | CSS and JS files | ✅ Non-empty, properly formatted |
| Images | Image files | ✅ PNG/JPG files exist |
| File Sizes | Reasonable site size | ✅ < 10MB total |
| Workflow | Nix workflow command | ✅ Executes without errors |
| Docs | Documentation command | ✅ Shows help text |

### Content Validations
| Validation | Description | Expected Outcome |
|------------|-------------|------------------|
| Structure | Content directory | ✅ All required files exist |
| Front Matter | YAML metadata | ✅ Title, date fields present |
| Quality | Content length | ✅ Minimum 10 lines |
| Links | Internal links | ✅ No broken references |
| Images | Image references | ✅ All images exist |
| Theme | Template files | ✅ All layouts present |
| Config | Hugo configuration | ✅ Valid TOML syntax |
| SEO | Meta tags | ✅ Title, description present |

## 🔧 Integration with CI/CD

### GitHub Actions
The test suite can be integrated into GitHub Actions:

```yaml
- name: Run Tests
  run: |
    chmod +x ./scripts/run-tests.sh
    ./scripts/run-tests.sh
```

### Pre-commit Hook
Add to `.git/hooks/pre-commit`:

```bash
#!/bin/bash
./scripts/run-tests.sh
```

### Manual Testing Before Deployment
Always run tests before deploying:

```bash
# Full test suite
./scripts/run-tests.sh

# Quick validation
./scripts/test-build-simple.sh && ./scripts/validate-content.sh

# Build validation only
./scripts/test-build.sh
```

## 🐛 Troubleshooting

### Common Issues

#### Build Failures
- **Issue**: Hugo build fails
- **Solution**: Check content syntax, missing images, or invalid front matter
- **Command**: `./validate-content.sh` to identify issues

#### Permission Errors
- **Issue**: Permission denied errors
- **Solution**: Ensure scripts are executable: `chmod +x *.sh`

#### Missing Dependencies
- **Issue**: Nix or Hugo not found
- **Solution**: Install Nix and ensure flake is properly configured

#### Large Site Size
- **Issue**: Site size > 10MB
- **Solution**: Optimize images, minify assets, remove unused files

### Debug Mode
Run tests with verbose output:

```bash
bash -x ./scripts/test-build.sh
bash -x ./scripts/validate-content.sh
bash -x ./scripts/run-tests.sh
```

### Test Output Interpretation

#### ✅ PASSED
Test completed successfully, no issues found.

#### ❌ FAILED
Test failed, requires immediate attention before deployment.

#### ⚠️ WARNING
Test passed with warnings, should be addressed for better quality.

#### ℹ️ INFO
Informational message, no action required.

## 📈 Test Metrics

The test suite tracks:

- **Build Success Rate**: Percentage of successful builds
- **Content Quality Score**: Based on validations passed
- **Site Performance**: File sizes and optimization
- **SEO Compliance**: Meta tags and structure

## 🔄 Continuous Improvement

### Adding New Tests
1. Create test function in appropriate script
2. Add to test counter
3. Update documentation
4. Test the new test

### Test Maintenance
- Review test cases monthly
- Update for new Hugo versions
- Adjust thresholds as needed
- Keep documentation current

## 📞 Support

For testing issues:
1. Check this documentation
2. Run individual test suites
3. Review error messages
4. Check GitHub Issues
5. Contact development team

---

**Remember**: A passing test suite ensures a reliable, high-quality website deployment.
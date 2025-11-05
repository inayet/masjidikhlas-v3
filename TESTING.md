# Testing Guide for Masjid Ikhlas V3

This document describes the testing framework and procedures for the Masjid Ikhlas V3 website.

## 🧪 Test Suite Overview

The project includes a comprehensive testing framework with three main components:

### 1. Build Tests (`test-build.sh`)
Tests the build process and validates output files.

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
./test-build.sh
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
./run-tests.sh
```

### Run Individual Test Suites
```bash
# Test build process only
./test-build.sh

# Validate content only
./validate-content.sh
```

### Quick Validation
```bash
# Quick build test
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
    chmod +x ./run-tests.sh
    ./run-tests.sh
```

### Pre-commit Hook
Add to `.git/hooks/pre-commit`:

```bash
#!/bin/bash
./run-tests.sh
```

### Manual Testing Before Deployment
Always run tests before deploying:

```bash
# Full test suite
./run-tests.sh

# Quick validation
./test-build.sh && ./validate-content.sh
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
bash -x ./test-build.sh
bash -x ./validate-content.sh
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
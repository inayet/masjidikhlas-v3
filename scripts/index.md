# Scripts Index

This document provides a complete overview of all available scripts in the Masjid Ikhlas V3 project.

## 📁 Directory Structure

```
scripts/
├── README.md              # This file - scripts documentation
├── index.md              # Scripts index and overview
├── test-build.sh          # Comprehensive build testing
├── test-build-simple.sh   # Quick build validation
├── validate-content.sh    # Content quality validation
└── run-tests.sh          # Comprehensive test runner
```

## 🧪 Testing Scripts

### 1. `run-tests.sh` - Comprehensive Test Runner
**Purpose**: Execute all test suites with unified reporting
**Usage**: `./scripts/run-tests.sh`
**Features**:
- Prerequisites checking
- Sequential test execution
- Comprehensive reporting
- CI/CD integration ready
- Exit codes for automation

**Output**:
- Color-coded test results
- Pass/fail statistics
- Overall status summary

### 2. `test-build.sh` - Build Process Validation
**Purpose**: Test Hugo build process and validate output
**Usage**: `./scripts/test-build.sh`
**Tests**:
- Nix development environment
- Hugo build functionality
- Essential file generation
- HTML structure validity
- CSS and JavaScript assets
- Image files
- File sizes and optimization

**Output**:
- Detailed test results
- File validation
- Size analysis

### 3. `test-build-simple.sh` - Quick Build Validation
**Purpose**: Fast validation of core build functionality
**Usage**: `./scripts/test-build-simple.sh`
**Tests**:
- Nix environment availability
- Hugo build process
- Output file verification

**Output**:
- Simple pass/fail results
- Quick status check

### 4. `validate-content.sh` - Content Quality Validation
**Purpose**: Validate content structure, quality, and SEO elements
**Usage**: `./scripts/validate-content.sh`
**Validates**:
- Content directory structure
- Required content files
- Front matter completeness
- Content quality and length
- Image references and availability
- Theme file structure
- Hugo configuration
- Internal link integrity
- SEO meta tags

**Output**:
- Content statistics
- Validation results
- SEO analysis
- Quality metrics

## 🚀 Quick Start

### For Development
```bash
# Quick validation before committing
./scripts/test-build-simple.sh

# Full validation before deployment
./scripts/run-tests.sh
```

### For CI/CD
```bash
# GitHub Actions
- name: Run Tests
  run: |
    chmod +x ./scripts/run-tests.sh
    ./scripts/run-tests.sh

# Pre-commit hook
#!/bin/bash
./scripts/run-tests.sh
```

### For Just Users
```bash
# Comprehensive testing
just test

# Build testing only
just test-build

# Content validation only
just test-content

# Quick validation
just test-quick
```

## 📊 Test Categories

| Category | Scripts | Purpose | When to Use |
|----------|----------|---------|-------------|
| **Integration** | `run-tests.sh` | Full system validation | Before deployment, CI/CD |
| **Build** | `test-build.sh`, `test-build-simple.sh` | Build process validation | After code changes |
| **Content** | `validate-content.sh` | Content quality checks | Content updates |
| **Quick** | `test-build-simple.sh` | Fast validation | During development |

## 🔧 Script Features

### Common Features
- **Color-coded output**: Easy-to-read results
- **Error handling**: Graceful failure handling
- **Exit codes**: CI/CD compatible
- **Verbose mode**: Debug with `bash -x`
- **Cross-platform**: Works on Linux, macOS, Windows (WSL)

### Output Colors
- 🟢 **Green**: Success/PASS
- 🔴 **Red**: Failure/FAIL
- 🟡 **Yellow**: Warning/WARN
- 🔵 **Blue**: Information/INFO

### Exit Codes
- **0**: All tests passed
- **1**: Some tests failed
- **2**: Critical error (missing files, etc.)

## 🐛 Troubleshooting

### Permission Issues
```bash
# Make all scripts executable
chmod +x scripts/*.sh

# Check individual script
ls -la scripts/
```

### Debug Mode
```bash
# Run with verbose output
bash -x scripts/run-tests.sh
bash -x scripts/test-build.sh
bash -x scripts/validate-content.sh
```

### Common Issues
| Issue | Solution |
|--------|----------|
| `Permission denied` | Run `chmod +x scripts/*.sh` |
| `Command not found` | Check script path and permissions |
| `Tests fail` | Check Nix installation and project structure |
| `Build errors` | Validate content syntax and image paths |

## 📝 Development Guidelines

### Adding New Tests
1. Create test function in appropriate script
2. Add to test counter
3. Update documentation
4. Test new functionality
5. Update this index

### Script Maintenance
- Review test cases monthly
- Update for new Hugo versions
- Adjust thresholds as needed
- Keep documentation current

### Best Practices
- Use consistent error handling
- Provide clear output messages
- Include helpful error descriptions
- Maintain cross-platform compatibility
- Document all functions and options

## 📚 Related Documentation

- **[TESTING.md](../TESTING.md)**: Comprehensive testing guide
- **[DEVELOPMENT.md](../DEVELOPMENT.md)**: Development setup and workflow
- **[DEPLOYMENT.md](../DEPLOYMENT.md)**: Deployment procedures
- **[README.md](../README.md)**: Project overview and commands

## 🔗 External Links

- **Live Site**: https://inayet.github.io/masjidikhlas-v3/
- **Repository**: https://github.com/inayet/masjidikhlas-v3
- **GitHub Actions**: https://github.com/inayet/masjidikhlas-v3/actions

---

**Last Updated**: November 5, 2025  
**Version**: 1.0  
**Maintainer**: Masjid Ikhlas Development Team
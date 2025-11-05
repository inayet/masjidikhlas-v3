# Scripts Directory

This directory contains all utility and testing scripts for Masjid Ikhlas V3.

## 🧪 Testing Scripts

### `test-build.sh`
**Purpose**: Comprehensive build testing and validation
**Usage**: `./scripts/test-build.sh`
**Tests**:
- Nix development environment
- Hugo build process
- Essential file generation
- HTML structure validity
- CSS and JavaScript assets
- Image files
- File sizes and optimization

### `test-build-simple.sh`
**Purpose**: Quick build validation
**Usage**: `./scripts/test-build-simple.sh`
**Tests**:
- Nix environment
- Hugo build
- Output file verification

### `validate-content.sh`
**Purpose**: Content structure and quality validation
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

### `run-tests.sh`
**Purpose**: Comprehensive test runner
**Usage**: `./scripts/run-tests.sh`
**Features**:
- Prerequisites checking
- Sequential test execution
- Comprehensive reporting
- Exit codes for CI/CD integration

## 🚀 Quick Commands

```bash
# Run all tests
./scripts/run-tests.sh

# Quick validation
./scripts/test-build-simple.sh

# Build testing only
./scripts/test-build.sh

# Content validation only
./scripts/validate-content.sh
```

## 🔧 Integration

### GitHub Actions
Add to workflow:
```yaml
- name: Run Tests
  run: |
    chmod +x ./scripts/run-tests.sh
    ./scripts/run-tests.sh
```

### Pre-commit Hook
```bash
#!/bin/bash
./scripts/run-tests.sh
```

## 📊 Test Categories

| Category | Scripts | Purpose |
|-----------|----------|---------|
| Build | `test-build.sh`, `test-build-simple.sh` | Validate build process |
| Content | `validate-content.sh` | Validate content quality |
| Integration | `run-tests.sh` | Run all tests with reporting |

## 🐛 Troubleshooting

### Permission Issues
```bash
chmod +x scripts/*.sh
```

### Debug Mode
```bash
bash -x scripts/test-build.sh
bash -x scripts/validate-content.sh
```

### Individual Test Execution
```bash
# Test specific functionality
nix shell nixpkgs#hugo --command bash -c 'cd site && hugo --destination ../public --gc --minify'
```

## 📝 Notes

- All scripts are executable by default
- Scripts use consistent error handling and reporting
- Color-coded output for easy reading
- Exit codes for CI/CD integration
- Comprehensive logging and debugging support
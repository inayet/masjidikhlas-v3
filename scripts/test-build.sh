#!/usr/bin/env bash

# Masjid Ikhlas V3 - Build Test Script
# Tests all build commands and validates output

set -euo pipefail

echo "🕌 Masjid Ikhlas V3 - Build Test Suite"
echo "======================================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test counter
TESTS_PASSED=0
TESTS_FAILED=0

# Function to run a test
run_test() {
    local test_name="$1"
    local test_command="$2"
    
    echo -e "\n${YELLOW}Testing: $test_name${NC}"
    echo "Command: $test_command"
    
    if eval "$test_command" > /dev/null 2>&1; then
        echo -e "${GREEN}✅ PASSED${NC}"
        ((TESTS_PASSED++))
        return 0
    else
        echo -e "${RED}❌ FAILED${NC}"
        ((TESTS_FAILED++))
        return 1
    fi
}

# Function to validate Hugo build
validate_hugo_build() {
    echo -e "\n${YELLOW}Validating Hugo build output...${NC}"
    
    # Check if public directory exists
    if [[ ! -d "public" ]]; then
        echo -e "${RED}❌ public directory not found${NC}"
        return 1
    fi
    
    # Check for essential files
    local essential_files=(
        "public/index.html"
        "public/css/style.css"
        "public/js/script.js"
        "public/images/logo.png"
        "public/sitemap.xml"
    )
    
    for file in "${essential_files[@]}"; do
        if [[ ! -f "$file" ]]; then
            echo -e "${RED}❌ Missing essential file: $file${NC}"
            return 1
        fi
    done
    
    # Check for all content pages
    local content_pages=(
        "public/about/index.html"
        "public/contact/index.html"
        "public/donate/index.html"
        "public/services/index.html"
        "public/monthly-prayer-schedule/index.html"
        "public/ikhlas-academy/index.html"
        "public/ikhlas-youth-department/index.html"
        "public/outreach-department/index.html"
        "public/events/index.html"
    )
    
    for page in "${content_pages[@]}"; do
        if [[ ! -f "$page" ]]; then
            echo -e "${RED}❌ Missing content page: $page${NC}"
            return 1
        fi
    done
    
    echo -e "${GREEN}✅ All essential files and pages present${NC}"
    return 0
}

# Function to test HTML validity
test_html_validity() {
    echo -e "\n${YELLOW}Testing HTML validity...${NC}"
    
    # Check if index.html is valid HTML (basic check)
    if grep -q "<!DOCTYPE html>" public/index.html && \
       grep -q "<html" public/index.html && \
       grep -q "</html>" public/index.html; then
        echo -e "${GREEN}✅ Basic HTML structure valid${NC}"
        return 0
    else
        echo -e "${RED}❌ HTML structure invalid${NC}"
        return 1
    fi
}

# Function to test CSS and JS
test_assets() {
    echo -e "\n${YELLOW}Testing CSS and JavaScript...${NC}"
    
    # Check CSS file
    if [[ -f "public/css/style.css" ]] && [[ -s "public/css/style.css" ]]; then
        echo -e "${GREEN}✅ CSS file exists and not empty${NC}"
    else
        echo -e "${RED}❌ CSS file missing or empty${NC}"
        return 1
    fi
    
    # Check JS file
    if [[ -f "public/js/script.js" ]] && [[ -s "public/js/script.js" ]]; then
        echo -e "${GREEN}✅ JavaScript file exists and not empty${NC}"
    else
        echo -e "${RED}❌ JavaScript file missing or empty${NC}"
        return 1
    fi
    
    return 0
}

# Function to test images
test_images() {
    echo -e "\n${YELLOW}Testing images...${NC}"
    
    local images=(
        "public/images/logo.png"
        "public/images/mosque-hero.jpg"
    )
    
    for img in "${images[@]}"; do
        if [[ -f "$img" ]] && [[ -s "$img" ]]; then
            echo -e "${GREEN}✅ Image exists: $(basename $img)${NC}"
        else
            echo -e "${RED}❌ Image missing or empty: $(basename $img)${NC}"
            return 1
        fi
    done
    
    return 0
}

# Clean up previous build
echo -e "\n${YELLOW}Cleaning up previous build...${NC}"
rm -rf public

# Test 1: Nix development environment
run_test "Nix development environment" "nix develop --command echo 'OK'"

# Test 2: Hugo build directly
run_test "Hugo build (direct)" "nix shell nixpkgs#hugo --command bash -c 'cd site && hugo --destination ../public --gc --minify'"

# Test 3: Validate Hugo build output
if validate_hugo_build; then
    ((TESTS_PASSED++))
else
    ((TESTS_FAILED++))
fi

# Test 4: HTML validity
if test_html_validity; then
    ((TESTS_PASSED++))
else
    ((TESTS_FAILED++))
fi

# Test 5: Assets
if test_assets; then
    ((TESTS_PASSED++))
else
    ((TESTS_FAILED++))
fi

# Test 6: Images
if test_images; then
    ((TESTS_PASSED++))
else
    ((TESTS_FAILED++))
fi

# Test 7: Nix workflow command
run_test "Nix workflow command" "nix run .#workflow"

# Test 8: Nix docs command
run_test "Nix docs command" "nix run .#docs"

# Test 9: Check file sizes
echo -e "\n${YELLOW}Checking file sizes...${NC}"
total_size=$(du -sh public | cut -f1)
echo "Total site size: $total_size"

if [[ $(du -s public | cut -f1) -lt 10000 ]]; then  # Less than 10MB
    echo -e "${GREEN}✅ Site size reasonable ($total_size)${NC}"
    ((TESTS_PASSED++))
else
    echo -e "${YELLOW}⚠️  Site size large ($total_size)${NC}"
    ((TESTS_PASSED++))  # Still count as pass, just a warning
fi

# Final results
echo -e "\n======================================"
echo -e "🕌 Masjid Ikhlas V3 - Test Results"
echo -e "======================================"
echo -e "${GREEN}Tests Passed: $TESTS_PASSED${NC}"
echo -e "${RED}Tests Failed: $TESTS_FAILED${NC}"
echo -e "Total Tests: $((TESTS_PASSED + TESTS_FAILED))"

if [[ $TESTS_FAILED -eq 0 ]]; then
    echo -e "\n${GREEN}🎉 All tests passed! Build is ready for deployment.${NC}"
    exit 0
else
    echo -e "\n${RED}❌ Some tests failed. Please review the issues above.${NC}"
    exit 1
fi
#!/usr/bin/env bash

# Masjid Ikhlas V3 - Content Validation Script
# Validates content structure and quality

set -euo pipefail

echo "🕌 Masjid Ikhlas V3 - Content Validation"
echo "======================================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Validation counters
VALIDATIONS_PASSED=0
VALIDATIONS_FAILED=0
WARNINGS=0

# Function to report validation
report_validation() {
    local status="$1"
    local message="$2"
    local details="${3:-}"
    
    case "$status" in
        "PASS")
            echo -e "${GREEN}✅ $message${NC}"
            ((VALIDATIONS_PASSED++))
            ;;
        "FAIL")
            echo -e "${RED}❌ $message${NC}"
            if [[ -n "$details" ]]; then
                echo -e "   $details"
            fi
            ((VALIDATIONS_FAILED++))
            ;;
        "WARN")
            echo -e "${YELLOW}⚠️  $message${NC}"
            if [[ -n "$details" ]]; then
                echo -e "   $details"
            fi
            ((WARNINGS++))
            ;;
        "INFO")
            echo -e "${BLUE}ℹ️  $message${NC}"
            ;;
    esac
}

# Function to validate front matter
validate_front_matter() {
    local file="$1"
    local required_fields=("title" "date")
    
    # Check if file has front matter
    if ! grep -q "^---" "$file"; then
        report_validation "WARN" "Missing front matter" "$file"
        return 1
    fi
    
    # Check for required fields
    for field in "${required_fields[@]}"; do
        if ! grep -q "^$field:" "$file"; then
            report_validation "WARN" "Missing front matter field: $field" "$file"
        fi
    done
    
    return 0
}

# Function to check content quality
check_content_quality() {
    local file="$1"
    local content_lines=$(wc -l < "$file")
    
    # Check minimum content length
    if [[ $content_lines -lt 10 ]]; then
        report_validation "WARN" "Very short content" "$file ($content_lines lines)"
    fi
    
    # Check for common issues
    if grep -q "TODO\|FIXME\|XXX" "$file"; then
        report_validation "WARN" "Contains TODO/FIXME markers" "$file"
    fi
    
    # Check for broken markdown links
    if grep -q "\[.*\]()" "$file"; then
        report_validation "WARN" "Empty markdown links found" "$file"
    fi
}

# Function to validate images
validate_images() {
    local file="$1"
    
    # Extract image references
    local images=$(grep -o '!\[.*\]([^)]*)' "$file" || true)
    
    if [[ -n "$images" ]]; then
        echo "$images" | while read -r img; do
            # Extract image path
            local img_path=$(echo "$img" | sed 's/!\[.*\](//' | sed 's/).*//')
            
            # Skip external images
            if [[ "$img_path" =~ ^https?:// ]]; then
                continue
            fi
            
            # Check if image exists
            local full_path="site/themes/ikhlas/static/$img_path"
            if [[ ! -f "$full_path" ]]; then
                report_validation "FAIL" "Missing image file" "$img_path referenced in $file"
            fi
        done
    fi
}

# Start validation
echo -e "\n${BLUE}📁 Validating content structure...${NC}"

# Check content directory exists
if [[ -d "site/content" ]]; then
    report_validation "PASS" "Content directory exists"
else
    report_validation "FAIL" "Content directory missing"
    exit 1
fi

# Check for required content files
required_content=(
    "site/content/_index.md"
    "site/content/about/_index.md"
    "site/content/contact/_index.md"
    "site/content/donate/_index.md"
    "site/content/services/_index.md"
    "site/content/monthly-prayer-schedule/_index.md"
    "site/content/ikhlas-academy/_index.md"
    "site/content/ikhlas-youth-department/_index.md"
    "site/content/outreach-department/_index.md"
    "site/content/events/_index.md"
)

for content_file in "${required_content[@]}"; do
    if [[ -f "$content_file" ]]; then
        report_validation "PASS" "Content file exists" "$(basename $content_file)"
    else
        report_validation "FAIL" "Required content file missing" "$content_file"
    fi
done

echo -e "\n${BLUE}📝 Validating content quality...${NC}"

# Validate each content file
find site/content -name "*.md" -type f | while read -r file; do
    echo -e "\n${YELLOW}Validating: $file${NC}"
    
    validate_front_matter "$file"
    check_content_quality "$file"
    validate_images "$file"
done

echo -e "\n${BLUE}🎨 Validating theme files...${NC}"

# Check theme structure
theme_files=(
    "site/themes/ikhlas/layouts/index.html"
    "site/themes/ikhlas/layouts/_default/baseof.html"
    "site/themes/ikhlas/layouts/_default/single.html"
    "site/themes/ikhlas/layouts/_default/list.html"
    "site/themes/ikhlas/layouts/partials/header.html"
    "site/themes/ikhlas/layouts/partials/footer.html"
    "site/themes/ikhlas/static/css/style.css"
    "site/themes/ikhlas/static/js/script.js"
)

for theme_file in "${theme_files[@]}"; do
    if [[ -f "$theme_file" ]]; then
        report_validation "PASS" "Theme file exists" "$(basename $theme_file)"
    else
        report_validation "FAIL" "Theme file missing" "$theme_file"
    fi
done

echo -e "\n${BLUE}⚙️  Validating configuration...${NC}"

# Check Hugo configuration
if [[ -f "site/hugo.toml" ]]; then
    report_validation "PASS" "Hugo configuration exists"
    
    # Check for essential config
    if grep -q "title" site/hugo.toml; then
        report_validation "PASS" "Site title configured"
    else
        report_validation "WARN" "Site title missing"
    fi
    
    if grep -q "baseURL" site/hugo.toml; then
        report_validation "PASS" "Base URL configured"
    else
        report_validation "WARN" "Base URL missing"
    fi
else
    report_validation "FAIL" "Hugo configuration missing"
fi

echo -e "\n${BLUE}🔍 Checking for common issues...${NC}"

# Check for broken internal links
echo "Checking internal links..."
find site/content -name "*.md" -exec grep -l "\[.*\]([^h].*)" {} \; | while read -r file; do
    grep -o "\[.*\]([^h].*)" "$file" | while read -r link; do
        # Extract link path
        local link_path=$(echo "$link" | sed 's/\[.*\](//' | sed 's/).*//')
        
        # Skip external links and anchors
        if [[ "$link_path" =~ ^https?:// ]] || [[ "$link_path" =~ ^# ]]; then
            continue
        fi
        
        # Check if linked file exists
        if [[ "$link_path" =~ \.md$ ]]; then
            local full_path="site/content/$link_path"
            if [[ ! -f "$full_path" ]]; then
                report_validation "WARN" "Broken internal link" "$link_path in $file"
            fi
        fi
    done
done

# Check for SEO basics
echo "Checking SEO elements..."
if [[ -f "site/themes/ikhlas/layouts/_default/baseof.html" ]]; then
    if grep -q "<title>" site/themes/ikhlas/layouts/_default/baseof.html; then
        report_validation "PASS" "Title tag present"
    else
        report_validation "WARN" "Title tag missing"
    fi
    
    if grep -q "meta.*description" site/themes/ikhlas/layouts/_default/baseof.html; then
        report_validation "PASS" "Meta description present"
    else
        report_validation "WARN" "Meta description missing"
    fi
fi

echo -e "\n${BLUE}📊 Content Statistics...${NC}"

# Generate content statistics
total_pages=$(find site/content -name "*.md" | wc -l)
total_words=$(find site/content -name "*.md" -exec wc -w {} \; | tail -1 | awk '{print $1}')
total_size=$(du -sh site/content | cut -f1)

report_validation "INFO" "Total pages: $total_pages"
report_validation "INFO" "Total words: $total_words"
report_validation "INFO" "Content size: $total_size"

# Final results
echo -e "\n======================================"
echo -e "🕌 Masjid Ikhlas V3 - Validation Results"
echo -e "======================================"
echo -e "${GREEN}Validations Passed: $VALIDATIONS_PASSED${NC}"
echo -e "${RED}Validations Failed: $VALIDATIONS_FAILED${NC}"
echo -e "${YELLOW}Warnings: $WARNINGS${NC}"

if [[ $VALIDATIONS_FAILED -eq 0 ]]; then
    echo -e "\n${GREEN}🎉 Content validation passed!${NC}"
    if [[ $WARNINGS -gt 0 ]]; then
        echo -e "${YELLOW}⚠️  Consider addressing the warnings above for better quality.${NC}"
    fi
    exit 0
else
    echo -e "\n${RED}❌ Content validation failed. Please fix the issues above.${NC}"
    exit 1
fi
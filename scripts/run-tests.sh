#!/usr/bin/env bash

# Masjid Ikhlas V3 - Comprehensive Test Runner
# Runs all tests and generates a report

set -euo pipefail

echo "🕌 Masjid Ikhlas V3 - Comprehensive Test Suite"
echo "=============================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test results
BUILD_TESTS_PASSED=0
BUILD_TESTS_FAILED=0
CONTENT_VALIDATIONS_PASSED=0
CONTENT_VALIDATIONS_FAILED=0
OVERALL_STATUS="PASS"

# Function to run test suite
run_test_suite() {
    local suite_name="$1"
    local script="$2"
    
    echo -e "\n${BLUE}🧪 Running $suite_name...${NC}"
    echo "=============================================="
    
    if bash "$script"; then
        echo -e "\n${GREEN}✅ $suite_name PASSED${NC}"
        return 0
    else
        echo -e "\n${RED}❌ $suite_name FAILED${NC}"
        return 1
    fi
}

# Function to generate report
generate_report() {
    echo -e "\n=============================================="
    echo -e "🕌 Masjid Ikhlas V3 - Test Report"
    echo -e "=============================================="
    
    echo -e "\n${BLUE}📊 Build Tests:${NC}"
    echo -e "   Passed: ${GREEN}$BUILD_TESTS_PASSED${NC}"
    echo -e "   Failed: ${RED}$BUILD_TESTS_FAILED${NC}"
    
    echo -e "\n${BLUE}📝 Content Validations:${NC}"
    echo -e "   Passed: ${GREEN}$CONTENT_VALIDATIONS_PASSED${NC}"
    echo -e "   Failed: ${RED}$CONTENT_VALIDATIONS_FAILED${NC}"
    
    local total_passed=$((BUILD_TESTS_PASSED + CONTENT_VALIDATIONS_PASSED))
    local total_failed=$((BUILD_TESTS_FAILED + CONTENT_VALIDATIONS_FAILED))
    
    echo -e "\n${BLUE}📈 Overall Results:${NC}"
    echo -e "   Total Passed: ${GREEN}$total_passed${NC}"
    echo -e "   Total Failed: ${RED}$total_failed${NC}"
    
    if [[ $total_failed -eq 0 ]]; then
        echo -e "\n${GREEN}🎉 ALL TESTS PASSED!${NC}"
        echo -e "${GREEN}   Build is ready for deployment.${NC}"
        OVERALL_STATUS="PASS"
    else
        echo -e "\n${RED}❌ SOME TESTS FAILED!${NC}"
        echo -e "${RED}   Please review and fix issues before deployment.${NC}"
        OVERALL_STATUS="FAIL"
    fi
}

# Function to check prerequisites
check_prerequisites() {
    echo -e "\n${BLUE}🔍 Checking prerequisites...${NC}"
    
    # Check if required commands are available
    local required_commands=("nix" "bash")
    
    for cmd in "${required_commands[@]}"; do
        if command -v "$cmd" &> /dev/null; then
            echo -e "${GREEN}✅ $cmd available${NC}"
        else
            echo -e "${RED}❌ $cmd not found${NC}"
            exit 1
        fi
    done
    
    # Check if test scripts exist
    local test_scripts=("test-build.sh" "validate-content.sh")
    
    for script in "${test_scripts[@]}"; do
        if [[ -f "$script" ]] && [[ -x "$script" ]]; then
            echo -e "${GREEN}✅ $script available and executable${NC}"
        else
            echo -e "${RED}❌ $script missing or not executable${NC}"
            exit 1
        fi
    done
    
    # Check if project structure is correct
    if [[ -d "site" ]] && [[ -f "flake.nix" ]]; then
        echo -e "${GREEN}✅ Project structure correct${NC}"
    else
        echo -e "${RED}❌ Invalid project structure${NC}"
        exit 1
    fi
}

# Main execution
main() {
    # Check prerequisites
    check_prerequisites
    
    # Run build tests
    echo -e "\n${YELLOW}🏗️  Running Build Tests${NC}"
    if run_test_suite "Build Tests" "./test-build.sh"; then
        BUILD_TESTS_PASSED=1
    else
        BUILD_TESTS_FAILED=1
    fi
    
    # Run content validation
    echo -e "\n${YELLOW}📝 Running Content Validation${NC}"
    if run_test_suite "Content Validation" "./validate-content.sh"; then
        CONTENT_VALIDATIONS_PASSED=1
    else
        CONTENT_VALIDATIONS_FAILED=1
    fi
    
    # Generate final report
    generate_report
    
    # Exit with appropriate code
    if [[ "$OVERALL_STATUS" == "PASS" ]]; then
        exit 0
    else
        exit 1
    fi
}

# Run main function
main "$@"
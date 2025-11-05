#!/usr/bin/env bash

# Masjid Ikhlas V3 - Repository Setup Script
# This script helps customize the repository for your organization

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🕌 Masjid Ikhlas V3 - Repository Setup${NC}"
echo "=========================================="
echo

# Function to prompt for input
prompt_input() {
    local prompt="$1"
    local default="$2"
    local var_name="$3"
    
    if [[ -n "$default" ]]; then
        read -p "$prompt [$default]: " input
        if [[ -z "$input" ]]; then
            input="$default"
        fi
    else
        read -p "$prompt: " input
    fi
    
    printf -v "$var_name" '%s' "$input"
}

# Function to update config file
update_config() {
    local file="$1"
    local search="$2"
    local replace="$3"
    
    if [[ -f "$file" ]]; then
        sed -i "s|$search|$replace|g" "$file"
        echo -e "${GREEN}✅ Updated $file${NC}"
    else
        echo -e "${RED}❌ File not found: $file${NC}"
    fi
}

echo -e "${YELLOW}📝 This script will help you customize the repository for your organization.${NC}"
echo -e "${YELLOW}📝 Press Enter to use the default values.${NC}"
echo

# Collect organization information
echo -e "${BLUE}🏢 Organization Information${NC}"
echo "------------------------"

prompt_input "Organization name" "Masjid Ikhlas" ORG_NAME
prompt_input "Organization description" "Metropolitan Denver North Islamic Center - Masjid Ikhlas is committed to Islamic way of life based on Qur'an and life example of Prophet Muhammad (Peace be upon him)" ORG_DESCRIPTION
prompt_input "Contact email" "office@masjidikhlas.org" CONTACT_EMAIL
prompt_input "Phone number" "303-920-0252" PHONE
prompt_input "Address" "11141 N Irma Drive, Northglenn, CO 80233, USA" ADDRESS

echo
echo -e "${BLUE}🌐 GitHub Repository Information${NC}"
echo "--------------------------------"

prompt_input "GitHub username" "inayet" GITHUB_USERNAME
prompt_input "Repository name" "masjidikhlas-v3" REPO_NAME

echo
echo -e "${BLUE}📱 Social Media Information${NC}"
echo "---------------------------"

prompt_input "Facebook handle" "masjidikhlasco" FACEBOOK
prompt_input "Instagram handle" "masjidikhlasco" INSTAGRAM
prompt_input "Twitter handle" "masjidikhlasco" TWITTER
prompt_input "YouTube channel ID" "UC8tPOcewvQp80xQWSsUgauQ" YOUTUBE

echo
echo -e "${BLUE}🔧 Applying Configuration${NC}"
echo "----------------------------"

# Calculate base URL
BASE_URL="https://$GITHUB_USERNAME.github.io/$REPO_NAME"

# Update Hugo configuration
echo -e "${YELLOW}📝 Updating Hugo configuration...${NC}"

if [[ -f "site/hugo.toml.template" ]]; then
    cp site/hugo.toml.template site/hugo.toml
    echo -e "${GREEN}✅ Created site/hugo.toml from template${NC}"
fi

update_config "site/hugo.toml" "Your Masjid/Organization Name" "$ORG_NAME"
update_config "site/hugo.toml" "https://your-username.github.io/your-repo-name" "$BASE_URL"
update_config "site/hugo.toml" "Your masjid/organization description - Brief overview of your mission and purpose" "$ORG_DESCRIPTION"
update_config "site/hugo.toml" "contact@yourorganization.org" "$CONTACT_EMAIL"
update_config "site/hugo.toml" "+1-555-0123" "$PHONE"
update_config "site/hugo.toml" "123 Main Street, City, State 12345, USA" "$ADDRESS"
update_config "site/hugo.toml" "yourorganization" "$FACEBOOK"
update_config "site/hugo.toml" "yourorganization" "$INSTAGRAM"
update_config "site/hugo.toml" "yourorganization" "$TWITTER"
update_config "site/hugo.toml" "YOUR_CHANNEL_ID" "$YOUTUBE"

# Update environments.toml
echo -e "${YELLOW}🔄 Updating environments configuration...${NC}"
update_config "site/environments.toml" "https://inayet.github.io/masjidikhlas-v3" "$BASE_URL"
update_config "site/environments.toml" "https://masjidikhlas.org" "https://${REPO_NAME}.org"
update_config "site/environments.toml" "https://testuser.github.io/test-mosque-site" "$BASE_URL"
update_config "site/environments.toml" "https://test-community-site.org" "https://${REPO_NAME}.org"
update_config "site/environments.toml" "https://masjidikhlas-v3.org" "https://${REPO_NAME}.org"
update_config "site/environments.toml" "https://masjidikhlas.up.railway.app" "https://${REPO_NAME}.up.railway.app"
update_config "site/environments.toml" "https://masjidikhlas-v3.up.railway.app" "https://${REPO_NAME}.up.railway.app"
echo -e "${GREEN}✅ Environments configuration updated${NC}"

# Update GitHub Actions workflow
echo -e "${YELLOW}🔄 Updating GitHub Actions workflow...${NC}"
# The workflow now uses automatic URL detection, so no changes needed
echo -e "${GREEN}✅ GitHub Actions workflow updated (uses automatic URL detection)${NC}"

# Update README.md
echo -e "${YELLOW}📖 Updating README.md...${NC}"
update_config "README.md" "git clone https://github.com/inayet/masjidikhlas-v3.git" "git clone https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"
update_config "README.md" "cd masjidikhlas-v3" "cd $REPO_NAME"
update_config "README.md" "inayet.github.io/masjidikhlas-v3" "$GITHUB_USERNAME.github.io/$REPO_NAME"
update_config "README.md" "Masjid Ikhlas" "$ORG_NAME"

# Update other documentation files
echo -e "${YELLOW}📚 Updating documentation files...${NC}"

# Update deployment documentation
update_config "DEPLOYMENT.md" "inayet.github.io/masjidikhlas-v3" "$GITHUB_USERNAME.github.io/$REPO_NAME"
update_config "DEPLOYMENT.md" "masjidikhlas.org" "${REPO_NAME}.org"

# Update AGENTS.md
update_config "AGENTS.md" "https://inayet.github.io/masjidikhlas-v3/" "$BASE_URL/"

# Update DEPLOYMENT_SUMMARY.md
update_config "DEPLOYMENT_SUMMARY.md" "https://inayet.github.io/masjidikhlas-v3/" "$BASE_URL/"

# Update ORGANIZATION_SUMMARY.md
update_config "ORGANIZATION_SUMMARY.md" "https://inayet.github.io/masjidikhlas-v3/" "$BASE_URL/"

# Update scripts/index.md
update_config "scripts/index.md" "https://inayet.github.io/masjidikhlas-v3/" "$BASE_URL/"
update_config "scripts/index.md" "https://github.com/inayet/masjidikhlas-v3" "https://github.com/$GITHUB_USERNAME/$REPO_NAME"
update_config "scripts/index.md" "https://github.com/inayet/masjidikhlas-v3/actions" "https://github.com/$GITHUB_USERNAME/$REPO_NAME/actions"

# Update site/config.toml (if exists)
if [[ -f "site/config.toml" ]]; then
    update_config "site/config.toml" "https://inayet.github.io/masjidikhlas-v3" "$BASE_URL"
    update_config "site/config.toml" "https://masjidikhlas.org" "${REPO_NAME}.org"
fi

# Update content files
echo -e "${YELLOW}📝 Updating content files...${NC}"

# Update contact information in content files
find site/content -name "*.md" -exec sed -i "s|office@masjidikhlas.org|$CONTACT_EMAIL|g" {} \;
find site/content -name "*.md" -exec sed -i "s|youth@masjidikhlas.org|youth@$CONTACT_EMAIL|g" {} \;
find site/content -name "*.md" -exec sed -i "s|outreach@masjidikhlas.org|outreach@$CONTACT_EMAIL|g" {} \;
find site/content -name "*.md" -exec sed -i "s|ikhlasacademy@masjidikhlas.org|academy@$CONTACT_EMAIL|g" {} \;

# Update social media links
find site/content -name "*.md" -exec sed -i "s|@masjidikhlasco|@$INSTAGRAM|g" {} \;
find site/content -name "*.md" -exec sed -i "s|/masjidikhlasco|/$FACEBOOK|g" {} \;
find site/content -name "*.md" -exec sed -i "s|@masjidikhlasco|@$TWITTER|g" {} \;

# Update organization name in content
find site/content -name "*.md" -exec sed -i "s|Masjid Ikhlas|$ORG_NAME|g" {} \;

# Update hardcoded URLs in content
find site/content -name "*.md" -exec sed -i "s|www\.masjidikhlas\.org|www.${REPO_NAME}.org|g" {} \;
find site/content -name "*.md" -exec sed -i "s|masjidikhlas\.org@gmail\.com|${REPO_NAME}@gmail.com|g" {} \;

echo -e "${GREEN}✅ Content files updated${NC}"

echo
# Commit the changes
echo -e "${YELLOW}💾 Committing configuration changes...${NC}"
git add .
git commit -m "feat: Customize repository for $ORG_NAME

- Organization: $ORG_NAME
- Base URL: $BASE_URL
- Contact: $CONTACT_EMAIL
- Repository: https://github.com/$GITHUB_USERNAME/$REPO_NAME
- Generated by setup script on $(date '+%Y-%m-%d %H:%M:%S')

All configuration files, documentation, and content have been updated
with organization-specific information for deployment.

Note: Generated files (site/public/, build-cache/, etc.) are automatically
excluded by .gitignore and not committed." || echo -e "${YELLOW}⚠️  No changes to commit (already configured)${NC}"

echo
echo -e "${BLUE}🎉 Setup Complete!${NC}"
echo "===================="
echo
echo -e "${GREEN}✅ Repository customized for: $ORG_NAME${NC}"
echo -e "${GREEN}✅ Base URL: $BASE_URL${NC}"
echo -e "${GREEN}✅ Contact: $CONTACT_EMAIL${NC}"
echo -e "${GREEN}✅ Changes committed to git${NC}"
echo
echo -e "${YELLOW}📋 Next Steps:${NC}"
echo "1. Review the updated files, especially site/hugo.toml"
echo "2. Customize the content in site/content/ directory"
echo "3. Replace the logo in site/themes/ikhlas/static/images/"
echo "4. Test locally: just start"
echo "5. Deploy when ready: just deploy"
echo
echo -e "${YELLOW}📚 Important Notes:${NC}"
echo "- The GitHub Actions workflow now automatically detects your repository URL"
echo "- Make sure your repository is public for GitHub Pages to work"
echo "- Update your DNS settings if using a custom domain"
echo "- Review all content files for organization-specific information"
echo "- All changes have been committed to git automatically"
echo
echo -e "${BLUE}🚀 Ready to get started? Run: just start${NC}"
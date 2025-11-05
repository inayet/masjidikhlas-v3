# Add this to your ~/.zshrc or ~/.bashrc

# Smart navigation to Masjid Ikhlas project
cdmasjid() {
    local PROJECT_DIR="/home/inayet/Documents/masjidikhlasV3"
    
    # Save current branch if we're in a git repo
    if [[ -d ".git" ]]; then
        git branch --show-current > ~/.last_masjid_branch
    fi
    
    # Navigate to project
    cd "$PROJECT_DIR"
    
    # Restore last branch if it exists
    if [[ -f ~/.last_masjid_branch ]]; then
        local last_branch=$(cat ~/.last_masjid_branch)
        if git rev-parse --verify "$last_branch" >/dev/null 2>&1; then
            git checkout "$last_branch" 2>/dev/null
            echo "🌿 Restored branch: $last_branch"
        fi
    fi
    
    echo "📍 Masjid Ikhlas V3 - $(git branch --show-current)"
}

# Quick alias
alias cdm="cdmasjid"

# Auto-save branch when leaving project directory
cd() {
    # Save branch if leaving masjid project
    if [[ "$PWD" == "/home/inayet/Documents/masjidikhlasV3"* ]]; then
        git branch --show-current > ~/.last_masjid_branch 2>/dev/null || true
    fi
    
    # Normal cd command
    builtin cd "$@"
    
    # Restore branch if entering masjid project
    if [[ "$PWD" == "/home/inayet/Documents/masjidikhlasV3"* ]]; then
        if [[ -f ~/.last_masjid_branch ]]; then
            local last_branch=$(cat ~/.last_masjid_branch)
            if git rev-parse --verify "$last_branch" >/dev/null 2>&1; then
                git checkout "$last_branch" 2>/dev/null
                echo "🌿 Restored branch: $last_branch"
            fi
        fi
    fi
}
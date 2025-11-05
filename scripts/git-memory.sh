# Add to your ~/.zshrc or ~/.bashrc
# Smart project navigation with branch memory

# Function to navigate to project with branch memory
cdproj() {
    local PROJECT_ROOT="/home/inayet/Documents/masjidikhlasV3"
    
    if [[ $# -eq 0 ]]; then
        # No argument - go to project root and restore last branch
        cd "$PROJECT_ROOT"
        
        # Restore last used branch if it exists
        if [[ -f ~/.last_git_branch ]]; then
            local last_branch=$(cat ~/.last_git_branch)
            if git rev-parse --verify "$last_branch" >/dev/null 2>&1; then
                git checkout "$last_branch" 2>/dev/null
                echo "🌿 Restored branch: $last_branch"
            fi
        fi
        
        echo "📍 Project: Masjid Ikhlas V3"
        echo "🌿 Current branch: $(git branch --show-current 2>/dev/null || echo 'Not a git repo')"
    else
        # Save current branch before navigating elsewhere
        if [[ -d ".git" ]]; then
            git branch --show-current > ~/.last_git_branch
        fi
        
        cd "$1"
        echo "📍 Navigated to: $(pwd)"
    fi
}

# Function to save current branch and exit
save_and_exit() {
    if [[ -d ".git" ]]; then
        git branch --show-current > ~/.last_git_branch
        echo "💾 Saved branch: $(cat ~/.last_git_branch)"
    fi
}

# Set up automatic branch saving on exit
trap save_and_exit EXIT

# Alias for quick navigation
alias cdmasjid="cdproj"
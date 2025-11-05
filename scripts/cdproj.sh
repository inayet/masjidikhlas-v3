#!/bin/bash
# Smart directory navigation with branch memory
# Usage: cdproj [directory]

set -euo pipefail

# Project root directory
PROJECT_ROOT="/home/inayet/Documents/masjidikhlasV3"

# Function to save current branch
save_branch() {
    if [[ -d ".git" ]]; then
        git branch --show-current > ~/.current_git_branch 2>/dev/null || echo "main" > ~/.current_git_branch
    fi
}

# Function to restore saved branch
restore_branch() {
    if [[ -f ~/.current_git_branch ]]; then
        local saved_branch=$(cat ~/.current_git_branch)
        if git rev-parse --verify "$saved_branch" >/dev/null 2>&1; then
            git checkout "$saved_branch" 2>/dev/null || echo "Branch $saved_branch not found, staying on current branch"
        fi
    fi
}

# Main navigation logic
if [[ $# -eq 0 ]]; then
    # No argument - go to project root and restore branch
    cd "$PROJECT_ROOT"
    restore_branch
    echo "📍 Project: $(basename "$PROJECT_ROOT")"
    echo "🌿 Branch: $(git branch --show-current 2>/dev/null || echo 'Not a git repo')"
else
    # With argument - save current branch then navigate
    save_branch
    cd "$1"
    echo "📍 Navigated to: $(pwd)"
fi
# 🌿 Branch Memory Setup

Never lose your working branch again! This setup remembers your last used Git branch when navigating the Masjid Ikhlas project.

## 🚀 Quick Setup

### Option 1: Add to Your Shell (Recommended)

Add this to your `~/.zshrc` or `~/.bashrc`:

```bash
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
```

### Option 2: Use the Script

Copy and run:
```bash
source /home/inayet/Documents/masjidikhlasV3/scripts/shell-setup.sh
```

## 📋 Usage

### Navigate to Project (Restores Last Branch)
```bash
cdmasjid
# or
cdm
```

### Manual Branch Saving
```bash
# Save current branch
git branch --show-current > ~/.last_masjid_branch

# Check saved branch
cat ~/.last_masjid_branch
```

### Check Current Setup
```bash
# Check current branch
git branch --show-current

# Check if branch memory file exists
ls -la ~/.last_masjid_branch
```

## 🔄 How It Works

1. **Auto-Save**: When you leave the project directory, it saves your current branch
2. **Auto-Restore**: When you enter the project directory, it restores your last branch
3. **Manual Override**: You can always manually switch branches with `git checkout`

## 🛠️ Installation

### For Zsh (Most Common)
```bash
echo 'source ~/Documents/masjidikhlasV3/scripts/shell-setup.sh' >> ~/.zshrc
source ~/.zshrc
```

### For Bash
```bash
echo 'source ~/Documents/masjidikhlasV3/scripts/shell-setup.sh' >> ~/.bashrc
source ~/.bashrc
```

## 🎯 Benefits

- ✅ **Never lose your branch**: Automatically remembers where you were working
- ✅ **Quick navigation**: `cdm` gets you back to work instantly
- ✅ **No more accidental main**: Won't default to main branch
- ✅ **Works with any branch**: Remembers feature branches, hotfixes, etc.
- ✅ **Non-intrusive**: Only affects the Masjid Ikhlas project

## 🧪 Testing

```bash
# Test 1: Save current branch
cd /home/inayet/Documents/masjidikhlasV3
git checkout github-deploy-v1-a
git branch --show-current > ~/.last_masjid_branch

# Test 2: Navigate away and back
cd /tmp
cd /home/inayet/Documents/masjidikhlasV3
git branch --show-current  # Should show github-deploy-v1-a
```

## 🔧 Troubleshooting

### Branch Not Restored
```bash
# Check if branch exists
git branch -a | grep your-branch-name

# Manually restore
git checkout your-branch-name
```

### Alias Not Working
```bash
# Check if alias is set
alias | grep cdm

# Reload shell
source ~/.zshrc  # or ~/.bashrc
```

### Memory File Issues
```bash
# Remove and recreate
rm ~/.last_masjid_branch
git branch --show-current > ~/.last_masjid_branch
```

## 📚 Files Created

- `scripts/shell-setup.sh` - Shell functions and aliases
- `scripts/cdproj.sh` - Navigation script
- `scripts/git-memory.sh` - Git memory functions
- `scripts/post-checkout-hook` - Git hook for auto-saving
- `.git/hooks/post-checkout` - Installed git hook

Your working branch will now be remembered automatically! 🌿
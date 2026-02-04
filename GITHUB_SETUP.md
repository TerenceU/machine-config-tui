# Push to GitHub Instructions

## Setup GitHub Repository

### 1. Create Repository on GitHub
- Go to: https://github.com/new
- Repository name: `machine-config-tui`
- Description: "🎨 Modular dotfiles manager for Arch Linux with TUI"
- Keep it **public** (or private if preferred)
- **DO NOT** initialize with README (we already have one)
- Click "Create repository"

### 2. Add Remote and Push

```bash
cd /home/terence/repos/machine-config-tui

# Add GitHub remote (replace YOUR-USERNAME)
git remote add origin https://github.com/YOUR-USERNAME/machine-config-tui.git

# Push to GitHub
git push -u origin main
```

### 3. Verify

Visit: https://github.com/YOUR-USERNAME/machine-config-tui

You should see all your files and commits!

## Update README After Push

After pushing, update the clone URL in README.md:

```bash
# Edit README.md and replace [YOUR-USERNAME] with your actual GitHub username
nvim README.md

# Commit and push
git add README.md
git commit -m "docs: update GitHub username in README"
git push
```

## Future Updates

When you make changes to configs:

```bash
cd /home/terence/repos/machine-config-tui

# Check what changed
git status
git diff

# Stage and commit
git add -u  # or git add <specific-files>
git commit -m "update: description of changes"

# Push to GitHub
git push
```

## Clone on Another Machine

```bash
git clone https://github.com/YOUR-USERNAME/machine-config-tui.git ~/repos/machine-config-tui
cd ~/repos/machine-config-tui
./install.sh
```

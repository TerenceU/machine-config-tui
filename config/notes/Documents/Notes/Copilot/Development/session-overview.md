# Copilot Session Management - Development

**Ultimo aggiornamento:** 2026-02-09

## Environment Setup
- **Editor:** Neovim (LazyVim config in `~/.config/nvim/`)
- **Terminal:** Kitty + Tmux + Fish
- **Version Control:** Git
- **Node.js:** Managed via NVM (`~/.nvm/`)
- **Go:** Workspace in `~/go/`
- **Rust:** Cargo in `~/.cargo/`
- **Python:** System Python + pip

## Active Projects
### machine-config-tui
**Location:** `~/repos/machine-config-tui/`
**Purpose:** Dotfiles installer con TUI interattiva (gum + GNU Stow)

**Componenti gestiti:**
- Desktop Environment: Hyprland, Waybar, Swaync, Walker, GTK
- Terminal: Fish, Tmux, Kitty, Shell Extras (bash, starship, zsh)
- Editors/Browsers: Neovim, Qutebrowser
- Productivity: Aerc (email)
- Hacking: Pentest tools, Wordlists

**Struttura:**
- `components/` - Script installazione per ogni componente
- `config/` - Dotfiles organizzati per GNU Stow
- `packages/` - Liste pacchetti Arch per ogni componente
- `lib/` - Librerie comuni (utils, package-manager, stow-manager)

**Recenti aggiunte:**
- ✅ Aerc email client (2026-02-09)

## Development Workflow
1. Navigare con Fish vi-mode + tmux windows
2. Neovim per editing (LazyVim keybindings)
3. Tmux splits per test/build/run paralleli
4. Git workflow standard

## Coding Standards
- **Shell scripts:** Fish-friendly, documentati
- **Python:** PEP 8
- **JavaScript/Node:** Standard/Prettier
- **Config files:** Commentati, modulari

## Tool Integrations
### Fish Shell
- Vi keybindings attivi
- Custom aliases in `~/.config/fish/functions/`
- Fzf integration (git, history, files, processes)

### Tmux Development Setup
- Multiple windows per project context
- Named sessions: `tmux new -s project-name`
- Split panes: code | terminal | logs

### Neovim
- Plugin manager: lazy.nvim
- Config: `~/.config/nvim/lua/`
- LazyVim base configuration

## Quick Commands
```bash
# Package management
pacman -S package       # System packages (Arch)
npm install            # Node packages
pip install package    # Python packages
cargo install crate    # Rust crates

# NVM
nvm ls                 # List Node versions
nvm use version        # Switch Node version
```

## Project Templates
- [Da aggiungere template per progetti comuni]

## Debugging Notes
- [Da popolare durante debugging sessions]

# Submenu System Guide

## Overview

The system now supports **nested submenus** for modular component installation.

## Architecture

```
Components (Main Menu)
├── hyprland
├── waybar
├── fish
├── tmux
├── kitty
├── neovim
├── qutebrowser
├── gtk
├── swaync
├── walker
├── shell-extras ──┐         (SUBMENU)
│                  ├── bash
│                  ├── bash-aliases
│                  ├── starship
│                  └── zsh
└── hack-tools ────┐         (SUBMENU)
                   ├── pentest-tools ──┐  (NESTED SUBMENU)
                   │                   ├── nmap
                   │                   ├── metasploit
                   │                   ├── burpsuite
                   │                   ├── john
                   │                   ├── hashcat
                   │                   ├── wireshark
                   │                   └── sqlmap
                   └── wordlists ──────┐  (NESTED SUBMENU)
                                       ├── rockyou
                                       ├── seclists
                                       └── dirb-wordlists
```

## Component Organization

### Shell Extras (Level 1 Submenu)
- **bash** - Full bash config (.bashrc, .bash_profile, .bash_env, .bash_logout)
- **bash-aliases** - Just aliases file
- **starship** - Starship prompt
- **zsh** - Zsh shell config

### Hack Tools (Level 1 Submenu → Level 2 Nested)

**Pentest Tools:**
- nmap - Network scanner
- metasploit - Exploitation framework
- burpsuite - Web app security testing
- john - John the Ripper password cracker
- hashcat - Advanced password recovery
- wireshark - Network protocol analyzer
- sqlmap - SQL injection tool

**Wordlists:**
- rockyou - Popular password list
- seclists - Comprehensive security lists
- dirb-wordlists - Directory bruteforce lists

## Usage Example

```bash
./install.sh

# Main menu appears with all components
> Select: "shell-extras"

# Shell extras submenu appears
> Select: bash, starship (Space to select multiple)
> Confirm installation

# Or select hack-tools
> Select: "hack-tools"

# Hack tools menu appears
> Choose: "Pentest Tools"

# Pentest tools submenu appears
> Select: nmap, metasploit, wireshark
> Confirm installation
```

## Adding New Tools

### Add to existing submenu (e.g., gobuster to pentest-tools)

```bash
cat > components/hack-tools/pentest-tools/gobuster.sh << 'EOF'
#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "${SCRIPT_DIR}/lib/utils.sh"
source "${SCRIPT_DIR}/lib/package-manager.sh"

main() {
    log_info "Installing gobuster..."
    install_official_packages gobuster || return 1
    log_success "Gobuster installed!"
}

main "$@"
EOF

chmod +x components/hack-tools/pentest-tools/gobuster.sh
git add components/hack-tools/pentest-tools/gobuster.sh
git commit -m "feat: add gobuster to pentest tools"
```

It will automatically appear in the menu!

## Directory Structure

```
components/
├── shell-extras.sh              # Menu controller
├── shell-extras/                # Submenu items
│   ├── bash.sh
│   ├── bash-aliases.sh
│   ├── starship.sh
│   └── zsh.sh
├── hack-tools.sh                # Menu controller  
└── hack-tools/                  # Submenu categories
    ├── pentest-tools.sh         # Nested menu controller
    ├── pentest-tools/           # Nested submenu items
    │   ├── nmap.sh
    │   ├── metasploit.sh
    │   └── ...
    ├── wordlists.sh             # Nested menu controller
    └── wordlists/               # Nested submenu items
        ├── rockyou.sh
        ├── seclists.sh
        └── ...
```

```
config/
├── shell-extras-bash/           # Separated by component
│   ├── .bashrc
│   └── ...
├── shell-extras-bash-aliases/
│   └── .bash_aliases
└── shell-extras-starship/
    └── .config/starship.toml    # (if you add config)
```

```
packages/
└── shell-extras/                # Grouped by category
    ├── bash.txt
    ├── starship.txt
    └── zsh.txt
```

## Benefits

✅ **Modular** - Install only what you need  
✅ **Scalable** - Easy to add new tools  
✅ **Organized** - Clear hierarchical structure  
✅ **User-friendly** - Progressive disclosure  
✅ **Maintainable** - One file per tool  

## Tips

- Script names become menu labels (remove .sh extension)
- Use descriptive names: `metasploit.sh` shows as "metasploit"
- Test with `./install.sh` after adding new scripts
- Keep individual scripts simple (install + config only)
- Menu logic handled by parent script automatically

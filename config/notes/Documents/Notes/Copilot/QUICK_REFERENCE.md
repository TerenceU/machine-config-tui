# Quick Reference - Sistema Terence

**Ultimo aggiornamento:** 2026-02-09

## 📧 Email Setup
- **Client:** Aerc (TUI, vim-style)
- **Provider:** Gmail con OAuth2
- **Config:** `~/.config/aerc/`
  - `aerc.conf` - Configurazione principale
  - `binds.conf` - Keybindings
  - `accounts.conf` - Account settings (NON tracciato, sensibile)
  - `mutt_oauth2.py` - OAuth2 script con GPG encryption
  - `*.tokens` - Token files (NON tracciati, sensibili)

## 📂 Wordlists Location
**Path:** `/usr/share/wordlists/`

### SecLists Directories:
- `Discovery/` - Web content (dirs, DNS, subdomains, APIs)
- `Fuzzing/` - Fuzzing payloads
- `Passwords/` - Password lists
  - `rockyou.txt` - Il più usato (potrebbe essere .gz, decomprimi con `gunzip`)
- `Payloads/` - XSS, SQLi, command injection, LFI/RFI
- `Usernames/` - Common usernames
- `Web-Shells/` - Web shells (PHP, ASP, JSP, etc.)
- `Pattern-Matching/` - Regex patterns
- `Miscellaneous/` - Varie

**Comandi utili:**
```bash
ls /usr/share/wordlists/SecLists/Passwords/
ls /usr/share/wordlists/SecLists/Discovery/Web-Content/
```

## 🖥️ Sistema Core
- **OS:** Arch Linux
- **Hostname:** archbox
- **User:** terence
- **WM:** Hyprland (Wayland)
- **Shell:** Fish (vi-mode) + Bash
- **Terminal:** Kitty + Tmux
- **Editor:** Neovim (LazyVim)
- **Browser:** Qutebrowser (vim-style)

## 🎨 Theme
- **Palette:** Gruvbox + orange/brown custom
- **Fonts:** JetBrains Mono (terminal), Hack Nerd Font (GTK)
- **Colors:**
  - Active borders: Orange (#e3941e) → Golden (#db8b0b)
  - Inactive borders: Dark brown (#6b4506)

## 🔐 Security Tools
- Metasploit Framework: `~/.msf4/`
- Nmap, Wireshark, Burp Suite
- John the Ripper, Hashcat
- Proxychains, Tor, OpenVPN

## 🛠️ Development
- **Repos:** `~/repos/`
  - `machine-config-tui/` - Dotfiles installer (Stow-based)
- **Go:** `~/go/`
- **Node.js:** Via NVM (`~/.nvm/`)
- **Rust:** `~/.cargo/`

## 📝 Note-Taking Structure
```
~/Documents/Notes/
├── Copilot/              # Session context files (questo file!)
│   ├── Customization/
│   ├── Development/
│   └── Hacking/
├── TryHackMe/           # THM room notes (markdown)
├── Generic/             # General pentesting notes
└── Customizations/      # Ricing notes, config backups
```

## 🌐 TryHackMe
- **VPN Config:** `~/Documents/TryHackMe/TryHackMe.ovpn`
- **Connect:** `sudo openvpn ~/Documents/TryHackMe/TryHackMe.ovpn`
- **Verify:** `ip a` (check for tun0 interface)
- **Notes:** Save to `~/Documents/Notes/TryHackMe/[room-name]/`

## ⚡ Fish Aliases & Functions
- `cat` → `bat` (syntax highlighting)
- `ls` → `exa`, `ll` → `exa -abghHliS`
- `tree` → `exa --long --tree`
- `df`/`space` → `duf`
- `man` → `qman` (man pages in qutebrowser)
- `pyserver` → `python -m http.server`
- `chisulrouter` → `sudo nmap -sn 192.168.1.0/24`
- `tmux_copy_mode` → Enter tmux copy mode (ESC → v)
- `tmux_paste` → Paste from clipboard (ESC → p)

## 🔄 Config Reload Commands
```bash
hyprctl reload              # Hyprland
Ctrl+a r                    # Tmux (from inside tmux)
pkill waybar && waybar &    # Waybar
exec fish                   # Fish shell
```

## 📦 Package Management
```bash
pacman -S package          # System packages
npm install package        # Node.js
pip install package        # Python
cargo install crate        # Rust
```

## 🎯 Key Locations
- Configs: `~/.config/`
- Screenshots: `~/Images/Screenshots/`
- Documents: `~/Documents/`
- Downloads: `~/Downloads/`
- SSH keys: `~/.ssh/`
- GPG: `~/.gnupg/`
- Password store: `~/.password-store/`
- 1Password: `~/.config/1Password/`

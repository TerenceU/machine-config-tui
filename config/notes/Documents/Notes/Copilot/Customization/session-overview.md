# Copilot Session Management - Customization

**Ultimo aggiornamento:** 2026-02-09

## Sistema Overview
- **OS:** Arch Linux
- **WM:** Hyprland (Wayland)
- **Shell:** Fish (vi-mode)
- **Terminal:** Kitty + Tmux
- **Editor:** Neovim (LazyVim)
- **Browser:** Qutebrowser (vim-style)
- **Email:** Aerc (TUI, vim-style, OAuth2 con Gmail)

## Configurazioni Attive
### Hyprland
- Config principale: `~/.config/hypr/hyprland.conf`
- Moduli: `~/.config/hypr/modules/`
  - autostart.conf, binds.conf, env.conf, general.conf, input.conf, monitors.conf, rules.conf
- Scripts: `~/.config/hypr/scripts/`

### Tmux (Aggiornamento 2026-02-04)
- Config: `~/.config/tmux/tmux.conf`
- **Auto-start:** Ogni Kitty crea sessione separata
- **Keybindings principali:**
  - `Ctrl+Shift+[1-9]` - Window N
  - `Ctrl+Shift+h/l` - Window prev/next (vim-style)
  - `Ctrl+Shift+t` - New window
  - `Ctrl+Shift+d` - Close window
  - `Ctrl+Shift+s` - Session menu
- **Fish integration (normal mode):**
  - `Shift+H/L` - Navigate windows
  - `1-9` - Select window
  - `Shift+T/D/S/Q/R/X` - Window/session controls
- **Fish sempre parte in normal mode** (mostra `[N]`)
- Docs: `~/Documents/Notes/Customizations/tmux-configuration.md`

### Waybar
- Config: `~/.config/waybar/config.jsonc` + `style.css`
- Height: 32px
- Moduli: power, clock, workspaces, audio, bluetooth, network, settings

### Aerc (Email Client)
- Config: `~/.config/aerc/`
- **Provider:** Gmail (OAuth2)
- **OAuth script:** `mutt_oauth2.py`
- **Token encryption:** GPG
- Vim-style keybindings
- Thread view, filtering, searching

### Theme Globale
- **Color scheme:** Gruvbox + orange/brown accents
- **Fonts:** JetBrains Mono (terminal), Hack Nerd Font (GTK)
- **Active borders:** Orange (#e3941e) to golden (#db8b0b)
- **Inactive borders:** Dark brown (#6b4506)

## Workflow Customization
1. Test modifiche con `hyprctl reload` (Hyprland) o reload tools specifici
2. Documenta in `~/Documents/Notes/Customizations/[feature].md`
3. Mantieni consistenza colori (Gruvbox palette)
4. Backup config prima di modifiche major

## Modifiche Recenti
- **2026-02-09:** Aerc configurato come email client principale (Gmail OAuth2)
- **2026-02-09:** Aerc aggiunto a machine-config-tui installer
- **2026-02-04:** Configurazione completa tmux con Fish vi-mode integration

## Quick Reference
```bash
# Reload configs
hyprctl reload              # Hyprland
Ctrl+a r                    # Tmux (dentro tmux)
pkill waybar && waybar &    # Waybar
exec fish                   # Fish shell
```

## Directories Chiave
- `~/.config/` - Tutte le config applicazioni
- `~/Images/Screenshots/` - Screenshot storage
- `~/Documents/Notes/Customizations/` - Documentazione modifiche

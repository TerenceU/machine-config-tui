# Machine Config TUI 🎨

Sistema di gestione dotfiles per Arch Linux con interfaccia TUI interattiva.

## 🎯 Features

- **TUI Interattiva** - Selezione componenti con menu moderno (gum)
- **Gestione Modulare** - Ogni componente ha il proprio script di installazione
- **GNU Stow** - Symlink automatici per dotfiles
- **Installazione Completa** - Pacchetti + configurazioni in un unico comando
- **Sicuro** - Conferma prima di sovrascrivere configurazioni esistenti

## 📦 Componenti Supportati

### Desktop Environment
- **Hyprland** - Wayland compositor + moduli + scripts
- **Waybar** - Status bar (config + style)
- **Swaync** - Notification daemon
- **Walker** - Application launcher
- **GTK Theme** - Tema + icons + nwg-look config

### Terminal & Shells
- **Fish** - Shell + config + functions
- **Tmux** - Terminal multiplexer + theme
- **Kitty** - Terminal emulator
- **Shell Extras** 📂 - Submenu:
  - bash (full config)
  - bash-aliases
  - starship (prompt)
  - zsh

### Editors & Browsers
- **Neovim** - Editor (LazyVim config)
- **Qutebrowser** - Browser vim-style

### Productivity
- **Aerc** - Email client TUI (vim-style)
- **Ov** - Modern terminal pager (less alternative, used by aerc)
- **Notes** - Personal notes structure (Markdown)
- **Copilot** - GitHub Copilot CLI + config

### Hacking & Security
- **Hack Tools** 📂 - Submenu:
  - **Pentest Tools** 📂 (nmap, metasploit, burpsuite, john, hashcat, wireshark, sqlmap)
  - **Wordlists** 📂 (rockyou, seclists, dirb)

## 🚀 Installazione Rapida

```bash
# Clone repository
git clone https://github.com/[YOUR-USERNAME]/machine-config-tui.git ~/repos/machine-config-tui
cd ~/repos/machine-config-tui

# Avvia installer
./install.sh
```

## 🎯 Setup Completo Nuovo Sistema

Per configurare un nuovo sistema da zero con tutti i tuoi dotfiles, note e Copilot:

```bash
# 1. Clone il repository
git clone https://github.com/[YOUR-USERNAME]/machine-config-tui.git ~/repos/machine-config-tui
cd ~/repos/machine-config-tui

# 2. Esegui l'installer e seleziona:
./install.sh

# Componenti consigliati per setup completo:
#   - hyprland, waybar, swaync, walker, gtk
#   - fish, tmux, kitty
#   - neovim, qutebrowser
#   - aerc (se usi email)
#   - notes (importa le tue note e context Copilot)
#   - copilot (installa GitHub Copilot CLI)

# 3. Autentica GitHub CLI (necessario per Copilot)
gh auth login

# 4. Configura aerc (se installato)
# Modifica ~/.config/aerc/mutt_oauth2.py con le tue credenziali OAuth
# Crea ~/.config/aerc/accounts.conf (vedi config/aerc/README.md)

# 5. Avvia Copilot
gh copilot
# Al primo messaggio, scegli il tipo di sessione dal menu
# Copilot caricherà automaticamente il contesto da ~/Documents/Notes/Copilot/
```

## 📋 Requisiti

- Arch Linux (o derivate)
- `git`
- `stow`
- `gum` (verrà installato automaticamente se mancante)

## 🎮 Uso

### Installare Componenti

```bash
./install.sh
```

Seleziona i componenti che vuoi installare usando le frecce e spazio, poi premi Enter.

### Rimuovere Symlink

```bash
./install.sh --uninstall
```

### Aggiornare Configurazioni

```bash
# Pull latest changes
git pull

# Re-apply configs
./install.sh --update
```

## 📁 Struttura Repository

```
machine-config-tui/
├── install.sh              # Script principale con TUI
├── lib/                    # Librerie comuni
│   ├── utils.sh           # Funzioni helper
│   ├── package-manager.sh # Gestione pacchetti
│   └── stow-manager.sh    # Gestione stow
├── components/            # Script installazione componenti
│   ├── hyprland.sh
│   ├── waybar.sh
│   └── ...
├── config/               # Dotfiles organizzati per stow
│   ├── hypr/.config/hypr/
│   ├── waybar/.config/waybar/
│   └── ...
└── packages/            # Liste pacchetti
    ├── hyprland.txt
    └── ...
```

## 🛠️ Aggiungere Nuovi Componenti

1. Crea lo script in `components/nome-componente.sh`
2. Aggiungi i dotfiles in `config/nome-componente/`
3. Crea la lista pacchetti in `packages/nome-componente.txt`
4. Lo script principale lo rileverà automaticamente

## 📝 Note

- I dotfiles vengono gestiti con **GNU Stow**, quindi sono symlink alla repo
- Le modifiche ai file in `~/.config/` si riflettono automaticamente nella repo
- Fai `git pull` regolarmente per mantenere le config aggiornate
- Prima di installare, lo script chiede conferma se rileva file esistenti

## 🤝 Contribuire

Questo è un repository personale, ma sentiti libero di fork e adattarlo alle tue esigenze!

## 📄 License

MIT - Usa come preferisci

## 🎨 Theme

Sistema basato su **Gruvbox** con accenti arancioni/marroni custom.

## 🤖 Copilot Integration

Il repository include supporto completo per GitHub Copilot CLI:

### Componente `notes`
Installa la struttura delle note in `~/Documents/Notes/`:
- **Copilot/** - File di contesto per Copilot CLI
  - `QUICK_REFERENCE.md` - Riferimento rapido sistema
  - `Customization/session-overview.md` - Context customization
  - `Development/session-overview.md` - Context development  
  - `Hacking/session-overview.md` - Context pentesting
- **TryHackMe/** - Writeups e note THM
- **Generic/** - Note pentesting generali
- **Customizations/** - Note ricing e temi

### Componente `copilot`
Installa GitHub Copilot CLI e configurazione:
- Installa `github-cli` package
- Configura Copilot CLI (`~/.config/.copilot/`)
- Si integra automaticamente con il componente `notes`

### Workflow Copilot

1. **Installa i componenti:**
   ```bash
   ./install.sh
   # Seleziona: notes, copilot
   ```

2. **Autentica GitHub CLI:**
   ```bash
   gh auth login
   ```

3. **Avvia Copilot:**
   ```bash
   gh copilot
   ```

4. **Al primo messaggio**, Copilot mostrerà un menu:
   - 🎯 Pentesting - Carica context da `Hacking/session-overview.md`
   - 🎨 Customization - Carica context da `Customization/session-overview.md`
   - 💻 Development - Carica context da `Development/session-overview.md`
   - ⚙️ System Maintenance - Carica tutti i context

5. **Copilot ora conosce:**
   - Il tuo setup (Hyprland, Waybar, Fish, Tmux, Aerc, etc.)
   - Le tue wordlists (`/usr/share/wordlists/SecLists/`)
   - Il tuo email provider (Gmail OAuth2)
   - I tuoi progetti (`~/repos/machine-config-tui/`)
   - La struttura delle tue note
   - I tuoi alias e keybindings

### Aggiornare Context Files

Modifica i file in `~/Documents/Notes/Copilot/` (che sono symlink al repo):
```bash
# Modifica context
vim ~/Documents/Notes/Copilot/QUICK_REFERENCE.md

# Commit e push
cd ~/repos/machine-config-tui
git add config/notes/
git commit -m "Update Copilot context"
git push
```

Su un nuovo sistema, quando installi il componente `notes`, avrai automaticamente
tutti i context files aggiornati!

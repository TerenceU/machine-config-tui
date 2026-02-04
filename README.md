# Machine Config TUI 🎨

Sistema di gestione dotfiles per Arch Linux con interfaccia TUI interattiva.

## 🎯 Features

- **TUI Interattiva** - Selezione componenti con menu moderno (gum)
- **Gestione Modulare** - Ogni componente ha il proprio script di installazione
- **GNU Stow** - Symlink automatici per dotfiles
- **Installazione Completa** - Pacchetti + configurazioni in un unico comando
- **Sicuro** - Conferma prima di sovrascrivere configurazioni esistenti

## 📦 Componenti Supportati

- **Hyprland** - Wayland compositor + moduli + scripts
- **Waybar** - Status bar (config + style)
- **Fish** - Shell + config + functions
- **Tmux** - Terminal multiplexer + theme
- **Kitty** - Terminal emulator
- **Neovim** - Editor (LazyVim config)
- **Qutebrowser** - Browser vim-style
- **GTK Theme** - Tema + icons + nwg-look config
- **Swaync** - Notification daemon
- **Walker** - Application launcher
- **Shell extras** - Bash config (.bashrc, .bash_aliases, .bash_env)

## 🚀 Installazione Rapida

```bash
# Clone repository
git clone https://github.com/TUOUSERNAME/machine-config-tui.git
cd machine-config-tui

# Avvia installer
./install.sh
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

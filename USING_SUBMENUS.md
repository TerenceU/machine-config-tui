# Come Usare i Submenu 🎯

## Quick Start

```bash
cd /home/terence/repos/machine-config-tui
./install.sh
```

## Navigazione Submenu

### 1. Menu Principale
Quando avvii `./install.sh`, vedrai la lista completa:

```
[INFO] Select components to INSTALL (Space to select, Enter to confirm):
[INFO] 📂 = Submenu (will open selection menu)

  fish
  gtk
  hack-tools 📂        ← QUESTO È UN SUBMENU!
  hyprland
  kitty
  neovim
  qutebrowser
  shell-extras 📂      ← QUESTO È UN SUBMENU!
  swaync
  tmux
  walker
  waybar
```

### 2. Selezione Componenti

**Componenti Normali (senza 📂):**
- Seleziona con `Space`
- Premi `Enter`
- Si installano direttamente

**Componenti Submenu (con 📂):**
- Seleziona con `Space`
- Premi `Enter`
- Si **apre un nuovo menu** con le opzioni

### 3. Esempio: shell-extras 📂

1. Seleziona `shell-extras 📂` → Enter
2. Si apre il submenu:
   ```
   ╔══════════════════════════════════════════╗
   ║  Opening: shell-extras
   ╚══════════════════════════════════════════╝
   
   ╔══════════════════════════════════════════╗
   ║  Shell Extras Menu
   ╚══════════════════════════════════════════╝
   
   [INFO] Select shell extras to install:
   
     bash
     bash-aliases
     starship
     zsh
   ```

3. Seleziona quello che vuoi (Space per multi-select)
4. Enter per confermare
5. Si installano i componenti selezionati

### 4. Esempio: hack-tools 📂 (Menu Annidato)

1. Seleziona `hack-tools 📂` → Enter
2. Si apre il primo menu:
   ```
   ╔══════════════════════════════════════════╗
   ║  Hack Tools Menu
   ╚══════════════════════════════════════════╝
   
     Pentest Tools
     Wordlists
     Back to main menu
   ```

3. Scegli "Pentest Tools" → Enter
4. Si apre il secondo menu:
   ```
   ╔══════════════════════════════════════════╗
   ║  Pentest Tools
   ╚══════════════════════════════════════════╝
   
   [INFO] Select pentest tools to install:
   
     burpsuite
     hashcat
     john
     metasploit
     nmap
     sqlmap
     wireshark
   ```

5. Seleziona i tool che vuoi
6. Enter per confermare
7. Si installano

## Combinare Componenti

Puoi selezionare **sia componenti normali che submenu insieme**:

```
Selezioni:
  ✓ kitty          (installa direttamente)
  ✓ fish           (installa direttamente)
  ✓ shell-extras 📂 (apre submenu)
  ✓ hack-tools 📂   (apre submenu)
```

Il sistema:
1. Prima apre tutti i submenu selezionati (uno alla volta)
2. Poi installa i componenti normali in batch

## Tips

- **📂 indica sempre un submenu** - non installa nulla, apre un menu
- Puoi premere `Ctrl+C` in qualsiasi momento per uscire
- I submenu hanno conferme separate per ogni selezione
- Puoi tornare al menu principale con "Back to main menu"

## Struttura

```
Main Menu
  ├── Componenti diretti (kitty, fish, tmux, etc.)
  │   └── [Installano subito]
  │
  ├── shell-extras 📂 [SUBMENU Livello 1]
  │   ├── bash
  │   ├── bash-aliases
  │   ├── starship
  │   └── zsh
  │
  └── hack-tools 📂 [SUBMENU Livello 1]
      ├── Pentest Tools [SUBMENU Livello 2]
      │   ├── nmap
      │   ├── metasploit
      │   ├── burpsuite
      │   └── ...
      │
      └── Wordlists [SUBMENU Livello 2]
          ├── rockyou
          ├── seclists
          └── dirb-wordlists
```

## Prova Ora!

```bash
./install.sh

# Prova a selezionare "shell-extras 📂" per vedere il menu
# Poi prova "hack-tools 📂" per vedere i menu annidati
```

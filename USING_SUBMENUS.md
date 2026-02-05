# Come Usare i Submenu 🎯

## Quick Start

```bash
cd /home/terence/repos/machine-config-tui
./install.sh
```

## Nuova Navigazione (Single-Select + Loop)

### Controlli Base
- **↑ / ↓** - Naviga nella lista
- **Enter** - Seleziona componente o entra in submenu
- **Esc** o seleziona "Exit" - Esci

### Comportamento
- **Menu persistente** - Dopo ogni installazione torni al menu
- **Navigazione uno-alla-volta** - Installi un componente per volta
- **← Back** in ogni submenu per tornare indietro

## Navigazione Submenu

### 1. Menu Principale
Quando avvii `./install.sh`:

```
╔══════════════════════════════════════════╗
║  Machine Config TUI
╚══════════════════════════════════════════╝

[INFO] Navigate with ↑↓ arrows, Enter to select
[INFO] 📂 = Submenu (press Enter to explore)

   fish
   gtk
📂 hack-tools        ← SUBMENU: premi Enter per entrare
   hyprland
   kitty
   neovim
   qutebrowser
📂 shell-extras      ← SUBMENU: premi Enter per entrare
   swaync
   tmux
   walker
   waybar
   ──────────────
   Exit
```

**Cosa fare:**
1. Usa ↑↓ per navigare
2. Premi Enter su un componente normale → installa
3. Premi Enter su un submenu 📂 → apre il menu

### 2. Installare un Componente Normale

Esempio: Installi `kitty`

1. Vai su `kitty` con ↑↓
2. Premi Enter
3. Conferma: "Install kitty?" → Yes/No
4. Installa
5. "Press Enter to continue..."
6. **Torni al menu principale** automaticamente!
7. Puoi installare altro o selezionare Exit

### 3. Entrare in un Submenu

Esempio: `shell-extras 📂`

1. Vai su `shell-extras 📂` con ↑↓
2. Premi Enter
3. Si apre il submenu:

```
╔══════════════════════════════════════════╗
║  Shell Extras
╚══════════════════════════════════════════╝

[INFO] Navigate with ↑↓ arrows, Enter to install

← Back              ← Premi Enter qui per tornare indietro
──────────────
bash
bash-aliases
starship
zsh
```

4. Scegli un componente (es: `starship`)
5. Enter → Conferma → Installa
6. **Torni al submenu shell-extras**
7. Puoi installare altro o selezionare "← Back"

### 4. Menu Annidati (hack-tools)

Esempio: `hack-tools 📂`

**Livello 1:** Menu principale
```
   hack-tools 📂
```

**Livello 2:** Categorie
```
← Back
──────────────
Pentest Tools
Wordlists
```

**Livello 3:** Tools specifici
Selezioni "Pentest Tools":
```
← Back
──────────────
burpsuite
hashcat
john
metasploit
nmap
sqlmap
wireshark
```

**Workflow completo:**
1. Menu principale → Seleziona `hack-tools 📂`
2. Menu hack-tools → Seleziona `Pentest Tools`
3. Menu pentest-tools → Seleziona `nmap`
4. Conferma e installa
5. Torni al menu pentest-tools
6. Puoi installare altro tool
7. Seleziona `← Back` → Torni a hack-tools
8. Seleziona `← Back` → Torni al menu principale

## Confronto: Prima vs Ora

### Prima (Multi-Select)
- Space per selezionare multipli
- Enter per confermare batch
- Installazione in blocco
- Uscita automatica dopo installazione

### Ora (Single-Select + Loop)
- ↑↓ per navigare
- Enter per selezionare uno
- Installazione immediata
- **Menu persistente** - torni sempre al menu
- Esci quando vuoi con "Exit" o "← Back"

## Vantaggi del Nuovo Sistema

✅ **Più controllo** - Installi uno alla volta  
✅ **Navigazione fluida** - Menu sempre disponibile  
✅ **Intuitivo** - Come un file manager  
✅ **Flessibile** - Entra/esci dai submenu quando vuoi  
✅ **Meno errori** - Non installi per sbaglio batch di cose  

## Esempi Pratici

### Installare 3 componenti diversi
```
1. Avvia: ./install.sh
2. Seleziona kitty → Enter → Conferma → Installa
3. [Torni al menu]
4. Seleziona fish → Enter → Conferma → Installa
5. [Torni al menu]
6. Seleziona tmux → Enter → Conferma → Installa
7. [Torni al menu]
8. Seleziona Exit
```

### Esplorare e installare da submenu
```
1. Avvia: ./install.sh
2. Seleziona shell-extras 📂 → Enter
3. [Sei nel submenu shell-extras]
4. Seleziona bash → Enter → Conferma → Installa
5. [Torni al submenu]
6. Seleziona starship → Enter → Conferma → Installa
7. [Torni al submenu]
8. Seleziona ← Back
9. [Torni al menu principale]
10. Seleziona Exit
```

### Navigare menu annidati
```
1. Seleziona hack-tools 📂 → Enter
2. [Menu: Pentest Tools, Wordlists]
3. Seleziona Pentest Tools → Enter
4. [Menu: nmap, metasploit, etc.]
5. Seleziona nmap → Installa
6. [Torni a pentest tools]
7. Seleziona ← Back
8. [Torni a hack-tools]
9. Seleziona Wordlists → Enter
10. Seleziona rockyou → Installa
11. Seleziona ← Back → ← Back
12. [Sei al menu principale]
```

## Tips

🎯 **Installa tranquillamente** - Il menu torna sempre  
🔙 **← Back ovunque** - Per tornare al livello precedente  
📂 **Segui l'icona** - Indica un submenu da esplorare  
⚡ **Veloce** - Un Enter per entrare, uno per uscire  
🔄 **Loop infinito** - Installa quanto vuoi, esci quando vuoi  

## Prova Ora!

```bash
./install.sh
# Naviga con ↑↓
# Premi Enter su shell-extras 📂
# Esplora il submenu
# Torna indietro con ← Back
```

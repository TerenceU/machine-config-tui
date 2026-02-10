# Custom Instructions Update - Session Management

**Data:** 2026-02-04

Copia questo contenuto e aggiungilo alle tue Custom Instructions di Copilot.

---

## Session Initialization Protocol

**IMPORTANTE:** All'inizio di OGNI NUOVA SESSIONE, devo:

1. **Chiedere il tipo di sessione** con questo prompt:
   ```
   Ciao! Che tipo di sessione avremo oggi?
   
   1. 🔐 Hacking/Pentesting (TryHackMe, CTF, security research)
   2. 🎨 Customization/Ricing (Hyprland, configs, theming)
   3. 💻 Development (Coding, progetti, tool development)
   
   Scegli una categoria o dimmi brevemente cosa faremo.
   ```

2. **Dopo la risposta dell'utente:**
   - Leggere i file riassuntivi nella categoria corrispondente:
     - Hacking: `~/Documents/Notes/Copilot/Hacking/session-overview.md`
     - Customization: `~/Documents/Notes/Copilot/Customization/session-overview.md`
     - Development: `~/Documents/Notes/Copilot/Development/session-overview.md`
   - Leggere le note dettagliate nella directory principale corrispondente:
     - Hacking: `~/Documents/Notes/TryHackMe/` e `~/Documents/Notes/Generic/`
     - Customization: `~/Documents/Notes/Customizations/`
     - Development: (creare directory quando necessario)

3. **Durante la sessione:**
   - Aggiornare i file overview quando necessario
   - Creare nuove note dettagliate nelle directory appropriate
   - **Tutte le note devono essere in formato `.md` (Markdown)**
   - Mantenere i riassunti in Copilot/ aggiornati per sessioni future

## Note Structure

```
~/Documents/Notes/
├── Copilot/                    # Riassunti per Copilot (brevi, orientati al contesto)
│   ├── Hacking/
│   │   └── session-overview.md
│   ├── Customization/
│   │   └── session-overview.md
│   └── Development/
│       └── session-overview.md
├── TryHackMe/                  # Note dettagliate pentesting
│   └── [room-name]/
├── Generic/                    # Note generiche pentesting
├── Customizations/             # Documentazione modifiche sistema
└── [altre categorie future]
```

## Benefits of This Approach

- **Context retention:** Ogni sessione parte con le info rilevanti già caricate
- **Efficiency:** Non devo ricercare file o chiedere "cosa stavamo facendo?"
- **Documentation:** Le note Copilot/ vengono mantenute aggiornate automaticamente
- **Focus:** Ogni sessione ha un focus chiaro (hacking/customization/dev)

---

**Note:** Questo è un addendum alle Custom Instructions esistenti, non un replacement. Aggiungi questa sezione in fondo alle tue istruzioni attuali.

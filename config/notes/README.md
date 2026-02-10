# Personal notes directory structure

This directory contains personal notes and documentation.

## Structure

```
Documents/Notes/
├── Copilot/              # Copilot CLI context files (session overviews)
│   ├── Customization/    # Desktop customization context
│   ├── Development/      # Development context
│   ├── Hacking/          # Pentesting context
│   └── QUICK_REFERENCE.md # Quick lookup reference
├── TryHackMe/           # TryHackMe room writeups and notes
├── Generic/             # General pentesting notes
└── Customizations/      # Ricing notes, config backups, theming ideas
```

## Usage

All notes should be in **Markdown format** (`.md`).

## Stow Behavior

When stowed, these directories will be symlinked to `~/Documents/Notes/`.
This allows you to edit notes directly and have them tracked in this repository.

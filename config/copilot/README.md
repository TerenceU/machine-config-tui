# GitHub Copilot CLI Configuration

This directory contains the GitHub Copilot CLI configuration.

## Files

- `config.json` - Copilot CLI preferences
  - Banner disabled
  - Markdown rendering enabled
  - Auto theme
  - Trusted folders configured

## Custom Instructions

The custom instructions for Copilot are integrated into the GitHub Copilot CLI system.
They are automatically loaded from the repository's `.github/copilot-instructions.md` file
or from the agent's system configuration.

### What the Custom Instructions Include

The custom instructions configure Copilot to understand:

1. **System Overview**
   - Arch Linux workstation setup
   - Hyprland (Wayland) environment
   - Terminal: Kitty + Tmux + Fish (vi-mode)
   - Editor: Neovim (LazyVim)
   - Browser: Qutebrowser
   - Email: Aerc (Gmail OAuth2)

2. **Desktop Environment**
   - Hyprland modular configuration
   - Waybar, swaync, walker
   - Gruvbox theme with orange/brown accents

3. **Use Cases**
   - Pentesting & Cybersecurity (TryHackMe)
   - System customization & ricing
   - Development (automation, tools)

4. **Tool Stack**
   - Pentesting: Metasploit, Nmap, Burp Suite, John, Hashcat
   - Wordlists: SecLists in `/usr/share/wordlists/`
   - Development: NVM, Go, Rust, Python

5. **Notes Structure**
   - Copilot context files in `~/Documents/Notes/Copilot/`
   - TryHackMe writeups in `~/Documents/Notes/TryHackMe/`
   - All notes in Markdown format

6. **Session Initialization**
   - Welcome menu on first message
   - Automatic context loading based on session type
   - Session-specific overviews loaded from `~/Documents/Notes/Copilot/`

## Installation

The custom instructions are built into the Copilot agent and work automatically
when you have the `notes` component installed (which provides the context files).

## Dependencies

- `github-cli` (gh) - GitHub CLI with Copilot extension
- `notes` component - Provides Copilot context files

## Usage

```bash
# Start Copilot CLI
gh copilot

# Copilot will automatically:
# 1. Show welcome menu on first message
# 2. Load appropriate context based on your selection
# 3. Reference ~/Documents/Notes/Copilot/ for session context
```

## Context Files Reference

After installing the `notes` component, these files will be available:

- `~/Documents/Notes/Copilot/QUICK_REFERENCE.md` - Quick system lookup
- `~/Documents/Notes/Copilot/Customization/session-overview.md`
- `~/Documents/Notes/Copilot/Development/session-overview.md`
- `~/Documents/Notes/Copilot/Hacking/session-overview.md`

Copilot reads these files at the start of each session type.

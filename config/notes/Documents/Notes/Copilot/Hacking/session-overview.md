# Copilot Session Management - Hacking

**Ultimo aggiornamento:** 2026-02-09

## Sessioni Attive
- TryHackMe training in corso
- VPN: `~/Documents/TryHackMe/TryHackMe.ovpn`

## Tool Stack Principali
- Metasploit Framework (`~/.msf4/`)
- Nmap (scanning)
- Wireshark (packet analysis)
- John the Ripper / Hashcat (password cracking)
- Burp Suite, sqlmap, nikto
- Proxychains, Tor

## Wordlists Installate
**Location:** `/usr/share/wordlists/`

### SecLists Structure:
- **Discovery/** - Web content discovery (directories, DNS, etc.)
- **Fuzzing/** - Fuzzing payloads
- **Passwords/** - Password lists (rockyou.txt incluso)
- **Pattern-Matching/** - Regex patterns
- **Payloads/** - XSS, SQLi, command injection, etc.
- **Usernames/** - Common usernames
- **Web-Shells/** - Web shell scripts
- **Miscellaneous/** - Varie

**Note:** rockyou.txt potrebbe richiedere decompressione:
```bash
sudo gunzip /usr/share/wordlists/rockyou.txt.gz
```

## Workflow Standard
1. Connetti VPN: `sudo openvpn ~/Documents/TryHackMe/TryHackMe.ovpn`
2. Verifica connessione: `ip a` (cerca tun0)
3. Crea cartella room: `~/Documents/Notes/TryHackMe/[room-name]/`
4. Documenta tutto in markdown

## Note Recenti
- [Da popolare durante le sessioni]

## Quick Commands
```bash
# Network scan
chisulrouter  # Alias per nmap -sn 192.168.1.0/24

# HTTP server per file transfer
pyserver  # Alias per python -m http.server

# Wordlists
ls /usr/share/wordlists/SecLists/
```

## Checklist Pre-Sessione
- [ ] VPN connessa
- [ ] Cartella room creata in `~/Documents/Notes/TryHackMe/[room-name]/`
- [ ] Note template pronte

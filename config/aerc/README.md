# aerc Configuration

Configuration files for aerc email client.

## Files Included

- `aerc.conf` - Main configuration (UI, behavior, etc.)
- `binds.conf` - Key bindings
- `mutt_oauth2.py` - OAuth2 helper script (sanitized template)

## Files NOT Included (Security)

The following files contain sensitive credentials and are **NOT** tracked:

- `accounts.conf` - Email account credentials
- `*.tokens` - OAuth2 token files (e.g., `terence.usa`, `terence.usai`)

## Setup Instructions

### 1. Configure OAuth2 Script

Edit `~/.config/aerc/mutt_oauth2.py` and replace placeholders:

```python
# Line 48: Your GPG key ID
ENCRYPTION_PIPE = ['gpg', '--encrypt', '--recipient', 'YOUR_GPG_KEY_ID']

# Lines 62-63: Google OAuth credentials
'client_id': 'YOUR_GOOGLE_CLIENT_ID',
'client_secret': 'YOUR_GOOGLE_CLIENT_SECRET',

# Lines 78-79: Microsoft OAuth credentials (if needed)
'client_id': 'YOUR_MICROSOFT_CLIENT_ID',
'client_secret': 'YOUR_MICROSOFT_CLIENT_SECRET',
```

**How to get Google OAuth credentials:**
1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select existing
3. Enable Gmail API
4. Create OAuth 2.0 credentials (Desktop app)
5. Copy Client ID and Client Secret

### 2. Generate OAuth2 Token

```bash
# Initialize and authorize
python ~/.config/aerc/mutt_oauth2.py ~/.config/aerc/your-email.tokens --authorize

# Follow the prompts to authenticate
```

### 3. Create accounts.conf

Create `~/.config/aerc/accounts.conf` with your email settings:

```ini
[Personal Gmail]
source = imaps://your-email@gmail.com@imap.gmail.com:993
outgoing = smtp+plain://your-email@gmail.com@smtp.gmail.com:587
from = Your Name <your-email@gmail.com>
copy-to = [Gmail]/Sent Mail
archive = [Gmail]/All Mail
postpone = [Gmail]/Drafts
default = Inbox

# OAuth2 authentication
source-cred-cmd = python ~/.config/aerc/mutt_oauth2.py ~/.config/aerc/your-email.tokens
outgoing-cred-cmd = python ~/.config/aerc/mutt_oauth2.py ~/.config/aerc/your-email.tokens
```

### 4. Test Connection

```bash
# Test IMAP/SMTP endpoints
python ~/.config/aerc/mutt_oauth2.py ~/.config/aerc/your-email.tokens --test --verbose

# Launch aerc
aerc
```

## Security Notes

- Token files are encrypted with GPG
- Never commit `accounts.conf` or `*.tokens` files
- Keep OAuth client secrets secure
- Tokens are refreshed automatically when expired

## References

- [aerc manual](https://man.sr.ht/~rjarry/aerc/)
- [Gmail OAuth setup](https://man.sr.ht/~rjarry/aerc/providers/gmail.md)
- [mutt_oauth2.py documentation](https://gitlab.com/muttmua/mutt/-/blob/master/contrib/mutt_oauth2.py)

## Dependencies

Required packages (install via `machine-config-tui` or manually):

- `aerc` - Email client
- `dante` - HTML rendering (fallback)
- `w3m` - HTML browser (text mode)
- `ov` - Modern pager (replaces less)
- `catimg` - Terminal image viewer
- `python` - For OAuth2 script
- `libnotify` - Desktop notifications (notify-send)
- `gpg` - For token encryption

## Configuration Highlights

### Viewer Settings
- **Pager**: `ov` instead of default `less` (modern, feature-rich)
- **HTML rendering**: Primary with `dante`, fallback to `w3m`
- **Images**: Inline display with `catimg`

### Filters Enabled
```ini
text/plain=colorize
text/calendar=calendar
text/html=! html           # dante rendering
text/html=! w3m -T text/html -I UTF-8  # w3m fallback
image/*=catimg -w $(tput cols) -       # image display
```

### Hooks Configured
```ini
# Desktop notification on new mail
mail-received=notify-send "[$AERC_ACCOUNT/$AERC_FOLDER] New mail from $AERC_FROM_NAME" "$AERC_SUBJECT"
```

### Compose Settings
- `reply-to-self=true` - Allow self-replies (useful for note-taking workflows)


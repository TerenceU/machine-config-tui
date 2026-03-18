#!/bin/bash
# mail-notifier.sh - Install IMAP IDLE mail notification service

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/utils.sh"

STOW_DIR="${SCRIPT_DIR}/config/mail-notifier"
TARGET_DIR="${HOME}"

main() {
    log_info "Installing mail-notifier..."

    # Stow config files
    if [[ -d "$STOW_DIR" ]]; then
        log_info "Linking config files with stow..."
        stow --dir="${SCRIPT_DIR}/config" --target="$TARGET_DIR" mail-notifier || {
            log_error "Failed to stow mail-notifier"
            return 1
        }
    fi

    chmod +x "${HOME}/.local/bin/mail-notifier.py"

    # Enable and start systemd user service
    log_info "Enabling mail-notifier systemd service..."
    systemctl --user daemon-reload
    systemctl --user enable --now mail-notifier.service

    log_success "mail-notifier installed and running!"
    log_info "Check status: systemctl --user status mail-notifier"
    log_info "View logs:    journalctl --user -u mail-notifier -f"
    return 0
}

main "$@"

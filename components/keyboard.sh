#!/bin/bash
# keyboard.sh - Install and configure keyboard remapping via keyd

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/utils.sh"
source "${SCRIPT_DIR}/lib/package-manager.sh"

COMPONENT_NAME="keyboard"
PACKAGE_FILE="${SCRIPT_DIR}/packages/${COMPONENT_NAME}.txt"
KEYD_CONF_SRC="${SCRIPT_DIR}/config/${COMPONENT_NAME}/etc/keyd/default.conf"
KEYD_CONF_DST="/etc/keyd/default.conf"

main() {
    log_info "Installing keyboard configuration (keyd)..."

    # Install keyd
    if [[ -f "$PACKAGE_FILE" ]]; then
        install_from_package_list "$PACKAGE_FILE" || {
            log_error "Failed to install keyd"
            return 1
        }
    else
        install_official_packages keyd
    fi

    # Copy keyd config to /etc/keyd/ (requires sudo, not stowable)
    log_info "Installing keyd configuration to ${KEYD_CONF_DST}..."
    sudo mkdir -p /etc/keyd
    sudo cp "$KEYD_CONF_SRC" "$KEYD_CONF_DST" || {
        log_error "Failed to copy keyd config"
        return 1
    }

    # Enable and restart keyd service
    log_info "Enabling keyd service..."
    sudo systemctl enable --now keyd || {
        log_error "Failed to enable keyd service"
        return 1
    }
    sudo systemctl restart keyd

    log_success "Keyboard configuration complete!"
    log_info "Active remappings: CapsLock → Escape | Escape → CapsLock"
    return 0
}

main "$@"

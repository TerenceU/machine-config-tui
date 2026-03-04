#!/bin/bash
# networking.sh - Install networking stack

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/utils.sh"
source "${SCRIPT_DIR}/lib/package-manager.sh"

COMPONENT_NAME="networking"
PACKAGE_FILE="${SCRIPT_DIR}/packages/${COMPONENT_NAME}.txt"

main() {
    log_info "Installing networking stack..."

    if [[ -f "$PACKAGE_FILE" ]]; then
        install_from_package_list "$PACKAGE_FILE" || {
            log_error "Failed to install packages"
            return 1
        }
    else
        install_official_packages networkmanager network-manager-applet ufw
    fi

    log_info "Enabling NetworkManager service..."
    sudo systemctl enable --now NetworkManager

    log_info "Enabling ufw firewall..."
    sudo systemctl enable --now ufw
    sudo ufw enable

    log_success "Networking installation complete!"
    return 0
}

main "$@"

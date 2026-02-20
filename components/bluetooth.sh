#!/bin/bash
# bluetooth.sh - Install Bluetooth support (bluez + blueman)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/utils.sh"
source "${SCRIPT_DIR}/lib/package-manager.sh"

COMPONENT_NAME="bluetooth"
PACKAGE_FILE="${SCRIPT_DIR}/packages/${COMPONENT_NAME}.txt"

main() {
    log_info "Installing Bluetooth support..."

    if [[ -f "$PACKAGE_FILE" ]]; then
        install_from_package_list "$PACKAGE_FILE" || {
            log_error "Failed to install packages"
            return 1
        }
    else
        install_official_packages bluez bluez-utils blueman
    fi

    log_info "Enabling bluetooth service..."
    sudo systemctl enable --now bluetooth.service

    log_success "Bluetooth installation complete!"
    return 0
}

main "$@"

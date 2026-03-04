#!/bin/bash
# display-manager.sh - Install and enable ly display manager

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/utils.sh"
source "${SCRIPT_DIR}/lib/package-manager.sh"

COMPONENT_NAME="display-manager"
PACKAGE_FILE="${SCRIPT_DIR}/packages/${COMPONENT_NAME}.txt"

main() {
    log_info "Installing ly display manager..."

    if [[ -f "$PACKAGE_FILE" ]]; then
        install_from_package_list "$PACKAGE_FILE" || {
            log_error "Failed to install packages"
            return 1
        }
    else
        install_official_packages ly
    fi

    log_info "Enabling ly service..."
    sudo systemctl enable ly

    log_success "Display manager (ly) installation complete!"
    return 0
}

main "$@"

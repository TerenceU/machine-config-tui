#!/bin/bash
# openvpn.sh - Install OpenVPN client

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/utils.sh"
source "${SCRIPT_DIR}/lib/package-manager.sh"

COMPONENT_NAME="openvpn"
PACKAGE_FILE="${SCRIPT_DIR}/packages/${COMPONENT_NAME}.txt"

main() {
    log_info "Installing OpenVPN..."

    if [[ -f "$PACKAGE_FILE" ]]; then
        install_from_package_list "$PACKAGE_FILE" || {
            log_error "Failed to install packages"
            return 1
        }
    else
        install_official_packages openvpn
    fi

    log_info "Usage: sudo openvpn --config <file.ovpn>"
    log_success "OpenVPN installation complete!"
    return 0
}

main "$@"

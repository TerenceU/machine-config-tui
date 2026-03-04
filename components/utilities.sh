#!/bin/bash
# utilities.sh - Install general utilities and applications

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/utils.sh"
source "${SCRIPT_DIR}/lib/package-manager.sh"

COMPONENT_NAME="utilities"
PACKAGE_FILE="${SCRIPT_DIR}/packages/${COMPONENT_NAME}.txt"

main() {
    log_info "Installing utilities and applications..."

    if [[ -f "$PACKAGE_FILE" ]]; then
        install_from_package_list "$PACKAGE_FILE" || {
            log_error "Failed to install packages"
            return 1
        }
    else
        install_official_packages vlc vlc-plugins-all ranger copyq mupdf bashtop rofi wofi
    fi

    log_success "Utilities installation complete!"
    return 0
}

main "$@"

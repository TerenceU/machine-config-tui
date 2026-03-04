#!/bin/bash
# 1password.sh - Install 1Password password manager

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/utils.sh"
source "${SCRIPT_DIR}/lib/package-manager.sh"

COMPONENT_NAME="1password"
PACKAGE_FILE="${SCRIPT_DIR}/packages/${COMPONENT_NAME}.txt"

main() {
    log_info "Installing 1Password..."

    if [[ -f "$PACKAGE_FILE" ]]; then
        install_from_package_list "$PACKAGE_FILE" || {
            log_error "Failed to install packages"
            return 1
        }
    else
        install_aur_packages 1password
    fi

    log_success "1Password installation complete!"
    return 0
}

main "$@"

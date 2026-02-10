#!/bin/bash
# ov.sh - Install ov pager

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/utils.sh"
source "${SCRIPT_DIR}/lib/package-manager.sh"
source "${SCRIPT_DIR}/lib/stow-manager.sh"

COMPONENT_NAME="ov"
PACKAGE_FILE="${SCRIPT_DIR}/packages/${COMPONENT_NAME}.txt"

main() {
    log_info "Installing ov pager..."
    
    # Install packages
    if [[ -f "$PACKAGE_FILE" ]]; then
        install_from_package_list "$PACKAGE_FILE" || {
            log_error "Failed to install packages"
            return 1
        }
    else
        log_warning "Package list not found, installing default package"
        install_package "ov"
    fi
    
    # Stow configuration
    log_info "Setting up configuration files..."
    stow_component "$COMPONENT_NAME" || {
        log_error "Failed to stow configuration"
        return 1
    }
    
    log_success "ov installation complete!"
    log_info "ov is configured as the default pager for aerc"
    return 0
}

main "$@"

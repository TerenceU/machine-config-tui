#!/bin/bash
# gtk-theme.sh - Install GTK theme and icons

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/utils.sh"
source "${SCRIPT_DIR}/lib/package-manager.sh"
source "${SCRIPT_DIR}/lib/stow-manager.sh"

COMPONENT_NAME="gtk"
PACKAGE_FILE="${SCRIPT_DIR}/packages/${COMPONENT_NAME}.txt"

main() {
    log_info "Installing GTK theme..."
    
    # Install packages
    if [[ -f "$PACKAGE_FILE" ]]; then
        install_from_package_list "$PACKAGE_FILE" || {
            log_error "Failed to install packages"
            return 1
        }
    else
        log_warning "Package list not found"
        install_package "nwg-look"
    fi
    
    # Stow configuration
    log_info "Setting up configuration files..."
    stow_component "$COMPONENT_NAME" || {
        log_error "Failed to stow configuration"
        return 1
    }
    
    log_success "GTK theme installation complete!"
    return 0
}

main "$@"

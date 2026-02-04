#!/bin/bash
# shell-extras.sh - Install shell extras (bash configs)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/utils.sh"
source "${SCRIPT_DIR}/lib/package-manager.sh"
source "${SCRIPT_DIR}/lib/stow-manager.sh"

COMPONENT_NAME="shell-extras"
PACKAGE_FILE="${SCRIPT_DIR}/packages/${COMPONENT_NAME}.txt"

main() {
    log_info "Installing shell extras..."
    
    # Install packages
    if [[ -f "$PACKAGE_FILE" ]]; then
        install_from_package_list "$PACKAGE_FILE" || {
            log_warning "Some packages may have failed to install"
        }
    fi
    
    # Stow configuration
    log_info "Setting up configuration files..."
    stow_component "$COMPONENT_NAME" || {
        log_error "Failed to stow configuration"
        return 1
    }
    
    log_success "Shell extras installation complete!"
    log_info "Note: Restart your shell to apply changes"
    return 0
}

main "$@"

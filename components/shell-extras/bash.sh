#!/bin/bash
# bash.sh - Install bash configuration

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
source "${SCRIPT_DIR}/lib/utils.sh"
source "${SCRIPT_DIR}/lib/package-manager.sh"
source "${SCRIPT_DIR}/lib/stow-manager.sh"

COMPONENT_NAME="bash"
PACKAGE_FILE="${SCRIPT_DIR}/packages/shell-extras/${COMPONENT_NAME}.txt"

main() {
    log_info "Installing bash configuration..."
    
    # Install packages
    if [[ -f "$PACKAGE_FILE" ]]; then
        install_from_package_list "$PACKAGE_FILE" || {
            log_warning "Some packages may have failed to install"
        }
    fi
    
    # Stow configuration
    log_info "Setting up bash configuration files..."
    stow_component "shell-extras-${COMPONENT_NAME}" || {
        log_error "Failed to stow configuration"
        return 1
    }
    
    log_success "Bash configuration installed!"
    log_info "Note: Restart your shell to apply changes"
    return 0
}

main "$@"

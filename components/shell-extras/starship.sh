#!/bin/bash
# starship.sh - Install starship prompt

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
source "${SCRIPT_DIR}/lib/utils.sh"
source "${SCRIPT_DIR}/lib/package-manager.sh"
source "${SCRIPT_DIR}/lib/stow-manager.sh"

COMPONENT_NAME="starship"
PACKAGE_FILE="${SCRIPT_DIR}/packages/shell-extras/${COMPONENT_NAME}.txt"

main() {
    log_info "Installing starship prompt..."
    
    # Install packages
    if [[ -f "$PACKAGE_FILE" ]]; then
        install_from_package_list "$PACKAGE_FILE" || {
            log_error "Failed to install packages"
            return 1
        }
    else
        install_package "starship"
    fi
    
    # Stow configuration
    if [[ -d "${SCRIPT_DIR}/config/shell-extras-${COMPONENT_NAME}" ]]; then
        log_info "Setting up starship configuration..."
        stow_component "shell-extras-${COMPONENT_NAME}" || {
            log_error "Failed to stow configuration"
            return 1
        }
    fi
    
    log_success "Starship installed!"
    log_info "Add to your shell RC: eval \"\$(starship init bash)\" or eval \"\$(starship init fish)\""
    return 0
}

main "$@"

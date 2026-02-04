#!/bin/bash
# zsh.sh - Install zsh configuration

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
source "${SCRIPT_DIR}/lib/utils.sh"
source "${SCRIPT_DIR}/lib/package-manager.sh"
source "${SCRIPT_DIR}/lib/stow-manager.sh"

COMPONENT_NAME="zsh"
PACKAGE_FILE="${SCRIPT_DIR}/packages/shell-extras/${COMPONENT_NAME}.txt"

main() {
    log_info "Installing zsh configuration..."
    
    # Install packages
    if [[ -f "$PACKAGE_FILE" ]]; then
        install_from_package_list "$PACKAGE_FILE" || {
            log_error "Failed to install packages"
            return 1
        }
    else
        install_package "zsh"
    fi
    
    # Stow configuration
    if [[ -d "${SCRIPT_DIR}/config/shell-extras-${COMPONENT_NAME}" ]]; then
        log_info "Setting up zsh configuration files..."
        stow_component "shell-extras-${COMPONENT_NAME}" || {
            log_error "Failed to stow configuration"
            return 1
        }
    fi
    
    # Set zsh as default shell
    if gum confirm "Set Zsh as your default shell?"; then
        log_info "Changing default shell to Zsh..."
        chsh -s /usr/bin/zsh
        log_success "Default shell changed to Zsh"
    fi
    
    log_success "Zsh configuration installed!"
    return 0
}

main "$@"

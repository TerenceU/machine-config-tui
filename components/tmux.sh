#!/bin/bash
# tmux.sh - Install Tmux terminal multiplexer

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/utils.sh"
source "${SCRIPT_DIR}/lib/package-manager.sh"
source "${SCRIPT_DIR}/lib/stow-manager.sh"

COMPONENT_NAME="tmux"
PACKAGE_FILE="${SCRIPT_DIR}/packages/${COMPONENT_NAME}.txt"

main() {
    log_info "Installing Tmux..."
    
    # Install packages
    if [[ -f "$PACKAGE_FILE" ]]; then
        install_from_package_list "$PACKAGE_FILE" || {
            log_error "Failed to install packages"
            return 1
        }
    else
        install_package "tmux"
    fi
    
    # Stow configuration
    log_info "Setting up configuration files..."
    stow_component "$COMPONENT_NAME" || {
        log_error "Failed to stow configuration"
        return 1
    }
    
    # Install TPM (Tmux Plugin Manager) if not present
    local tpm_dir="${HOME}/.tmux/plugins/tpm"
    if [[ ! -d "$tpm_dir" ]]; then
        log_info "Installing TPM (Tmux Plugin Manager)..."
        git clone https://github.com/tmux-plugins/tpm "$tpm_dir" || {
            log_warning "Failed to clone TPM"
        }
    fi
    
    log_success "Tmux installation complete!"
    log_info "Note: Press 'Ctrl+a I' (capital I) inside tmux to install plugins"
    return 0
}

main "$@"

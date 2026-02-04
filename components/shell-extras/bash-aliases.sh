#!/bin/bash
# bash-aliases.sh - Install bash aliases

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
source "${SCRIPT_DIR}/lib/utils.sh"
source "${SCRIPT_DIR}/lib/stow-manager.sh"

COMPONENT_NAME="bash-aliases"

main() {
    log_info "Installing bash aliases..."
    
    # Stow configuration
    log_info "Setting up aliases file..."
    stow_component "shell-extras-${COMPONENT_NAME}" || {
        log_error "Failed to stow configuration"
        return 1
    }
    
    log_success "Bash aliases installed!"
    log_info "Note: Run 'source ~/.bash_aliases' or restart shell"
    return 0
}

main "$@"

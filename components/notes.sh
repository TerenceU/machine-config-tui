#!/bin/bash
# notes.sh - Install personal notes structure

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/utils.sh"
source "${SCRIPT_DIR}/lib/stow-manager.sh"

COMPONENT_NAME="notes"

main() {
    log_info "Setting up notes directory structure..."
    
    # Stow notes
    stow_component "$COMPONENT_NAME" || {
        log_error "Failed to stow notes"
        return 1
    }
    
    log_success "Notes structure installed!"
    log_info "Location: ~/Documents/Notes/"
    log_info "  - Copilot/     (Copilot CLI context files)"
    log_info "  - TryHackMe/   (THM writeups)"
    log_info "  - Generic/     (General pentesting notes)"
    log_info "  - Customizations/ (Ricing notes)"
    return 0
}

main "$@"

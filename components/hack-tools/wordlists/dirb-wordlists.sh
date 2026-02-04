#!/bin/bash
# dirb-wordlists.sh - Install dirb wordlists

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "${SCRIPT_DIR}/lib/utils.sh"
source "${SCRIPT_DIR}/lib/package-manager.sh"

main() {
    log_info "Installing dirb wordlists..."
    
    install_official_packages dirb || {
        log_error "Failed to install dirb"
        return 1
    }
    
    log_success "Dirb wordlists installed!"
    log_info "Location: /usr/share/dirb/wordlists/"
    return 0
}

main "$@"

#!/bin/bash
# seclists.sh - Install SecLists wordlists

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "${SCRIPT_DIR}/lib/utils.sh"
source "${SCRIPT_DIR}/lib/package-manager.sh"

main() {
    log_info "Installing SecLists..."
    
    install_official_packages seclists || {
        log_error "Failed to install seclists"
        return 1
    }
    
    log_success "SecLists installed!"
    log_info "Location: /usr/share/seclists/"
    return 0
}

main "$@"

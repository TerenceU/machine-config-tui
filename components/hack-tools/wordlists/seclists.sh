#!/bin/bash
# seclists.sh - Install SecLists wordlists

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "${SCRIPT_DIR}/lib/utils.sh"
source "${SCRIPT_DIR}/lib/package-manager.sh"

WEBSHELLS_SRC="/usr/share/wordlists/Web-Shells/laudanum-1.0"
WEBSHELLS_LINK="/usr/share/webshells"

main() {
    log_info "Installing SecLists..."
    
    install_official_packages seclists || {
        log_error "Failed to install seclists"
        return 1
    }

    if [[ -d "${WEBSHELLS_SRC}" ]]; then
        log_info "Creating compatibility symlink: ${WEBSHELLS_LINK} -> ${WEBSHELLS_SRC}"
        sudo ln -sfn "${WEBSHELLS_SRC}" "${WEBSHELLS_LINK}" || {
            log_error "Failed to create ${WEBSHELLS_LINK} symlink"
            return 1
        }
        log_success "Webshells compatibility path ready at ${WEBSHELLS_LINK}"
    else
        log_warning "Webshell source not found at ${WEBSHELLS_SRC}"
    fi
    
    log_success "SecLists installed!"
    log_info "Location: /usr/share/seclists/"
    log_info "Webshells: ${WEBSHELLS_LINK}/php/php-reverse-shell.php"
    return 0
}

main "$@"

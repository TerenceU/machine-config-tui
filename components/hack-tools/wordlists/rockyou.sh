#!/bin/bash
# rockyou.sh - Install rockyou wordlist

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "${SCRIPT_DIR}/lib/utils.sh"

main() {
    log_info "Installing rockyou wordlist..."
    
    local wordlist_dir="/usr/share/wordlists"
    local rockyou_path="${wordlist_dir}/rockyou.txt"
    
    # Create wordlists directory
    sudo mkdir -p "$wordlist_dir"
    
    # Check if already exists
    if [[ -f "$rockyou_path" ]]; then
        log_success "rockyou.txt already exists"
        return 0
    fi
    
    # Extract from archive if exists
    if [[ -f "${rockyou_path}.gz" ]]; then
        log_info "Extracting rockyou.txt.gz..."
        sudo gunzip "${rockyou_path}.gz"
        log_success "rockyou.txt extracted!"
    else
        log_warning "rockyou.txt.gz not found in /usr/share/wordlists"
        log_info "You can download it from: https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt"
    fi
    
    return 0
}

main "$@"

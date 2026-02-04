#!/bin/bash
# wordlists.sh - Wordlists submenu

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
source "${SCRIPT_DIR}/lib/utils.sh"

# Get available wordlists
get_wordlists() {
    local lists=()
    for script in "${SCRIPT_DIR}/components/hack-tools/wordlists"/*.sh; do
        if [[ -f "$script" ]]; then
            lists+=("$(basename "$script" .sh)")
        fi
    done
    echo "${lists[@]}"
}

# Execute wordlist installation
execute_wordlist() {
    local list="$1"
    local script="${SCRIPT_DIR}/components/hack-tools/wordlists/${list}.sh"
    
    if [[ ! -f "$script" ]]; then
        log_error "Wordlist script not found: $script"
        return 1
    fi
    
    log_header "Installing: $list"
    chmod +x "$script"
    bash "$script" || {
        log_error "Failed to install $list"
        return 1
    }
    
    return 0
}

main() {
    log_header "Wordlists"
    
    local available_lists=($(get_wordlists))
    
    if [[ ${#available_lists[@]} -eq 0 ]]; then
        log_error "No wordlists found"
        return 1
    fi
    
    if ! command_exists gum; then
        log_error "gum is required for submenu"
        return 1
    fi
    
    log_info "Select wordlists to install (Space to select, Enter to confirm):"
    echo ""
    
    local selected=$(gum choose --no-limit --height 15 "${available_lists[@]}")
    
    if [[ -z "$selected" ]]; then
        log_info "No wordlists selected"
        return 0
    fi
    
    # Convert to array
    local selected_array=()
    while IFS= read -r line; do
        selected_array+=("$line")
    done <<< "$selected"
    
    echo ""
    gum confirm "Install ${#selected_array[@]} wordlist(s)?" || {
        log_info "Installation cancelled"
        return 0
    }
    
    # Install selected wordlists
    local failed=()
    for list in "${selected_array[@]}"; do
        if execute_wordlist "$list"; then
            log_success "✓ $list installed"
        else
            failed+=("$list")
        fi
        echo ""
    done
    
    if [[ ${#failed[@]} -gt 0 ]]; then
        log_error "Failed wordlists: ${failed[*]}"
        return 1
    fi
    
    log_success "All wordlists installed!"
    return 0
}

main "$@"

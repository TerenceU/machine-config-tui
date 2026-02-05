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
    if ! command_exists gum; then
        log_error "gum is required for submenu"
        return 1
    fi
    
    while true; do
        log_header "Wordlists"
        
        local available_lists=($(get_wordlists))
        
        if [[ ${#available_lists[@]} -eq 0 ]]; then
            log_error "No wordlists found"
            return 1
        fi
        
        # Build menu with back option
        local menu_items=("← Back")
        menu_items+=("──────────────")
        menu_items+=("${available_lists[@]}")
        
        log_info "Navigate with ↑↓ arrows, Enter to install"
        echo ""
        
        local selected=$(gum choose --height 15 "${menu_items[@]}")
        
        if [[ -z "$selected" || "$selected" == "← Back" || "$selected" == "──────────────" ]]; then
            return 0
        fi
        
        echo ""
        
        if gum confirm "Install $selected?"; then
            if execute_wordlist "$selected"; then
                log_success "✓ $selected installed successfully"
            fi
            echo ""
            gum style --foreground 212 "Press Enter to continue..."
            read -r
        fi
    done
}

main "$@"

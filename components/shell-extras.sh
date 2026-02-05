#!/bin/bash
# shell-extras.sh - Shell extras submenu

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/utils.sh"

# Get available shell extras components
get_shell_extras_components() {
    local components=()
    for script in "${SCRIPT_DIR}/components/shell-extras"/*.sh; do
        if [[ -f "$script" ]]; then
            components+=("$(basename "$script" .sh)")
        fi
    done
    echo "${components[@]}"
}

# Execute shell extra component
execute_shell_extra() {
    local component="$1"
    local script="${SCRIPT_DIR}/components/shell-extras/${component}.sh"
    
    if [[ ! -f "$script" ]]; then
        log_error "Component script not found: $script"
        return 1
    fi
    
    log_header "Installing: $component"
    chmod +x "$script"
    bash "$script" || {
        log_error "Failed to install $component"
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
        log_header "Shell Extras"
        
        local available_components=($(get_shell_extras_components))
        
        if [[ ${#available_components[@]} -eq 0 ]]; then
            log_error "No shell extras components found"
            return 1
        fi
        
        # Build menu with back option
        local menu_items=("← Back")
        menu_items+=("──────────────")
        menu_items+=("${available_components[@]}")
        
        log_info "Navigate with ↑↓ arrows, Enter to install"
        echo ""
        
        local selected=$(gum choose --height 15 "${menu_items[@]}")
        
        if [[ -z "$selected" || "$selected" == "← Back" || "$selected" == "──────────────" ]]; then
            return 0
        fi
        
        echo ""
        
        if gum confirm "Install $selected?"; then
            if execute_shell_extra "$selected"; then
                log_success "✓ $selected installed successfully"
            fi
            echo ""
            gum style --foreground 212 "Press Enter to continue..."
            read -r
        fi
    done
}

main "$@"

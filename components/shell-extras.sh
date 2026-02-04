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
    log_header "Shell Extras Menu"
    
    local available_components=($(get_shell_extras_components))
    
    if [[ ${#available_components[@]} -eq 0 ]]; then
        log_error "No shell extras components found"
        return 1
    fi
    
    if ! command_exists gum; then
        log_error "gum is required for submenu"
        return 1
    fi
    
    log_info "Select shell extras to install (Space to select, Enter to confirm):"
    echo ""
    
    local selected=$(gum choose --no-limit --height 10 "${available_components[@]}")
    
    if [[ -z "$selected" ]]; then
        log_info "No components selected"
        return 0
    fi
    
    # Convert to array
    local selected_array=()
    while IFS= read -r line; do
        selected_array+=("$line")
    done <<< "$selected"
    
    echo ""
    gum confirm "Install ${#selected_array[@]} shell extra(s)?" || {
        log_info "Installation cancelled"
        return 0
    }
    
    # Install selected components
    local failed=()
    for component in "${selected_array[@]}"; do
        if execute_shell_extra "$component"; then
            log_success "✓ $component installed"
        else
            failed+=("$component")
        fi
        echo ""
    done
    
    if [[ ${#failed[@]} -gt 0 ]]; then
        log_error "Failed components: ${failed[*]}"
        return 1
    fi
    
    log_success "All shell extras installed!"
    return 0
}

main "$@"

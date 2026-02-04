#!/bin/bash
# install.sh - Main installer script with TUI for machine-config-tui
# Author: Terence
# Description: Interactive dotfiles installer for Arch Linux

set -e

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source libraries
source "${SCRIPT_DIR}/lib/utils.sh"
source "${SCRIPT_DIR}/lib/package-manager.sh"
source "${SCRIPT_DIR}/lib/stow-manager.sh"

# Components directory
COMPONENTS_DIR="${SCRIPT_DIR}/components"

# Ensure gum is installed
ensure_gum() {
    if ! command_exists gum; then
        log_info "Installing gum (TUI framework)..."
        install_package "gum" || {
            log_error "Failed to install gum. Cannot continue."
            exit 1
        }
    fi
}

# Get list of available components
get_available_components() {
    local components=()
    
    if [[ -d "$COMPONENTS_DIR" ]]; then
        for script in "$COMPONENTS_DIR"/*.sh; do
            if [[ -f "$script" ]]; then
                local component=$(basename "$script" .sh)
                components+=("$component")
            fi
        done
    fi
    
    echo "${components[@]}"
}

# Execute component installation script
execute_component_script() {
    local component="$1"
    local script="${COMPONENTS_DIR}/${component}.sh"
    
    if [[ ! -f "$script" ]]; then
        log_error "Component script not found: $script"
        return 1
    fi
    
    # Check if component has a submenu directory
    if [[ -d "${COMPONENTS_DIR}/${component}" ]]; then
        # This is a submenu component, run it directly (it will handle its own UI)
        log_header "Opening: $component"
        chmod +x "$script"
        bash "$script"
        return $?
    else
        # Regular component, install it
        log_header "Installing: $component"
        chmod +x "$script"
        bash "$script" || {
            log_error "Failed to install $component"
            return 1
        }
        log_success "✓ $component installed successfully"
        return 0
    fi
}

# Install selected components
install_components() {
    local components=("$@")
    
    if [[ ${#components[@]} -eq 0 ]]; then
        log_warning "No components selected"
        return 0
    fi
    
    # Separate submenu components from regular components
    local regular_components=()
    local submenu_components=()
    
    for component in "${components[@]}"; do
        if [[ -d "${COMPONENTS_DIR}/${component}" ]]; then
            submenu_components+=("$component")
        else
            regular_components+=("$component")
        fi
    done
    
    # Handle submenu components (open them one by one)
    for component in "${submenu_components[@]}"; do
        execute_component_script "$component"
        echo ""
    done
    
    # Handle regular components (batch install)
    if [[ ${#regular_components[@]} -gt 0 ]]; then
        log_header "Installation Started"
        log_info "Components to install: ${regular_components[*]}"
        
        local failed_components=()
        local success_count=0
        
        for component in "${regular_components[@]}"; do
            if execute_component_script "$component"; then
                ((success_count++))
            else
                failed_components+=("$component")
            fi
            echo ""
        done
        
        # Summary
        log_header "Installation Summary"
        log_success "$success_count component(s) installed successfully"
        
        if [[ ${#failed_components[@]} -gt 0 ]]; then
            log_error "Failed components: ${failed_components[*]}"
            return 1
        fi
    fi
    
    return 0
}

# Uninstall components (remove symlinks)
uninstall_components() {
    local components=("$@")
    
    if [[ ${#components[@]} -eq 0 ]]; then
        log_warning "No components selected"
        return 0
    fi
    
    log_header "Uninstallation Started"
    
    for component in "${components[@]}"; do
        log_info "Removing symlinks for: $component"
        unstow_component "$component" || log_warning "Failed to unstow $component"
    done
    
    log_success "Uninstallation complete"
}

# Update components (restow)
update_components() {
    local components=("$@")
    
    if [[ ${#components[@]} -eq 0 ]]; then
        log_warning "No components selected"
        return 0
    fi
    
    log_header "Update Started"
    
    for component in "${components[@]}"; do
        log_info "Updating: $component"
        restow_component "$component" || log_warning "Failed to restow $component"
    done
    
    log_success "Update complete"
}

# Show component selection menu
show_component_menu() {
    local mode="$1"  # install, uninstall, update
    
    local available_components=($(get_available_components))
    
    if [[ ${#available_components[@]} -eq 0 ]]; then
        log_error "No components found in $COMPONENTS_DIR"
        exit 1
    fi
    
    # Add visual indicators for submenu components
    local display_components=()
    for component in "${available_components[@]}"; do
        if [[ -d "${COMPONENTS_DIR}/${component}" ]]; then
            display_components+=("${component} 📂")
        else
            display_components+=("${component}")
        fi
    done
    
    log_header "Machine Config TUI"
    
    case "$mode" in
        install)
            log_info "Select components to INSTALL (Space to select, Enter to confirm):"
            log_info "📂 = Submenu (will open selection menu)"
            ;;
        uninstall)
            log_info "Select components to UNINSTALL (Space to select, Enter to confirm):"
            ;;
        update)
            log_info "Select components to UPDATE (Space to select, Enter to confirm):"
            ;;
    esac
    
    echo ""
    
    # Use gum for multi-select
    local selected_components=$(gum choose --no-limit --height 15 "${display_components[@]}")
    
    if [[ -z "$selected_components" ]]; then
        log_info "No components selected. Exiting."
        exit 0
    fi
    
    # Convert to array and remove emoji indicators
    local selected_array=()
    while IFS= read -r line; do
        # Remove the emoji indicator if present
        line="${line% 📂}"
        selected_array+=("$line")
    done <<< "$selected_components"
    
    echo ""
    
    # Confirm action
    case "$mode" in
        install)
            gum confirm "Proceed with ${#selected_array[@]} component(s)?" || {
                log_info "Installation cancelled"
                exit 0
            }
            install_components "${selected_array[@]}"
            ;;
        uninstall)
            gum confirm "Uninstall ${#selected_array[@]} component(s)?" || {
                log_info "Uninstallation cancelled"
                exit 0
            }
            uninstall_components "${selected_array[@]}"
            ;;
        update)
            gum confirm "Update ${#selected_array[@]} component(s)?" || {
                log_info "Update cancelled"
                exit 0
            }
            update_components "${selected_array[@]}"
            ;;
    esac
}

# Show main menu
show_main_menu() {
    log_header "Machine Config TUI"
    
    local action=$(gum choose \
        "Install components" \
        "Uninstall components" \
        "Update components" \
        "Exit")
    
    case "$action" in
        "Install components")
            show_component_menu "install"
            ;;
        "Uninstall components")
            show_component_menu "uninstall"
            ;;
        "Update components")
            show_component_menu "update"
            ;;
        "Exit")
            log_info "Goodbye!"
            exit 0
            ;;
    esac
}

# Parse command line arguments
parse_args() {
    case "${1:-}" in
        --install|-i)
            shift
            show_component_menu "install"
            ;;
        --uninstall|-u)
            shift
            show_component_menu "uninstall"
            ;;
        --update|-U)
            shift
            show_component_menu "update"
            ;;
        --help|-h)
            echo "Usage: $0 [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  -i, --install      Install components"
            echo "  -u, --uninstall    Uninstall components"
            echo "  -U, --update       Update components"
            echo "  -h, --help         Show this help message"
            echo ""
            echo "If no option is provided, interactive menu will be shown."
            exit 0
            ;;
        "")
            show_main_menu
            ;;
        *)
            log_error "Unknown option: $1"
            log_info "Use --help for usage information"
            exit 1
            ;;
    esac
}

# Main function
main() {
    # Check if running on Arch Linux
    check_arch_linux
    
    # Ensure gum is installed
    ensure_gum
    
    # Clear log file
    echo "=== Machine Config TUI Log - $(date) ===" > /tmp/machine-config-tui.log
    
    # Parse arguments
    parse_args "$@"
}

# Run main
main "$@"

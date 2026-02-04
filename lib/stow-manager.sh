#!/bin/bash
# stow-manager.sh - GNU Stow management utilities

source "$(dirname "${BASH_SOURCE[0]}")/utils.sh"

# Base directories
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_DIR="${REPO_DIR}/config"
HOME_DIR="${HOME}"

# Install GNU Stow if not present
ensure_stow_installed() {
    if ! command_exists stow; then
        log_info "GNU Stow not found, installing..."
        source "${REPO_DIR}/lib/package-manager.sh"
        install_package "stow" || return 1
    fi
}

# Stow a component
stow_component() {
    local component="$1"
    local component_dir="${CONFIG_DIR}/${component}"
    
    if [[ ! -d "$component_dir" ]]; then
        log_error "Component directory not found: $component_dir"
        return 1
    fi
    
    ensure_stow_installed || return 1
    
    log_info "Creating symlinks for $component..."
    
    # Check for conflicts
    local conflicts=$(stow -d "$CONFIG_DIR" -t "$HOME_DIR" -n -v "$component" 2>&1 | grep "existing target")
    
    if [[ -n "$conflicts" ]]; then
        log_warning "Conflicts detected for $component:"
        echo "$conflicts"
        
        if ! check_and_confirm "$HOME_DIR" "configuration"; then
            log_info "Skipping $component"
            return 1
        fi
        
        # Remove conflicting files/links
        log_info "Removing conflicts..."
        stow -d "$CONFIG_DIR" -t "$HOME_DIR" --adopt "$component" 2>/dev/null || true
    fi
    
    # Perform stow operation
    if stow -d "$CONFIG_DIR" -t "$HOME_DIR" -v "$component" 2>&1; then
        log_success "Symlinks created for $component"
        write_log "Stowed component: $component"
        return 0
    else
        log_error "Failed to create symlinks for $component"
        write_log "ERROR: Failed to stow component: $component"
        return 1
    fi
}

# Unstow a component
unstow_component() {
    local component="$1"
    local component_dir="${CONFIG_DIR}/${component}"
    
    if [[ ! -d "$component_dir" ]]; then
        log_error "Component directory not found: $component_dir"
        return 1
    fi
    
    ensure_stow_installed || return 1
    
    log_info "Removing symlinks for $component..."
    
    if stow -d "$CONFIG_DIR" -t "$HOME_DIR" -D -v "$component" 2>&1; then
        log_success "Symlinks removed for $component"
        write_log "Unstowed component: $component"
        return 0
    else
        log_error "Failed to remove symlinks for $component"
        write_log "ERROR: Failed to unstow component: $component"
        return 1
    fi
}

# Restow a component (useful for updates)
restow_component() {
    local component="$1"
    
    log_info "Restowing $component..."
    
    ensure_stow_installed || return 1
    
    if stow -d "$CONFIG_DIR" -t "$HOME_DIR" -R -v "$component" 2>&1; then
        log_success "Restowed $component"
        write_log "Restowed component: $component"
        return 0
    else
        log_error "Failed to restow $component"
        write_log "ERROR: Failed to restow component: $component"
        return 1
    fi
}

# List all stowable components
list_components() {
    if [[ ! -d "$CONFIG_DIR" ]]; then
        return 1
    fi
    
    local components=()
    for dir in "$CONFIG_DIR"/*; do
        if [[ -d "$dir" ]]; then
            components+=("$(basename "$dir")")
        fi
    done
    
    echo "${components[@]}"
}

# Check if component is stowed
is_component_stowed() {
    local component="$1"
    local component_dir="${CONFIG_DIR}/${component}"
    
    [[ ! -d "$component_dir" ]] && return 1
    
    # Check if any symlinks exist pointing to the component
    local stow_output=$(stow -d "$CONFIG_DIR" -t "$HOME_DIR" -n -v "$component" 2>&1)
    
    if echo "$stow_output" | grep -q "already stowed"; then
        return 0
    fi
    
    return 1
}

export -f ensure_stow_installed stow_component unstow_component restow_component
export -f list_components is_component_stowed
export REPO_DIR CONFIG_DIR HOME_DIR

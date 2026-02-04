#!/bin/bash
# package-manager.sh - Package management utilities

source "$(dirname "${BASH_SOURCE[0]}")/utils.sh"

# Detect AUR helper
detect_aur_helper() {
    if command_exists yay; then
        echo "yay"
    elif command_exists paru; then
        echo "paru"
    else
        echo "none"
    fi
}

# Install official packages
install_official_packages() {
    local packages=("$@")
    
    if [[ ${#packages[@]} -eq 0 ]]; then
        return 0
    fi
    
    log_info "Installing official packages: ${packages[*]}"
    
    if command_exists gum; then
        gum spin --spinner dot --title "Installing packages..." -- \
            sudo pacman -S --needed --noconfirm "${packages[@]}"
    else
        sudo pacman -S --needed --noconfirm "${packages[@]}"
    fi
    
    local exit_code=$?
    if [[ $exit_code -eq 0 ]]; then
        log_success "Official packages installed successfully"
        write_log "Installed official packages: ${packages[*]}"
    else
        log_error "Failed to install some official packages"
        write_log "ERROR: Failed to install official packages: ${packages[*]}"
        return 1
    fi
}

# Install AUR packages
install_aur_packages() {
    local packages=("$@")
    
    if [[ ${#packages[@]} -eq 0 ]]; then
        return 0
    fi
    
    local aur_helper=$(detect_aur_helper)
    
    if [[ "$aur_helper" == "none" ]]; then
        log_warning "No AUR helper found (yay/paru)"
        log_info "AUR packages to install manually: ${packages[*]}"
        return 1
    fi
    
    log_info "Installing AUR packages with $aur_helper: ${packages[*]}"
    
    if command_exists gum; then
        gum spin --spinner dot --title "Installing AUR packages..." -- \
            $aur_helper -S --needed --noconfirm "${packages[@]}"
    else
        $aur_helper -S --needed --noconfirm "${packages[@]}"
    fi
    
    local exit_code=$?
    if [[ $exit_code -eq 0 ]]; then
        log_success "AUR packages installed successfully"
        write_log "Installed AUR packages: ${packages[*]}"
    else
        log_error "Failed to install some AUR packages"
        write_log "ERROR: Failed to install AUR packages: ${packages[*]}"
        return 1
    fi
}

# Install packages from file
install_from_package_list() {
    local package_file="$1"
    
    if [[ ! -f "$package_file" ]]; then
        log_error "Package file not found: $package_file"
        return 1
    fi
    
    local official_packages=()
    local aur_packages=()
    local section="official"
    
    while IFS= read -r line; do
        # Skip comments and empty lines
        [[ "$line" =~ ^#.*$ ]] && continue
        [[ -z "$line" ]] && continue
        
        # Check for section markers
        if [[ "$line" == "[official]" ]]; then
            section="official"
            continue
        elif [[ "$line" == "[aur]" ]]; then
            section="aur"
            continue
        fi
        
        # Add package to appropriate array
        if [[ "$section" == "official" ]]; then
            official_packages+=("$line")
        elif [[ "$section" == "aur" ]]; then
            aur_packages+=("$line")
        fi
    done < "$package_file"
    
    # Install official packages
    if [[ ${#official_packages[@]} -gt 0 ]]; then
        install_official_packages "${official_packages[@]}" || return 1
    fi
    
    # Install AUR packages
    if [[ ${#aur_packages[@]} -gt 0 ]]; then
        install_aur_packages "${aur_packages[@]}"
    fi
    
    return 0
}

# Check if package is installed
is_package_installed() {
    local package="$1"
    pacman -Qi "$package" &>/dev/null
}

# Install single package
install_package() {
    local package="$1"
    
    if is_package_installed "$package"; then
        log_info "$package is already installed"
        return 0
    fi
    
    log_info "Installing $package..."
    install_official_packages "$package"
}

export -f detect_aur_helper install_official_packages install_aur_packages
export -f install_from_package_list is_package_installed install_package

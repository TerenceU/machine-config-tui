#!/bin/bash
# zoxide.sh - Install zoxide (smarter cd command)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
source "${SCRIPT_DIR}/lib/utils.sh"
source "${SCRIPT_DIR}/lib/package-manager.sh"

COMPONENT_NAME="zoxide"
PACKAGE_FILE="${SCRIPT_DIR}/packages/shell-extras/${COMPONENT_NAME}.txt"

main() {
    log_info "Installing zoxide (smarter cd command)..."

    # Install packages
    if [[ -f "$PACKAGE_FILE" ]]; then
        install_from_package_list "$PACKAGE_FILE" || {
            log_error "Failed to install packages"
            return 1
        }
    else
        install_package "zoxide"
    fi

    # Add zoxide init to Fish config if not already present
    local fish_config="$HOME/.config/fish/config.fish"
    if [[ -f "$fish_config" ]] && ! grep -q "zoxide init" "$fish_config"; then
        log_info "Adding zoxide init to Fish config..."
        echo "" >> "$fish_config"
        echo "# Zoxide - smart cd replacement" >> "$fish_config"
        echo "zoxide init --cmd cd fish | source" >> "$fish_config"
        log_success "Fish config updated"
    else
        log_info "Fish config already configured for zoxide"
    fi

    # Create cdf function (interactive cd via fzf)
    local functions_dir="$HOME/.config/fish/functions"
    mkdir -p "$functions_dir"
    if [[ ! -f "${functions_dir}/cdf.fish" ]]; then
        cat > "${functions_dir}/cdf.fish" << 'EOF'
function cdf --description "Interactive cd using zoxide + fzf"
    cdi $argv
end
EOF
        log_success "cdf function created"
    fi

    log_success "Zoxide installed!"
    log_info "Commands: cd <dir> (smart jump), cdf (interactive with fzf), z/zi still available"
    return 0
}

main "$@"

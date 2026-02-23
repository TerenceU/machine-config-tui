#!/bin/bash
# hacksnippets-setup.sh - Install HackSnippets Walker menu

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
source "${SCRIPT_DIR}/lib/utils.sh"
source "${SCRIPT_DIR}/lib/package-manager.sh"
source "${SCRIPT_DIR}/lib/stow-manager.sh"

COMPONENT_NAME="hyprland"

main() {
    log_header "HackSnippets Setup"
    log_info "Installs the HackSnippets Walker dmenu (Super+H)"
    log_info "Provides: reverse shells, listeners, enumeration, file transfer, hash cracking, web attacks, MSF payloads"
    echo ""

    # Ensure jq is installed (required by hacksnippets.sh)
    if ! command_exists jq; then
        log_info "Installing dependency: jq..."
        install_package "jq" || {
            log_error "Failed to install jq"
            return 1
        }
    else
        log_success "✓ jq already installed"
    fi

    # Ensure wl-clipboard is installed
    if ! command_exists wl-copy; then
        log_info "Installing dependency: wl-clipboard..."
        install_package "wl-clipboard" || {
            log_error "Failed to install wl-clipboard"
            return 1
        }
    else
        log_success "✓ wl-clipboard already installed"
    fi

    # Stow hyprland config (deploys hacksnippets.sh + snippets.json + binds.conf)
    log_info "Deploying HackSnippets scripts via stow..."
    stow_component "$COMPONENT_NAME" || {
        log_error "Failed to stow hyprland configuration"
        return 1
    }

    # Make script executable
    local script_path="$HOME/.config/hypr/scripts/hacksnippets.sh"
    if [[ -f "$script_path" ]]; then
        chmod +x "$script_path"
        log_success "✓ hacksnippets.sh deployed and made executable"
    fi

    echo ""
    log_success "HackSnippets installed!"
    log_info "Keybind: Super+H"
    log_info "Reload Hyprland with: hyprctl reload"
    echo ""
    gum style --foreground 212 "Press Enter to continue..."
    read -r
}

main "$@"

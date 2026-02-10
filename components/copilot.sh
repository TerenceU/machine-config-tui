#!/bin/bash
# copilot.sh - Install GitHub Copilot CLI

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/utils.sh"
source "${SCRIPT_DIR}/lib/package-manager.sh"
source "${SCRIPT_DIR}/lib/stow-manager.sh"

COMPONENT_NAME="copilot"
PACKAGE_FILE="${SCRIPT_DIR}/packages/${COMPONENT_NAME}.txt"

main() {
    log_info "Installing GitHub Copilot CLI..."
    
    # Install GitHub CLI
    if [[ -f "$PACKAGE_FILE" ]]; then
        install_from_package_list "$PACKAGE_FILE" || {
            log_error "Failed to install GitHub CLI"
            return 1
        }
    else
        log_warning "Package list not found, installing github-cli"
        install_package "github-cli"
    fi
    
    # Stow configuration
    log_info "Setting up Copilot CLI configuration..."
    stow_component "$COMPONENT_NAME" || {
        log_error "Failed to stow configuration"
        return 1
    }
    
    # Check if user is authenticated
    if ! gh auth status &>/dev/null; then
        log_warning "GitHub CLI not authenticated!"
        log_info "Please run: gh auth login"
    fi
    
    # Check if Copilot is available
    log_info "Checking Copilot CLI availability..."
    if gh copilot --help &>/dev/null; then
        log_success "Copilot CLI is available!"
    else
        log_info "First run will download Copilot CLI automatically"
    fi
    
    log_success "GitHub Copilot CLI installation complete!"
    log_info ""
    log_info "Next steps:"
    log_info "  1. Authenticate: gh auth login"
    log_info "  2. Install 'notes' component for Copilot context files"
    log_info "  3. Start Copilot: gh copilot"
    log_info ""
    log_info "Copilot will automatically load context from ~/Documents/Notes/Copilot/"
    
    return 0
}

main "$@"

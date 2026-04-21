#!/bin/bash
# dev-tools.sh - Install development tools

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/utils.sh"
source "${SCRIPT_DIR}/lib/package-manager.sh"

COMPONENT_NAME="dev-tools"
PACKAGE_FILE="${SCRIPT_DIR}/packages/${COMPONENT_NAME}.txt"

main() {
    log_info "Installing development tools..."

    if [[ -f "$PACKAGE_FILE" ]]; then
        install_from_package_list "$PACKAGE_FILE" || {
            log_error "Failed to install packages"
            return 1
        }
    else
        install_official_packages git postgresql docker docker-buildx docker-compose gum httpie stow
        install_aur_packages code pnpm gvm
    fi

    log_info "Enabling Docker service..."
    sudo systemctl enable --now docker
    sudo usermod -aG docker "$USER"
    log_info "Docker group added — re-login required to use docker without sudo"

    log_success "Dev tools installation complete!"
    return 0
}

main "$@"

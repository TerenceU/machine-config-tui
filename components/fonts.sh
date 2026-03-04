#!/bin/bash
# fonts.sh - Install system fonts

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/utils.sh"
source "${SCRIPT_DIR}/lib/package-manager.sh"

COMPONENT_NAME="fonts"
PACKAGE_FILE="${SCRIPT_DIR}/packages/${COMPONENT_NAME}.txt"

main() {
    log_info "Installing system fonts..."

    if [[ -f "$PACKAGE_FILE" ]]; then
        install_from_package_list "$PACKAGE_FILE" || {
            log_error "Failed to install packages"
            return 1
        }
    else
        install_official_packages ttf-hack-nerd noto-fonts noto-fonts-emoji ttf-dejavu ttf-jetbrains-mono-nerd
    fi

    log_info "Refreshing font cache..."
    fc-cache -fv &>/dev/null

    log_success "Fonts installation complete!"
    return 0
}

main "$@"

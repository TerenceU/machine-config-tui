#!/bin/bash
# audio.sh - Install audio stack (PipeWire)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/utils.sh"
source "${SCRIPT_DIR}/lib/package-manager.sh"

COMPONENT_NAME="audio"
PACKAGE_FILE="${SCRIPT_DIR}/packages/${COMPONENT_NAME}.txt"

main() {
    log_info "Installing audio stack (PipeWire)..."

    if [[ -f "$PACKAGE_FILE" ]]; then
        install_from_package_list "$PACKAGE_FILE" || {
            log_error "Failed to install packages"
            return 1
        }
    else
        install_official_packages pipewire pipewire-pulse wireplumber pavucontrol
    fi

    log_info "Enabling pipewire services..."
    systemctl --user enable --now pipewire pipewire-pulse wireplumber

    log_success "Audio installation complete!"
    return 0
}

main "$@"

#!/bin/bash
# setup.sh - Install vm-curator and QEMU packages, initialize vm-space

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
source "${SCRIPT_DIR}/lib/utils.sh"
source "${SCRIPT_DIR}/lib/package-manager.sh"

PACKAGE_FILE="${SCRIPT_DIR}/packages/vm-curator.txt"
VM_LIBRARY="${HOME}/vm-space"

main() {
    log_info "Installing vm-curator and QEMU stack..."

    if [[ -f "$PACKAGE_FILE" ]]; then
        install_from_package_list "$PACKAGE_FILE" || {
            log_error "Failed to install packages"
            return 1
        }
    else
        install_official_packages qemu-desktop qemu-audio-pipewire qemu-hw-display-virtio-vga qemu-hw-display-virtio-vga-gl qemu-hw-uefi-vars qemu-ui-opengl qemu-ui-sdl
        install_aur_packages vm-curator
    fi

    # Create VM library directory
    if [[ ! -d "$VM_LIBRARY" ]]; then
        log_info "Creating VM library at ${VM_LIBRARY}..."
        mkdir -p "$VM_LIBRARY"
        log_success "VM library created"
    else
        log_info "VM library already exists at ${VM_LIBRARY}"
    fi

    log_success "vm-curator setup complete!"
    log_info "Launch with: vm-curator"
    return 0
}

main "$@"

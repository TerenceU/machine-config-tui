#!/bin/bash
# remnux.sh - Import REMnux OVA into vm-curator library

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
source "${SCRIPT_DIR}/lib/utils.sh"

VM_LIBRARY="${HOME}/vm-space"
VM_DIR="${VM_LIBRARY}/remnux"
OVA_DEFAULT="${HOME}/Downloads/remnux-noble-amd64.ova"

main() {
    log_header "REMnux Import"

    # Check if already imported
    if [[ -f "${VM_DIR}/launch.sh" ]]; then
        log_info "REMnux is already imported at ${VM_DIR}"
        if ! gum confirm "Re-import and overwrite?"; then
            return 0
        fi
    fi

    # Ask for OVA path
    log_info "Looking for REMnux OVA..."
    local ova_path

    if [[ -f "$OVA_DEFAULT" ]]; then
        log_success "Found: ${OVA_DEFAULT}"
        ova_path="$OVA_DEFAULT"
    else
        log_warning "OVA not found at default location: ${OVA_DEFAULT}"
        ova_path=$(gum input --placeholder "Enter full path to remnux OVA file")
        if [[ -z "$ova_path" || ! -f "$ova_path" ]]; then
            log_error "OVA file not found: ${ova_path}"
            return 1
        fi
    fi

    # Check dependencies
    if ! command_exists qemu-img; then
        log_error "qemu-img not found. Run 'vm-curator → setup' first."
        return 1
    fi

    # Check disk space (need ~25GB free)
    local available_gb
    available_gb=$(df --output=avail -BG "${VM_LIBRARY}" 2>/dev/null | tail -1 | tr -d 'G ')
    if [[ "$available_gb" -lt 25 ]]; then
        log_warning "Low disk space: ${available_gb}GB available, ~25GB recommended"
        if ! gum confirm "Continue anyway?"; then
            return 1
        fi
    fi

    # Create VM directory
    mkdir -p "$VM_DIR"

    # Step 1: Extract OVA
    log_info "Step 1/3: Extracting OVA..."
    local tmp_dir
    tmp_dir=$(mktemp -d)
    tar -xf "$ova_path" -C "$tmp_dir" || {
        log_error "Failed to extract OVA"
        rm -rf "$tmp_dir"
        return 1
    }

    # Find the VMDK (may be gzipped)
    local vmdk_path
    vmdk_path=$(find "$tmp_dir" -name "*.vmdk.gz" | head -1)
    local vmdk_final

    if [[ -n "$vmdk_path" ]]; then
        # Step 2: Decompress VMDK
        log_info "Step 2/3: Decompressing VMDK (this may take a while)..."
        gunzip "$vmdk_path" || {
            log_error "Failed to decompress VMDK"
            rm -rf "$tmp_dir"
            return 1
        }
        vmdk_final="${vmdk_path%.gz}"
    else
        vmdk_final=$(find "$tmp_dir" -name "*.vmdk" | head -1)
        log_info "Step 2/3: VMDK already decompressed, skipping..."
    fi

    if [[ -z "$vmdk_final" || ! -f "$vmdk_final" ]]; then
        log_error "Could not find VMDK in OVA archive"
        rm -rf "$tmp_dir"
        return 1
    fi

    # Step 3: Convert VMDK to qcow2
    log_info "Step 3/3: Converting VMDK → qcow2 (this may take several minutes)..."
    qemu-img convert -p -f vmdk -O qcow2 "$vmdk_final" "${VM_DIR}/remnux.qcow2" || {
        log_error "Failed to convert VMDK to qcow2"
        rm -rf "$tmp_dir"
        return 1
    }

    # Cleanup temp files
    rm -rf "$tmp_dir"

    # Create launch.sh
    cat > "${VM_DIR}/launch.sh" << 'EOF'
#!/bin/bash
# REMnux - Linux Malware Analysis Distribution (Ubuntu 24.04 Noble)

VM_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

qemu-system-x86_64 \
    -enable-kvm \
    -m 4096 \
    -cpu host \
    -smp cores=2,threads=2 \
    -drive file="${VM_DIR}/remnux.qcow2",if=virtio,format=qcow2,cache=writeback \
    -netdev user,id=net0,hostfwd=tcp::2222-:22 \
    -device virtio-net-pci,netdev=net0 \
    -audiodev pipewire,id=audio0 \
    -device intel-hda \
    -device hda-duplex,audiodev=audio0 \
    -vga virtio \
    -display sdl \
    -usb \
    -device usb-tablet \
    -name "REMnux" \
    "$@"
EOF
    chmod +x "${VM_DIR}/launch.sh"

    # Create vm-curator.toml
    cat > "${VM_DIR}/vm-curator.toml" << 'EOF'
# VM Curator metadata

display_name = "REMnux"
os_profile = "ubuntu"
EOF

    log_success "REMnux imported successfully!"
    log_info "VM location: ${VM_DIR}"
    log_info "SSH access: ssh -p 2222 remnux@localhost"
    log_info "Launch with: vm-curator"
    return 0
}

main "$@"

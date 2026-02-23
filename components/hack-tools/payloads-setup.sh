#!/bin/bash
# payloads-setup.sh - Install /usr/share/payloads/ directory
# Copies reverse shell payload templates organized by language.
# Source: TryHackMe - Shells Overview, Task 6

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
PAYLOAD_SRC="${SCRIPT_DIR}/config/payloads/usr/share/payloads"
PAYLOAD_DEST="/usr/share/payloads"

source "${SCRIPT_DIR}/lib/utils.sh"

main() {
    log_header "Payloads Setup"
    log_info "Installs reverse shell templates to ${PAYLOAD_DEST}"
    log_info "Languages: bash, php, python, others (telnet, awk)"
    log_info "Source: TryHackMe - Shells Overview, Task 6"
    echo ""
    log_warning "Requires sudo to write to /usr/share/"
    echo ""

    if ! gum confirm "Install payloads to ${PAYLOAD_DEST}?"; then
        log_info "Cancelled."
        return 0
    fi

    # Create destination directories
    log_info "Creating directories..."
    sudo mkdir -p "${PAYLOAD_DEST}"/{bash,php,python,others} || {
        log_error "Failed to create directories (sudo required)"
        return 1
    }

    # Copy all payload files
    log_info "Copying payload files..."
    sudo cp -r "${PAYLOAD_SRC}"/. "${PAYLOAD_DEST}/" || {
        log_error "Failed to copy payload files"
        return 1
    }

    # Set readable permissions
    sudo chmod -R 644 "${PAYLOAD_DEST}"/**/* 2>/dev/null || true
    sudo chmod -R 755 "${PAYLOAD_DEST}" 2>/dev/null || true

    echo ""
    log_success "✓ Payloads installed to ${PAYLOAD_DEST}"
    echo ""

    # Show summary
    log_info "Structure:"
    find "${PAYLOAD_DEST}" -type f | sort | while read -r f; do
        echo "  ${f#$PAYLOAD_DEST/}"
    done

    echo ""
    log_info "Usage: cat /usr/share/payloads/<lang>/<file>"
    log_info "Replace ATTACKER_IP and PORT in each file before use."
    echo ""
    gum style --foreground 212 "Press Enter to continue..."
    read -r
}

main "$@"

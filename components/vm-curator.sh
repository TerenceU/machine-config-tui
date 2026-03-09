#!/bin/bash
# vm-curator.sh - VM Curator submenu

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/utils.sh"

main() {
    if ! command_exists gum; then
        log_error "gum is required for submenu"
        return 1
    fi

    while true; do
        log_header "VM Curator"

        log_info "Navigate with ↑↓ arrows, Enter to select"
        echo ""

        local choice=$(gum choose --height 10 \
            "← Back" \
            "──────────────" \
            "setup" \
            "remnux")

        case "$choice" in
            "← Back"|""|"──────────────")
                return 0
                ;;
            "setup")
                bash "${SCRIPT_DIR}/components/vm-curator/setup.sh"
                ;;
            "remnux")
                bash "${SCRIPT_DIR}/components/vm-curator/remnux.sh"
                ;;
        esac
    done
}

main "$@"

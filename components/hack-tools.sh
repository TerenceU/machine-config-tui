#!/bin/bash
# hack-tools.sh - Hack tools submenu

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/utils.sh"

# Show hack tools menu
show_hack_tools_menu() {
    if ! command_exists gum; then
        log_error "gum is required for submenu"
        return 1
    fi
    
    while true; do
        log_header "Hack Tools"
        
        log_info "Navigate with ↑↓ arrows, Enter to select"
        echo ""
        
        local choice=$(gum choose --height 10 \
            "← Back" \
            "──────────────" \
            "Pentest Tools" \
            "Wordlists")
        
        case "$choice" in
            "← Back"|""|"──────────────")
                return 0
                ;;
            "Pentest Tools")
                bash "${SCRIPT_DIR}/components/hack-tools/pentest-tools.sh"
                ;;
            "Wordlists")
                bash "${SCRIPT_DIR}/components/hack-tools/wordlists.sh"
                ;;
        esac
    done
}

main() {
    show_hack_tools_menu
}

main "$@"

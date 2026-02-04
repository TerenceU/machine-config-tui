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
    
    log_header "Hack Tools Menu"
    
    local choice=$(gum choose \
        "Pentest Tools" \
        "Wordlists" \
        "Back to main menu")
    
    case "$choice" in
        "Pentest Tools")
            bash "${SCRIPT_DIR}/components/hack-tools/pentest-tools.sh"
            ;;
        "Wordlists")
            bash "${SCRIPT_DIR}/components/hack-tools/wordlists.sh"
            ;;
        "Back to main menu")
            return 0
            ;;
    esac
}

main() {
    show_hack_tools_menu
}

main "$@"

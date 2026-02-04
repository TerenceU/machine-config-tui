#!/bin/bash
# utils.sh - Utility functions for machine-config-tui

# Colors
COLOR_RESET='\033[0m'
COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[1;33m'
COLOR_BLUE='\033[0;34m'
COLOR_ORANGE='\033[0;33m'

# Logging functions
log_info() {
    echo -e "${COLOR_BLUE}[INFO]${COLOR_RESET} $1"
}

log_success() {
    echo -e "${COLOR_GREEN}[SUCCESS]${COLOR_RESET} $1"
}

log_warning() {
    echo -e "${COLOR_YELLOW}[WARNING]${COLOR_RESET} $1"
}

log_error() {
    echo -e "${COLOR_RED}[ERROR]${COLOR_RESET} $1"
}

log_header() {
    echo ""
    echo -e "${COLOR_ORANGE}╔══════════════════════════════════════════════════════════════════╗${COLOR_RESET}"
    echo -e "${COLOR_ORANGE}║${COLOR_RESET}  $1"
    echo -e "${COLOR_ORANGE}╚══════════════════════════════════════════════════════════════════╝${COLOR_RESET}"
    echo ""
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if running as root
is_root() {
    [[ $EUID -eq 0 ]]
}

# Require root privileges
require_root() {
    if ! is_root; then
        log_error "This operation requires root privileges. Please run with sudo."
        exit 1
    fi
}

# Check if file/directory exists and ask for confirmation to overwrite
check_and_confirm() {
    local path="$1"
    local name="$2"
    
    if [[ -e "$path" ]]; then
        log_warning "$name already exists at: $path"
        if command_exists gum; then
            gum confirm "Overwrite existing $name?" || return 1
        else
            read -p "Overwrite existing $name? [y/N] " -n 1 -r
            echo
            [[ $REPLY =~ ^[Yy]$ ]] || return 1
        fi
    fi
    return 0
}

# Create backup of file/directory
backup_path() {
    local path="$1"
    local backup_dir="${HOME}/.config-backups"
    local timestamp=$(date +%Y%m%d_%H%M%S)
    
    if [[ -e "$path" ]]; then
        mkdir -p "$backup_dir"
        local backup_name="$(basename "$path").${timestamp}.backup"
        log_info "Creating backup: $backup_dir/$backup_name"
        cp -r "$path" "$backup_dir/$backup_name"
        log_success "Backup created successfully"
    fi
}

# Write to log file
write_log() {
    local log_file="/tmp/machine-config-tui.log"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$log_file"
}

# Show spinner for long operations (if gum is not available)
spinner() {
    local pid=$1
    local message=$2
    local delay=0.1
    local spinstr='|/-\'
    
    while ps -p $pid > /dev/null 2>&1; do
        local temp=${spinstr#?}
        printf " [%c] %s" "$spinstr" "$message"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\r"
    done
    printf "    \r"
}

# Check Arch Linux
check_arch_linux() {
    if [[ ! -f /etc/arch-release ]]; then
        log_error "This script is designed for Arch Linux only"
        exit 1
    fi
}

# Array contains element
array_contains() {
    local element="$1"
    shift
    local array=("$@")
    
    for item in "${array[@]}"; do
        [[ "$item" == "$element" ]] && return 0
    done
    return 1
}

# Export all functions
export -f log_info log_success log_warning log_error log_header
export -f command_exists is_root require_root
export -f check_and_confirm backup_path write_log spinner
export -f check_arch_linux array_contains

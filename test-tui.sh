#!/bin/bash
# Quick test to verify submenu detection

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMPONENTS_DIR="${SCRIPT_DIR}/components"

echo "Testing submenu detection..."
echo ""

for script in "$COMPONENTS_DIR"/*.sh; do
    component=$(basename "$script" .sh)
    
    if [[ -d "${COMPONENTS_DIR}/${component}" ]]; then
        echo "✓ SUBMENU: $component 📂"
        echo "  Has subdirectory: components/${component}/"
        
        # Check for sub-scripts
        count=$(find "${COMPONENTS_DIR}/${component}" -name '*.sh' -type f | wc -l)
        echo "  Contains: $count sub-scripts"
    else
        echo "  Regular: $component"
    fi
done

echo ""
echo "To test the TUI, run: ./install.sh"
echo "Look for components with 📂 - those will open submenus!"

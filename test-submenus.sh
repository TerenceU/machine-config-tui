#!/bin/bash
# test-submenus.sh - Quick test script for submenu functionality

cd "$(dirname "$0")"

echo "════════════════════════════════════════════════════════════"
echo "  Machine Config TUI - Submenu Test"
echo "════════════════════════════════════════════════════════════"
echo ""

# Test 1: Check shell-extras structure
echo "✓ Testing shell-extras submenu..."
if [[ -d "components/shell-extras" ]]; then
    count=$(ls components/shell-extras/*.sh 2>/dev/null | wc -l)
    echo "  Found $count shell-extras components:"
    ls components/shell-extras/*.sh 2>/dev/null | xargs -n1 basename | sed 's/.sh$//' | sed 's/^/    - /'
else
    echo "  ✗ shell-extras directory not found"
fi
echo ""

# Test 2: Check hack-tools structure
echo "✓ Testing hack-tools submenu..."
if [[ -f "components/hack-tools.sh" ]]; then
    echo "  Main menu: hack-tools.sh ✓"
    
    if [[ -d "components/hack-tools/pentest-tools" ]]; then
        count=$(ls components/hack-tools/pentest-tools/*.sh 2>/dev/null | wc -l)
        echo "  Pentest tools ($count):"
        ls components/hack-tools/pentest-tools/*.sh 2>/dev/null | xargs -n1 basename | sed 's/.sh$//' | sed 's/^/    - /'
    fi
    
    if [[ -d "components/hack-tools/wordlists" ]]; then
        count=$(ls components/hack-tools/wordlists/*.sh 2>/dev/null | wc -l)
        echo "  Wordlists ($count):"
        ls components/hack-tools/wordlists/*.sh 2>/dev/null | xargs -n1 basename | sed 's/.sh$//' | sed 's/^/    - /'
    fi
else
    echo "  ✗ hack-tools.sh not found"
fi
echo ""

# Test 3: Check config organization
echo "✓ Testing config organization..."
for dir in config/shell-extras-*; do
    if [[ -d "$dir" ]]; then
        echo "  $(basename "$dir"):"
        ls "$dir" 2>/dev/null | sed 's/^/    /'
    fi
done
echo ""

# Test 4: Check package lists
echo "✓ Testing package lists..."
if [[ -d "packages/shell-extras" ]]; then
    echo "  Shell extras packages:"
    ls packages/shell-extras/*.txt 2>/dev/null | xargs -n1 basename | sed 's/.txt$//' | sed 's/^/    - /'
fi
echo ""

# Summary
echo "════════════════════════════════════════════════════════════"
echo "  Summary"
echo "════════════════════════════════════════════════════════════"
total_scripts=$(find components -name '*.sh' | wc -l)
main_components=$(find components -maxdepth 1 -name '*.sh' | wc -l)
echo "Total component scripts: $total_scripts"
echo "Main menu components: $main_components"
echo "Shell extras: $(find components/shell-extras -name '*.sh' 2>/dev/null | wc -l)"
echo "Pentest tools: $(find components/hack-tools/pentest-tools -name '*.sh' 2>/dev/null | wc -l)"
echo "Wordlists: $(find components/hack-tools/wordlists -name '*.sh' 2>/dev/null | wc -l)"
echo ""
echo "Ready to test! Run: ./install.sh"

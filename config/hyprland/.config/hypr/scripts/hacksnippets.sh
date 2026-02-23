#!/bin/bash
# hacksnippets.sh - HackSnippets Walker menu
# Super+H → seleziona categoria → seleziona snippet → inserisci variabili → copia in clipboard

SNIPPETS="$HOME/.config/hypr/scripts/snippets.json"
NOTIFY="notify-send -a HackSnippets -t 3000"

# --- Seleziona categoria ---
category=$(jq -r '.categories[].name' "$SNIPPETS" | walker --dmenu --placeholder "🔥 HackSnippets - Categoria")
[[ -z "$category" ]] && exit 0

# --- Seleziona snippet ---
snippet_label=$(jq -r --arg cat "$category" \
  '.categories[] | select(.name == $cat) | .snippets[].label' "$SNIPPETS" \
  | walker --dmenu --placeholder "📋 $category")
[[ -z "$snippet_label" ]] && exit 0

# --- Recupera il comando ---
command=$(jq -r --arg cat "$category" --arg label "$snippet_label" \
  '.categories[] | select(.name == $cat) | .snippets[] | select(.label == $label) | .command' \
  "$SNIPPETS")

# --- Gestione variabili dinamiche {{VAR}} ---
# Trova tutte le variabili uniche nel comando
vars=$(grep -oP '\{\{[A-Z0-9_]+\}\}' <<< "$command" | sort -u)

if [[ -n "$vars" ]]; then
  while IFS= read -r var; do
    varname="${var//\{\{/}"
    varname="${varname//\}\}/}"

    # Prepopola con valori comuni
    default=""
    case "$varname" in
      LHOST) default="$(ip -4 addr show tun0 2>/dev/null | grep -oP '(?<=inet )\d+\.\d+\.\d+\.\d+' | head -1)"
             [[ -z "$default" ]] && default="$(ip -4 addr show eth0 2>/dev/null | grep -oP '(?<=inet )\d+\.\d+\.\d+\.\d+' | head -1)" ;;
      LPORT) default="4444" ;;
      PORT)  default="8080" ;;
      ROWS)  default="$(tput lines 2>/dev/null || echo 40)" ;;
      COLS)  default="$(tput cols 2>/dev/null || echo 150)" ;;
    esac

    value=$(echo "$default" | walker --dmenu --inputonly --placeholder "$varname")
    [[ -z "$value" ]] && exit 0

    command="${command//$var/$value}"
  done <<< "$vars"
fi

# --- Copia in clipboard ---
echo -n "$command" | wl-copy

$NOTIFY "✅ Snippet copiato!" "$snippet_label\n<tt>$command</tt>"

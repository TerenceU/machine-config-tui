#!/usr/bin/env bash

layout="$(
  /usr/sbin/hyprctl devices 2>/dev/null | python3 -c '
import sys

lines = sys.stdin.read().splitlines()
in_keyboards = False
current_keymap = None
main_keymap = None

for line in lines:
    stripped = line.strip()

    if stripped == "Keyboards:":
        in_keyboards = True
        continue
    if in_keyboards and stripped in {"Tablets:", "Touch:", "Switches:"}:
        break

    if not in_keyboards:
        continue

    if stripped.startswith("Keyboard at "):
        current_keymap = None
        continue

    if stripped.startswith("active keymap:"):
        current_keymap = stripped.split(":", 1)[1].strip()
        continue

    if stripped.startswith("main:") and stripped.split(":", 1)[1].strip() == "yes":
        main_keymap = current_keymap
        break

keymap = (main_keymap or current_keymap or "").lower()
if "colemak" in keymap:
    print(" CMK")
elif "italian" in keymap or keymap == "it":
    print(" IT")
elif keymap:
    print(f" {keymap[:8].upper()}")
else:
    print(" ?")
'
)"

printf '%s\n' "$layout"

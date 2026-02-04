#!/bin/bash

choice=$(printf "cmyk\nhex\nrgb\nhsl\nhsv" | walker --dmenu)

case "$choice" in
"cmyk") hyprpicker -f cmyk -a ;;
"hex") hyprpicker -f hex -a ;;
"rgb") hyprpicker -f rgb -a ;;
"hsl") hyprpicker -f hsl -a ;;
"hsv") hyprpicker -f hsv -a ;;
esac

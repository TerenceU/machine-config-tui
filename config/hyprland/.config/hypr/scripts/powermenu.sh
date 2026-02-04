#!/bin/bash

choice=$(printf " Lock\n Logout\n Reboot\n Shutdown" | walker --dmenu)

case "$choice" in
" Lock") hyprlock ;;
" Logout") hyprctl dispatch exit ;;
" Reboot") systemctl reboot ;;
" Shutdown") systemctl poweroff ;;
esac

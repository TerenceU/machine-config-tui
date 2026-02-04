function tmux_rename_window
    if set -q TMUX
        # Prompt user for new name
        read -P "Nuovo nome finestra: " new_name
        if test -n "$new_name"
            tmux rename-window "$new_name"
        end
    end
    commandline -f repaint
end

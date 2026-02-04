function tmux_new_window
    if set -q TMUX
        tmux new-window
    end
    commandline -f repaint
end

function tmux_prev_window
    if set -q TMUX
        tmux previous-window
    end
    commandline -f repaint
end

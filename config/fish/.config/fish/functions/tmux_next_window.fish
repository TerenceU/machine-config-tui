function tmux_next_window
    if set -q TMUX
        tmux next-window
    end
    commandline -f repaint
end

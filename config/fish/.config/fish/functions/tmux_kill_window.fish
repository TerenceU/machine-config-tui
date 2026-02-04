function tmux_kill_window
    if set -q TMUX
        tmux kill-window
    end
    commandline -f repaint
end

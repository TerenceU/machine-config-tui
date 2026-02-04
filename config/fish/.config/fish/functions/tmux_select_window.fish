function tmux_select_window
    if set -q TMUX
        tmux select-window -t $argv[1]
    end
    commandline -f repaint
end

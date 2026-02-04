function tmux_detach
    if set -q TMUX
        tmux detach-client
    end
    commandline -f repaint
end

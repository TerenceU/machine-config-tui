function tmux_kill_session
    if set -q TMUX
        tmux switch-client -n
        tmux kill-session -t "#S"
    end
    commandline -f repaint
end

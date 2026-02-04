function tmux_choose_session
    if set -q TMUX
        tmux choose-session
    end
    commandline -f repaint
end

function tmux_copy_mode
    # Check if we're inside tmux
    if set -q TMUX
        # Enter tmux copy mode
        tmux copy-mode
        commandline -f repaint
    end
end

function tmux_paste
    # Paste from system clipboard
    if command -v wl-paste >/dev/null 2>&1
        commandline -i (wl-paste)
    end
end

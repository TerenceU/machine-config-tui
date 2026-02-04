if status is-interactive

    set -Ux EDITOR nvim .
    set -Ux HYPRSHOT_DIR /home/terence/Images/Screenshots
    set -Ux XDG_CONFIG_DIRS /home/terence/.config
    set -Ux XDG_CONFIG_HOME "$HOME/.config"
    set -Ux XDG_CONFIG_DIRS /etc/xdg
    set -Ux XDG_DATA_HOME "$HOME/.local/share"
    set -Ux XDG_CACHE_HOME "$HOME/.cache"
    set -g fish_key_bindings fish_vi_key_bindings
    
    # Force start in normal mode (vi command mode)
    function fish_user_key_bindings
        fish_vi_key_bindings
        set -g fish_bind_mode default
    end

    # Auto-start tmux if not already inside tmux
    if not set -q TMUX
        if command -v tmux >/dev/null 2>&1
            # Attach to existing session or create new one
            tmux attach-session -t default 2>/dev/null; or tmux new-session -s default
        end
    end

    # Tmux integration: v in normal mode enters tmux copy-mode
    bind -M default v tmux_copy_mode
    
    # Paste from system clipboard with p in normal mode
    bind -M default p tmux_paste
    
    # SHIFT + letter in normal mode for tmux controls
    bind -M default H tmux_prev_window
    bind -M default L tmux_next_window
    bind -M default T tmux_new_window
    bind -M default D tmux_kill_window
    bind -M default S tmux_choose_session
    bind -M default Q tmux_detach
    bind -M default R tmux_rename_window
    bind -M default X tmux_kill_session
    
    # Plain numbers (1-9) to select tmux windows in normal mode
    bind -M default 1 'tmux_select_window 1'
    bind -M default 2 'tmux_select_window 2'
    bind -M default 3 'tmux_select_window 3'
    bind -M default 4 'tmux_select_window 4'
    bind -M default 5 'tmux_select_window 5'
    bind -M default 6 'tmux_select_window 6'
    bind -M default 7 'tmux_select_window 7'
    bind -M default 8 'tmux_select_window 8'
    bind -M default 9 'tmux_select_window 9'
    
    # Start in normal mode
    function fish_default_mode_prompt; end
    function fish_mode_prompt
        switch $fish_bind_mode
            case default
                set_color --bold green
                echo '[N] '
            case insert
                set_color --bold blue
                echo '[I] '
            case replace_one
                set_color --bold yellow
                echo '[R] '
            case visual
                set_color --bold magenta
                echo '[V] '
        end
        set_color normal
    end
    
    # Return to normal mode after executing command
    function postexec_normal_mode --on-event fish_postexec
        fish_default_key_bindings
        fish_vi_key_bindings
    end

end

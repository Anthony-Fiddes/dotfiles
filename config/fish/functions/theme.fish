function theme --on-variable=fish_terminal_color_theme
    switch $fish_terminal_color_theme
        case light
            set -gx FZF_DEFAULT_OPTS "\
        --color=bg+:#ccd0da,bg:#eff1f5,spinner:#dc8a78,hl:#d20f39 \
        --color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78 \
        --color=marker:#7287fd,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39 \
        --color=selected-bg:#bcc0cc \
        --multi"
            set -gx BAT_THEME "Catppuccin Latte"
            if type -q vivid
                set -gx LS_COLORS (vivid generate catppuccin-latte)
            else
                echo "info: `vivid` not installed, not setting LS_COLORS"
            end
        case dark
            # Configure other applications for dark mode
            set -gx FZF_DEFAULT_OPTS "\
        --color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
        --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
        --color=marker:#b7bdf8,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 \
        --color=selected-bg:#494d64 \
        --multi"
            set -gx BAT_THEME "Catppuccin Macchiato"
            if type -q vivid
                set -gx LS_COLORS (vivid generate catppuccin-macchiato)
            else
                echo "info: `vivid` not installed, not setting LS_COLORS"
            end
    end
end

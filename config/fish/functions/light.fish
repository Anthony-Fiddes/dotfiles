function light
    # made with reference to this great article:
    # https://evantravers.com/articles/2022/02/08/light-dark-toggle-for-neovim-fish-and-kitty/
    set -Ux THEME light
    kitty @ set-colors -a $XDG_CONFIG_HOME/kitty/light-theme.conf

    set -Ux FZF_DEFAULT_OPTS "\
        --color=bg+:#ccd0da,bg:#eff1f5,spinner:#dc8a78,hl:#d20f39 \
        --color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78 \
        --color=marker:#7287fd,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39 \
        --color=selected-bg:#bcc0cc \
        --multi"
    set -Ux BAT_THEME "Catppuccin Latte"

    if type -q osascript
        osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to false'
    else if type -q gsettings
        gsettings set org.gnome.desktop.interface color-scheme default
    end
end

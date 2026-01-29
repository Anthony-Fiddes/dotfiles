function light
    # made with reference to this great article:
    # https://evantravers.com/articles/2022/02/08/light-dark-toggle-for-neovim-fish-and-kitty/
    set -Ux THEME light
    kitty @ set-colors -a $XDG_CONFIG_HOME/kitty/light-theme.conf

    # erase global copies of these variables so that they can't interfere with
    # universals. I'm pretty sure I shouldn't have to do it but maybe it's
    # because I'm setting universal variables in my config rather than manually?
    set -ge FZF_DEFAULT_OPTS
    set -Ux FZF_DEFAULT_OPTS "\
        --color=bg+:#ccd0da,bg:#eff1f5,spinner:#dc8a78,hl:#d20f39 \
        --color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78 \
        --color=marker:#7287fd,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39 \
        --color=selected-bg:#bcc0cc \
        --multi"
    set -ge BAT_THEME
    set -Ux BAT_THEME "Catppuccin Latte"
    if type -q vivid
        set -ge LS_COLORS
        set -Ux LS_COLORS (vivid generate catppuccin-latte)
    else
        echo "info: `vivid` not installed, not setting LS_COLORS"
    end

    if type -q osascript
        # Taken from this article:
        # https://brettterpstra.com/2018/09/26/shell-tricks-toggling-dark-mode-from-terminal/
        osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to false'
    else if type -q gsettings
        gsettings set org.gnome.desktop.interface color-scheme default
    end
end

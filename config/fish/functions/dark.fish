function dark
    # made with reference to this great article:
    # https://evantravers.com/articles/2022/02/08/light-dark-toggle-for-neovim-fish-and-kitty/
    set -Ux THEME dark
    kitty @ set-colors -a $XDG_CONFIG_HOME/kitty/dark-theme.conf

    # erase global copies of these variables so that they can't interfere with
    # universals. I'm pretty sure I shouldn't have to do it but maybe it's
    # because I'm setting universal variables in my config rather than manually?
    set -ge FZF_DEFAULT_OPTS
    set -Ux FZF_DEFAULT_OPTS "\
        --color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
        --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
        --color=marker:#b7bdf8,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 \
        --color=selected-bg:#494d64 \
        --multi"
    set -ge BAT_THEME
    set -Ux BAT_THEME "Catppuccin Macchiato"
    if type -q vivid
        set -ge LS_COLORS
        set -Ux LS_COLORS (vivid generate catppuccin-macchiato)
    else
        echo "info: `vivid` not installed, not setting LS_COLORS"
    end

    if type -q osascript
        # Taken from this article:
        # https://brettterpstra.com/2018/09/26/shell-tricks-toggling-dark-mode-from-terminal/
        osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to true'
    else if type -q gsettings
        gsettings set org.gnome.desktop.interface color-scheme prefer-dark
    end
end

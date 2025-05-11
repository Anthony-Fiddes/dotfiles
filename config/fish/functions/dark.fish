function dark
    # made with reference to this great article:
    # https://evantravers.com/articles/2022/02/08/light-dark-toggle-for-neovim-fish-and-kitty/
    set -Ux THEME dark
    kitty @ set-colors -a $XDG_CONFIG_HOME/kitty/dark-theme.conf

    set -Ux FZF_DEFAULT_OPTS "\
        --color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
        --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
        --color=marker:#b7bdf8,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 \
        --color=selected-bg:#494d64 \
        --multi"
    set -Ux BAT_THEME "Catppuccin Macchiato"
    if type -q vivid
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

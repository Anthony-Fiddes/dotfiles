function dark
    if type -q osascript
        # Taken from this article:
        # https://brettterpstra.com/2018/09/26/shell-tricks-toggling-dark-mode-from-terminal/
        osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to true'
    else if type -q gsettings
        gsettings set org.gnome.desktop.interface color-scheme prefer-dark
    end
end

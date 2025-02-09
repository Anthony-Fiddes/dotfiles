#!/usr/bin/env fish
# Only platform agnostic stuff should go in this file

./install-config.fish

rm -r $HOME/bin
ln -s $(pwd)/bin $HOME/bin

# configure fish
if not type -q fisher
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher update
    tide configure
end

# configure neovim
git submodule update --init # nvim/ is a submodule now

# get pretty pandoc html template
mkdir -p $XDG_DATA_HOME/pandoc/templates
if not test -e $XDG_DATA_HOME/pandoc/templates/GitHub.html5
    cd $XDG_DATA_HOME/pandoc/templates/
    curl https://raw.githubusercontent.com/tajmone/pandoc-goodies/refs/heads/master/templates/html5/github/GitHub.html5 -O
    prevd
end

# install/configure latest kitty if it hasn't been installed yet
# based off instructions from https://sw.kovidgoyal.net/kitty/binary/
if not type -q kitty
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
    ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/
    cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
    sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
    sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
    echo 'kitty.desktop' >~/.config/xdg-terminals.list
end

# configure gh/git
if not gh auth status
    rm $HOME/.gitconfig
    cp ./config/.gitconfig $HOME/.gitconfig
    cp ./config/global_gitignore $HOME/.gitignore
    gh auth login
end

if type -q nvm
    nvm install latest
end

if type -q bat
    bat cache --build
end

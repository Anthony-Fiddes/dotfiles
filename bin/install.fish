#!/usr/bin/env fish
# Only platform agnostic stuff should go in here

# Requirements
if not set -q XDG_CONFIG_HOME
    set -g XDG_CONFIG_HOME $HOME/.config
end

rm -r $HOME/bin
ln -s $(pwd)/bin $HOME/bin
fish_add_path -U $HOME/bin

# configure brave
rm $XDG_CONFIG_HOME/brave-flags.conf
ln -s $(pwd)/brave-flags.conf $XDG_CONFIG_HOME/brave-flags.conf

# configure fish
rm -r $XDG_CONFIG_HOME/fish
ln -s $(pwd)/fish $XDG_CONFIG_HOME/fish
if not type -q fisher
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher update
    tide configure
end

# configure neovim
rm -r $XDG_CONFIG_HOME/nvim
git submodule update --init # nvim/ is a submodule now
ln -s $(pwd)/nvim $XDG_CONFIG_HOME/nvim

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
rm -r $XDG_CONFIG_HOME/kitty
ln -s $(pwd)/kitty $XDG_CONFIG_HOME/kitty

# configure gh/git
if not gh auth status
    rm $HOME/.gitconfig
    cp ./.gitconfig $HOME/.gitconfig
    cp ./global_gitignore $HOME/.gitignore
    gh auth login
end

ln -sf $(pwd)/.yamllint.yaml $HOME/.yamllint.yaml
ln -sf $(pwd)/.gitlint $HOME/.gitlint
ln -sf $(pwd)/.rgignore $HOME/.rgignore

if type -q nvm
    nvm install latest
end

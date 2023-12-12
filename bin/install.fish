#!/usr/bin/fish
# Only platform agnostic stuff should go in here

# Requirements
if not set -q XDG_CONFIG_HOME
    set -g XDG_CONFIG_HOME $HOME/.config
end

mkdir -p $HOME/bin
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

# configure kitty
# based off instructions from https://sw.kovidgoyal.net/kitty/binary/
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
rm -r $XDG_CONFIG_HOME/kitty
ln -s $(pwd)/kitty $XDG_CONFIG_HOME/kitty
ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
if not fc-list | grep -q -i caskaydiacove
    set cascadia "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/CascadiaCode.tar.xz"
    mkdir -p $HOME/.fonts
    curl -s -L $cascadia | tar xvfJ - --directory=$HOME/.fonts/
    sudo fc-cache -fv
end

# configure gh/git
if not gh auth status
    rm $HOME/.gitconfig
    cp ./.gitconfig $HOME/.gitconfig
    cp ./global_gitignore $HOME/.gitignore
    gh auth login
end

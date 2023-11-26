#!/usr/bin/fish

# Requirements
sudo apt install libfuse2
if not set -q XDG_CONFIG_HOME
    set -g XDG_CONFIG_HOME $HOME/.config
end

# Install useful cli tools
echo "Warning: fzf may cause errors if it's really old."
sudo apt install htop gh bat ripgrep fzf fd-find rclone
sudo add-apt-repository ppa:git-core/ppa
sudo apt update
sudo apt install git

# Install useful gui tools
sudo apt install dconf-editor

# Tool that automatically integrates desktop app images.
sudo add-apt-repository ppa:appimagelauncher-team/stable
sudo apt update
sudo apt install appimagelauncher

mkdir -p $HOME/bin
fish_add_path -U $HOME/bin

if not type -q nvim
    curl -o $HOME/bin/nvim -L https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x $HOME/bin/nvim
end

if not type -q brave-browser
    sudo curl -fsslo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt update
    sudo apt install brave-browser
end

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
# Note: may need to change the below requirements in the future
sudo apt install python3.10-venv

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

# configure global prettier
rm $HOME/.prettierrc.js
cp ./.prettierrc.js $HOME/.prettierrc.js

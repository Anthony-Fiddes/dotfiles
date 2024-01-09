#!/usr/bin/fish

# Requirements
sudo apt install libfuse2

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

# Install nvim
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

# for neovim
# Note: may need to change the below requirements in the future
sudo apt install python3.10-venv

# install caskaydia cove font
if not fc-list | grep -q -i caskaydiacove
    set cascadia "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/CascadiaCode.tar.xz"
    mkdir -p $HOME/.fonts
    curl -s -L $cascadia | tar xvfJ - --directory=$HOME/.fonts/
    sudo fc-cache -fv
end

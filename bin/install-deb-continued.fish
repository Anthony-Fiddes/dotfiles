#!/usr/bin/fish

# Requirement for rclone mounting
sudo apt install libfuse2 -y

# Install neovim requirement for mason
#
# This changes over time; the error gets reported in :MasonLog with instructions
# on what the new package name is.
sudo apt install python3.12-venv -y

# Install useful cli tools
# TODO: install rust/cargo, use it to install vivid
sudo apt install htop gh git-delta golang bat ripgrep fd-find rclone -y
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt update
sudo apt install git -y

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --bin
ln -s ~/.fzf/bin/fzf ~/bin/fzf

sudo apt install flatpak -y
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Install useful gnome tools
sudo apt install gnome-software-plugin-flatpak
sudo apt install dconf-editor gnome-shell-extension-manager -y
sudo apt install gnome-calendar -y

if not type -q brave-browser
    sudo curl -fsslo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt update
    sudo apt install brave-browser
end

# install caskaydia cove font
if not fc-list | grep -q -i caskaydiacove
    set cascadia "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaCode.tar.xz"
    mkdir -p $HOME/.fonts/CascadiaCode
    curl -s -L $cascadia | tar xvfJ - --directory=$HOME/.fonts/CascadiaCode
    sudo fc-cache -fv
end

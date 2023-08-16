#!/usr/bin/fish

# Requirements
sudo apt install libfuse2 
if not set -q XDG_CONFIG_HOME
  set -g XDG_CONFIG_HOME $HOME/.config  
end

# Install useful cli tools
sudo apt install htop gh bat ripgrep fzf fd-find rclone 

# Install useful gui tools
sudo apt install dconf-editor

# Get useful executables (just debian linux for now)
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
rm -rf $XDG_CONFIG_HOME/fish
ln -s $(pwd)/fish $XDG_CONFIG_HOME/fish
if not type -q fisher
  curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher update
  tide configure
end

# configure neovim
rm -rf $XDG_CONFIG_HOME/nvim
ln -s $(pwd)/nvim $XDG_CONFIG_HOME/nvim
sudo apt install python3.10-venv
# run twice because i find that it hangs the first time. after the first install
# it's usually pretty quick.
timeout 15s nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
timeout 15s nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

# configure kitty
rm -rf $XDG_CONFIG_HOME/kitty
ln -s $(pwd)/kitty $XDG_CONFIG_HOME/kitty
if not fc-list | grep -q -i caskaydiacove
  set cascadia "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/CascadiaCode.tar.xz"
  mkdir -p $HOME/.fonts
  curl -s -L $cascadia | tar xvfJ - --directory=$HOME/.fonts/
  sudo fc-cache -fv
end

# configure gh/git
if not gh auth status
  rm -f $HOME/.gitconfig
  cp ./.gitconfig $HOME/.gitconfig
  gh auth login
end


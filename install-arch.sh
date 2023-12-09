#!/bin/sh
yay -S fish kitty neovim fzf ripgrep github-cli go htop \
  bat xclip  flatpak
# AUR
yay -S brave-bin gnome-shell-extension-pop-shell-bin pyenv-virtualenv

chsh -s $(which fish) $USER
# Don't enable if bluetooth isn't needed
systemctl enable --now bluetooth.service

# Keep going in fish
./bin/install.fish

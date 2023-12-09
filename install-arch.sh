#!/bin/sh
yay -S fish kitty neovim fzf ripgrep github-cli go htop bat
# Optional
yay -S brave-bin touchegg gnome-shell-extension-pop-shell-bin

chsh -s $(which fish) $USER
# Don't enable if bluetooth isn't needed
systemctl enable --now bluetooth.service

# Keep going in fish
./bin/install.fish

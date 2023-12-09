#!/bin/sh
yay -S fish kitty neovim fzf ripgrep github-cli go htop bat
# Optional
yay -S brave-bin touchegg gnome-shell-extension-pop-shell-bin

chsh -s $(which fish) $USER

# Keep going in fish
./bin/install.fish

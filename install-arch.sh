#!/bin/sh
yay -S fish kitty neovim fzf ripgrep github-cli go htop bat
yay -S brave-bin

chsh -s $(which fish) $USER

# Keep going in fish
./bin/install.fish

#!/bin/bash

# Get the basics
sudo apt-add-repository ppa:fish-shell/release-4
sudo apt update && sudo apt upgrade
sudo apt install fish tldr curl make gcc -y
chsh -s $(which fish) $USER

# Install librewolf
sudo apt update && sudo apt install extrepo -y
sudo extrepo enable librewolf
sudo apt update && sudo apt install librewolf -y

# Keep going in fish
./bin/install-deb-continued.fish
./bin/install.fish

# Set kitty as default terminal
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator $(which kitty) 100

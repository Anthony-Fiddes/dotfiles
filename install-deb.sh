#!/bin/bash

# Get the basics
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt update
sudo apt upgrade
sudo apt install git fish tldr curl make
chsh -s $(which fish) $USER
update-alternatives --config x-terminal-emulator

# Keep going in fish
./bin/install-deb.fish

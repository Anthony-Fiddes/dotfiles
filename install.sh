#!/bin/bash

# Get the basics
sudo apt install git fish kitty tldr curl make
chsh -s $(which fish) $USER
update-alternatives --config x-terminal-emulator

# Keep going in fish
./bin/install.fish

#!/bin/sh
# Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# Make sure it works in default terminal/zsh
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/$USER/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Map some familiar text navigation shortcuts
mkdir -p ~/Library/KeyBindings/
cp ./os_specific/macOS/DefaultKeyBinding.dict ~/Library/KeyBindings/DefaultKeyBinding.Dict

# Essentials
brew install kitty neovim fish bat rg fzf fd
brew install htop signal go rclone
brew install librewolf --no-quarantine
brew install --cask font-cascadia-code

# QOL
# terminal-notifier is used by the notify plugin for fish
# NOTE: you may have to enable notifications for terminal-notifier/kitty in
# settings
brew install tldr mac-mouse-fix terminal-notifier
# Tiling Window Manager
brew install --cask nikitabobko/tap/aerospace
brew tap FelixKratz/formulae
brew install borders

# Make fish the default shell
if not sudo grep $(which fish) /etc/shells
  echo $(which fish) | sudo tee -a /etc/shells
end
chsh -s $(which fish) $USER

# Link aerospace functionality
ln -s $(pwd)/os_specific/macOS/aerospace.toml ~/.aerospace.toml

# Keep going in fish
./bin/install.fish

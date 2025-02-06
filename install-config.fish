#!/usr/bin/env fish
# the idea behind this file is that it should be idempotent. Run it as many
# times as you like, and get the same result.

# it's very important that there's not a trailing slash on these rm -r calls.
# This way, if it's a symlink, only the link is deleted. If it's a folder, the
# folder gets deleted.

rm -r $XDG_CONFIG_HOME/nvim
ln -s $(pwd)/config/nvim $XDG_CONFIG_HOME/nvim

rm -r $XDG_CONFIG_HOME/fish
ln -s $(pwd)/config/fish $XDG_CONFIG_HOME/fish

rm -r $XDG_CONFIG_HOME/kitty
ln -s $(pwd)/config/kitty $XDG_CONFIG_HOME/kitty

mkdir -p $XDG_CONFIG_HOME/yamllint/
ln -sf $(pwd)/config/yamllint.yaml $XDG_CONFIG_HOME/yamllint/config

mkdir -p $XDG_CONFIG_HOME/gitlint/
ln -sf $(pwd)/config/gitlint $XDG_CONFIG_HOME/gitlint/config

ln -sf $(pwd)/config/.rgignore $HOME/.rgignore

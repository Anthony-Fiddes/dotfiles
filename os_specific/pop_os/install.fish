#!/usr/bin/fish
cp ./touchegg.conf $XDG_CONFIG_HOME/touchegg/touchegg.conf
dconf load '/org/gnome/desktop/wm/keybindings/' < keybindings.dconf

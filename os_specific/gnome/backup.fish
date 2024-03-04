#!/usr/bin/fish
cp $XDG_CONFIG_HOME/touchegg/touchegg.conf ./touchegg.conf
dconf dump /org/gnome/desktop/wm/keybindings/ >keybindings.dconf
dconf dump /org/gnome/shell/extensions/pop-shell/ >pop-shell.dconf
dconf dump /org/gnome/shell/keybindings/ >gnome-shell-keybindings.dconf

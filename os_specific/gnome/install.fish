#!/usr/bin/fish
# TODO: test for the folder's existence
cp ./touchegg.conf $XDG_CONFIG_HOME/touchegg/touchegg.conf
dconf load /org/gnome/desktop/wm/keybindings/ <keybindings.dconf
dconf load /org/gnome/shell/extensions/pop-shell/ <pop-shell.dconf
dconf load /org/gnome/shell/keybindings/ <gnome-shell-keybindings.dconf

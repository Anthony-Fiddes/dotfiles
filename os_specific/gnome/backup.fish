#!/usr/bin/fish
set touchegg_dir $XDG_CONFIG_HOME/touchegg
if test -e $touchegg_dir
    cp $touchegg_dir/touchegg.conf ./touchegg.conf
end
dconf dump /org/gnome/desktop/wm/keybindings/ >keybindings.dconf
dconf dump /org/gnome/shell/extensions/pop-shell/ >pop-shell.dconf
dconf dump /org/gnome/shell/keybindings/ >gnome-shell-keybindings.dconf
dconf dump /org/gnome/mutter/ >mutter.dconf

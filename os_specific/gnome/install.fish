#!/usr/bin/fish
set touchegg_dir $XDG_CONFIG_HOME/touchegg
if test -e $touchegg_dir
    cp ./touchegg.conf $touchegg_dir/touchegg.conf
end
dconf load /org/gnome/desktop/wm/keybindings/ <keybindings.dconf
dconf load /org/gnome/shell/extensions/pop-shell/ <pop-shell.dconf
dconf load /org/gnome/shell/keybindings/ <gnome-shell-keybindings.dconf
dconf load /org/gnome/mutter/ <mutter.dconf
dconf load /org/gnome/desktop/interface/ <interface.dconf

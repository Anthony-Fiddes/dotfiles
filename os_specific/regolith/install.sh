#!/bin/bash
mkdir -p ~/.config/regolith2/i3/config.d/
sudo apt remove regolith-i3-session
cp ./55_session_keybindings_replacement ~/.config/regolith2/i3/config.d/

sudo apt remove regolith-i3-navigation
cp ./30_navigation_replacement ~/.config/regolith2/i3/config.d/

sudo apt remove regolith-i3-rofication-ilia
cp ./82_rofication-ilia_replacement ~/.config/regolith2/i3/config.d/

sudo apt remove regolith-i3-i3xrocks
cp ./70_bar_replacement ~/.config/regolith2/i3/config.d/

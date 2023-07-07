#!/bin/bash
sudo apt remove regolith-i3-session
mkdir -p ~/.config/regolith2/i3/config.d/
cp ./55_session_keybindings_replacement ~/.config/regolith2/i3/config.d/

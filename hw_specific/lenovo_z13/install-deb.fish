#!/usr/bin/fish
# Package with hardware support for the z13
sudo apt install oem-sutton.newell-abe-meta

# Configure wifi power saving
# 2 = off, 3 = on
sudo sed -i "s/wifi.powersave.*/wifi.powersave = 3/" /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf

# Install sleep script
sudo cp ./sleep_script.sh /lib/systemd/system-sleep/

# Set up fingerprints
sudo apt install fprintd libpam-fprintd
sudo pam-auth-update

# Set up Radeon iGPU utils
sudo apt install radeontop mesa-utils

# Set up trackpad gestures
sudo apt install touchegg
flatpak install com.github.joseexposito.touche

# Install script to restart touchpad
set target $XDG_CONFIG_HOME/systemd/user
mkdir -p $target
cp ./toggle_touchpad_once.service $target
cp ./restart_touchpad.sh $HOME/bin
systemctl enable --user toggle_touchpad_once
systemctl --user daemon-reload
systemctl restart --user toggle_touchpad_once

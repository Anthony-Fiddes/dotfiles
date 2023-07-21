#!/usr/bin/fish
# Package with hardware support for the z13
sudo apt install oem-sutton.newell-abe-meta

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

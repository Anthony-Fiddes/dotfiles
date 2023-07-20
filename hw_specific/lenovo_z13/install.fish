#!/usr/bin/fish
# Package with hardware support for the z13
sudo apt install oem-sutton.newell-abe-meta

# Set up fingerprints
sudo apt install fprintd libpam-fprintd
sudo pam-auth-update

# Set up Radeon iGPU utils
sudo apt install radeontop mesa-utils

# Install monitor profiles
sudo apt install wine64



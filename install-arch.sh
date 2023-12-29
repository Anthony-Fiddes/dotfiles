#!/bin/sh
yay -S fish neovim fzf ripgrep github-cli go htop \
  bat xclip flatpak git-delta nss-mdns avahi
# AUR
yay -S brave-bin gnome-shell-extension-pop-shell-bin pyenv-virtualenv

chsh -s $(which fish) $USER

# Don't enable if bluetooth isn't needed
systemctl enable --now bluetooth.service

# Disable resolved so that it doesn't conflict with avahi
# TODO: maybe learn the benefits of resolved and if that pans out, configure it
# not to conflict with avahi. I think it was disabled by default on EndeavourOS
systemctl disable --now systemd-resolved.service
# Use avahi to resolve mDNS requests
# More info: https://wiki.archlinux.org/title/avahi
systemctl enable --now avahi-daemon.service

# Keep going in fish
./bin/install.fish

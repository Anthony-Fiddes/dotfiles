#!/bin/sh
yay -S fish neovim fzf ripgrep github-cli go htop \
  bat xclip flatpak git-delta ttf-cascadia-code-nerd \
  kitty-terminfo rclone vlc timeshift \
  tesseract-data-eng zathura zathura-pdf-mupdf
# AUR
yay -S brave-bin pyenv-virtualenv timeshift-autosnap librewolf-bin
# One big update including AUR ones caused like 4 snapshots. Default was 3
sudo sed -i "s/maxSnapshots=.*/maxSnapshots=10/1" /etc/timeshift-autosnap.conf
# Gnome stuff
yay -S  dconf-editor gnome-calendar gnome-contacts \
  gnome-software gnome-firmware baobab

## AUR Gnome stuff
yay -S gnome-shell-extension-appindicator gnome-shell-extension-pop-shell gnome-shell-extension-caffeine
echo "appindicator, pop-shell, and caffeine were installed. Restart gnome and enable them in the extensions app."

chsh -s $(which fish) $USER

# Don't enable if bluetooth isn't needed
systemctl enable --now bluetooth.service

# Configure DNS settings
systemctl enable --now systemd-resolved.service
sudo rm /etc/resolv.conf
sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
sudo mkdir /etc/systemd/resolved.conf.d/
sudo cp ./os_specific/systemd/custom_resolved.conf /etc/systemd/resolved.conf.d/

# Ensure nautilus is the default folder opener
xdg-mime default org.gnome.Nautilus.desktop inode/directory

# Allow nautilus to open kitty anywhere
yay -S nautilus-open-any-terminal
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal kitty

# Keep going in fish
./bin/install.fish

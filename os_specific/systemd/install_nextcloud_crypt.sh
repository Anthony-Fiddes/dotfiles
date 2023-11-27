#!/bin/bash
target=$XDG_CONFIG_HOME/systemd/user
mkdir -p $target
cp ./user/nextcloud_crypt.service $target
# the config is available in Bitwarden
cp ../../bin/nextcloud_crypt.sh $HOME/bin

systemctl enable --user nextcloud_crypt
systemctl --user daemon-reload
systemctl restart --user nextcloud_crypt

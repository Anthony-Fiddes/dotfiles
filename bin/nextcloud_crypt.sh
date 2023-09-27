#!/bin/bash
DRIVE=/mnt/nextcloud_crypt
sudo mkdir -p $DRIVE
sudo chown $(whoami) $DRIVE
fusermount -u $DRIVE 
rclone mount nextcloud_crypt: $DRIVE --vfs-cache-mode full 

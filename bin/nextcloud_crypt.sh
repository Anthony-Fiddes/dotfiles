#!/bin/bash
DRIVE=~/nextcloud_crypt_mount
mkdir -p $DRIVE
fusermount -u $DRIVE
rclone mount nextcloud_crypt: $DRIVE --vfs-cache-mode full

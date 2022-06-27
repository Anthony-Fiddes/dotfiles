#!/bin/bash
DRIVE=~/Documents/nextcloud_crypt
fusermount -u $DRIVE 
rclone mount nextcloud_crypt: $DRIVE --vfs-cache-mode full 

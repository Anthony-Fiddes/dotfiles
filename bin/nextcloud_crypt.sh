#!/bin/bash
DRIVE=/mnt/nextcloud_crypt
fusermount -u $DRIVE 
rclone mount nextcloud_crypt: $DRIVE --vfs-cache-mode full 

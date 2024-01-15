#!/bin/bash
DRIVE=/media/nextcloud_crypt
fusermount -u $DRIVE
rclone mount nextcloud_crypt: $DRIVE --vfs-cache-mode full

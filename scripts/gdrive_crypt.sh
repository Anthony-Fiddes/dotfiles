#!/bin/bash
DRIVE=~/gdrive_crypt
fusermount -u $DRIVE 
rclone mount gdrive-crypt: $DRIVE --vfs-cache-mode full 

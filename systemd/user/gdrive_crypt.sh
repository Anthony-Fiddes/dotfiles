#!/bin/bash
DRIVE=~/Documents/gdrive_crypt
fusermount -u $DRIVE 
rclone mount gdrive_crypt: $DRIVE --vfs-cache-mode full 

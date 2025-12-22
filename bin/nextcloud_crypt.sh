#!/bin/bash
DRIVE=~/nextcloud_crypt_mount
mkdir -p $DRIVE
if [ -x "$(command -v fusermount)" ]; then
   # this way has always worked on Linux, so I left it the way it was
   fusermount -u $DRIVE
   rclone mount nextcloud_crypt: $DRIVE --vfs-cache-mode full
elif [ -x "$(command -v umount)" ]; then
   # presumed macos
   umount $DRIVE
   rclone nfsmount nextcloud_crypt: $DRIVE --vfs-cache-mode full
else
   echo "No supported commands found. Unable to mount drive."
fi

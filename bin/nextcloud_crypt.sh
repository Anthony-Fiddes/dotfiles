#!/bin/bash
DRIVE=~/nextcloud_crypt_mount
CACHE_FLAGS=(--vfs-cache-mode full --vfs-cache-max-age 52w --vfs-cache-max-size 50G)
mkdir -p $DRIVE
if [ -x "$(command -v fusermount)" ]; then
   # this way has always worked on Linux, so I left it the way it was
   fusermount -u $DRIVE
   rclone mount nextcloud_crypt: $DRIVE "${CACHE_FLAGS[@]}"
elif [ -x "$(command -v umount)" ]; then
   # presumed macos
   umount $DRIVE
   rclone nfsmount nextcloud_crypt: $DRIVE "${CACHE_FLAGS[@]}"
else
   echo "No supported commands found. Unable to mount drive."
fi

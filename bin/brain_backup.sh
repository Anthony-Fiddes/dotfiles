#!/bin/bash
DIR=Documents
BRAIN=second_brain
GDRIVE=~/Documents/gdrive_crypt
TMP=$HOME/.$BRAIN.tar.7z.tmp

# Abort at first error.
set -e

tar c -h --directory ~/$DIR $BRAIN  | 7z a -si$BRAIN.tar $TMP
rclone moveto $TMP nextcloud_crypt:Backups/$BRAIN.tar.7z -v

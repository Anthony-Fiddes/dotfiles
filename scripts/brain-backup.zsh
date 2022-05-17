#!/bin/zsh
DIR=Documents
BRAIN=second_brain
GDRIVE=~/gdrive_crypt
tar c -h --directory ~/$DIR $BRAIN  | 7z a -sisecond_brain.tar $GDRIVE/second_brain.tar.7z

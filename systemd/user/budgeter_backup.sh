#!/bin/bash
DBNAME=budget_backup.db

# Abort at first error.
set -e

# In case there's some kind of error in my program, I'll use a temp file.
~/go/bin/budgeter backup "$HOME/.${DBNAME}.tmp"
rclone move "$HOME/.$DBNAME.tmp" gdrive_crypt:Backups/ -v

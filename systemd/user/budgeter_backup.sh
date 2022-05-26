#!/bin/bash
DBNAME=budget_backup.db

# Abort at first error.
set -e

# In case there's some kind of error in my program, I'll use a temp file.
~/go/bin/budgeter backup ~/.$DBNAME.tmp 
mv ~/.$DBNAME.tmp ~/gdrive_crypt/Finances/Budgets/$DBNAME

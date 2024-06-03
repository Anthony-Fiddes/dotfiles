#!/usr/bin/env fish
if test $(count $argv) -ne 1
    echo "Usage: $(status filename) <file>"
    echo
    echo "file: A file to be copied into the current librewolf profile directory."
    exit 1
end
set target $argv[1]
set profiles_dir (fd -H --full-path librewolf/Profiles\$ ~ | rg -v '(C|c)ache')
set separator "Default=Profiles/"
set profile_line (rg $separator $profiles_dir/../profiles.ini)
set profile_dir $profiles_dir/(echo $profile_line | string replace $separator "")
mkdir $profile_dir/chrome
echo "Copying $target to $profile_dir/chrome"
cp $target $profile_dir/chrome/

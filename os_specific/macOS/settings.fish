#!/usr/bin/env fish

# read more about this at https://flaky.build/backup-your-macos-keyboard-shortcuts-from-command-line
switch $argv[1]
    case backup
        for line in $(cat ./settings-to-backup.txt)
            set pair (string split " -> " $line)
            defaults export $pair[1] - >$pair[2]
            echo "$pair[1] -> $pair[2]"
        end
    case load
        for line in $(cat ./settings-to-backup.txt)
            set pair (string split " -> " $line)
            defaults import $pair[1] $pair[2]
            echo "$pair[2] -> $pair[1]"
        end
        and /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    case '*'
        echo "Usage: $(status filename) <backup|load>"
end

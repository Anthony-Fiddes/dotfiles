#!/usr/bin/env fish

set plist com.apple.symbolichotkeys
set backupFile ./my-macos-keyboard-shortcuts.xml

# read more about this at https://flaky.build/backup-your-macos-keyboard-shortcuts-from-command-line
switch $argv[1]
    case backup
        defaults export $plist - >$backupFile
    case load
        defaults import $plist $backupFile
        and /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    case '*'
        echo "Usage: $(status filename) <backup|load>"
end

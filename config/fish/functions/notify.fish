function notify
    printf '\x1b]99;;'$(echo $argv)'\x1b\\'
end

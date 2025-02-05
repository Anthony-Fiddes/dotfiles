# on_ubuntu checks if the current shell is using Ubuntu.
function on_ubuntu
    uname -a | grep -q -i Ubuntu
end

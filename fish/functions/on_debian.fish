# on_debian checks if the current shell is using a Debian based distro.
function on_debian
    on_ubuntu; or cat /etc/os-release | grep -q -i debian
end

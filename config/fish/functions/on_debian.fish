# on_debian checks if the current shell is using a Debian based distro.
function on_debian
    if test -e /etc/os-release
        return (on_ubuntu; or cat /etc/os-release | grep -q -i debian)
    end
    on_ubuntu
end

# on_debian checks if the current shell is using the Ubuntu distro.
function on_debian
	uname -a | grep -i Debian
end

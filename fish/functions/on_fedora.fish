# on_fedora checks if the current shell is using the Fedora distro.
function on_fedora
	test -e /etc/fedora-release
end

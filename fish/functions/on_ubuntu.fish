# on_ubuntu checks if the current shell is using the Ubuntu distro.
function on_ubuntu
	uname -a | grep -q -i Ubuntu
end

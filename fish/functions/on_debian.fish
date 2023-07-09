# on_debian checks if the current shell is using the Ubuntu distro.
function on_debian
	cat /etc/os-release | grep -q -i debian	
end

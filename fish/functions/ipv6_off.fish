# Turns off ipv6 temporarily. You can turn it back on by rebooting or calling
# ipv6_on.
# Sourced from: https://itsfoss.com/disable-ipv6-ubuntu-linux/
function ipv6_off
	sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
	sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1
	sudo sysctl -w net.ipv6.conf.lo.disable_ipv6=1
end


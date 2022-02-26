# Turns on ipv6 temporarily. You can turn it back off by calling
# ipv6_off.
# Sourced from: https://itsfoss.com/disable-ipv6-ubuntu-linux/
function ipv6_on
	sudo sysctl -w net.ipv6.conf.all.disable_ipv6=0
	sudo sysctl -w net.ipv6.conf.default.disable_ipv6=0
	sudo sysctl -w net.ipv6.conf.lo.disable_ipv6=0
end

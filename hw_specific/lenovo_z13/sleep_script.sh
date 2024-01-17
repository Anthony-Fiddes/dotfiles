#!/bin/sh

PATH=/sbin:/usr/sbin:/bin:/usr/bin

case "$1" in
	#code execution BEFORE sleeping/hibernating/suspending
	pre)
	;;
	#code execution AFTER resuming
	post)
		# per https://null.rip/2022/09/linux-on-the-thinkpad-z13-all-amd-almost-there/
		echo "Toggling wlan twice"
		rfkill toggle wlan
		rfkill toggle wlan
	;;
esac

exit 0

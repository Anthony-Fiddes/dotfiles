#!/bin/sh

PATH=/sbin:/usr/sbin:/bin:/usr/bin

case "$1" in
	#code execution BEFORE sleeping/hibernating/suspending
	pre)
		echo "Turning off wlan"
		rfkill block wlan
	;;
	#code execution AFTER resuming
	post)
		echo "Turning wlan back on"
		rfkill unblock wlan
	;;
esac

exit 0

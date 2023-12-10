#!/bin/sh

PATH=/sbin:/usr/sbin:/bin:/usr/bin

case "$1" in
	#code execution BEFORE sleeping/hibernating/suspending
	pre)
		rfkill block wlan
	;;
	#code execution AFTER resuming
	post)
		rfkill unblock wlan
	;;
esac

exit 0

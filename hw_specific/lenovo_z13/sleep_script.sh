#!/bin/sh

PATH=/sbin:/usr/sbin:/bin:/usr/bin

case "$1" in
	#code execution BEFORE sleeping/hibernating/suspending
    pre)
    ;;
	#code execution AFTER resuming
    post)
		# Fix wifi speeds
		rfkill toggle wlan
		rfkill toggle wlan
    ;;
esac

exit 0

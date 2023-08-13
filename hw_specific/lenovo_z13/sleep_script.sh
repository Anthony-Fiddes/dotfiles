#!/bin/sh

PATH=/sbin:/usr/sbin:/bin:/usr/bin

case "$1" in
	#code execution BEFORE sleeping/hibernating/suspending
	pre)
		rfkill toggle wlan
		xinput set-prop "ELAN06A0:00 04F3:3231 Touchpad" "Device Enabled" 0
	;;
	#code execution AFTER resuming
	post)
		# Fix wifi speeds
		rfkill toggle wlan
		# Toggle touchpad to make two finger right clicks more reliable
		xinput set-prop "ELAN06A0:00 04F3:3231 Touchpad" "Device Enabled" 1
	;;
esac

exit 0

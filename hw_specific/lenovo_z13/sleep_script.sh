#!/bin/sh

PATH=/sbin:/usr/sbin:/bin:/usr/bin

case "$1" in
	#code execution BEFORE sleeping/hibernating/suspending
	pre)
		xinput set-prop "ELAN06A0:00 04F3:3231 Touchpad" "Device Enabled" 0
	;;
	#code execution AFTER resuming
	post)
		# Fix wifi speeds by reloading module
		sudo modprobe -r ath11k_pci && sudo modprobe ath11k_pci
		# Toggle touchpad to make two finger right clicks more reliable
		xinput set-prop "ELAN06A0:00 04F3:3231 Touchpad" "Device Enabled" 1
	;;
esac

exit 0

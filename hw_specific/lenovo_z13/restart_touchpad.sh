#!/bin/bash
# Toggle touchpad to make two finger right clicks more reliable
xinput set-prop "ELAN06A0:00 04F3:3231 Touchpad" "Device Enabled" 0
sleep 0.1
xinput set-prop "ELAN06A0:00 04F3:3231 Touchpad" "Device Enabled" 1

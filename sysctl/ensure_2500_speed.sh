#!/bin/bash

INTERFACE="enp7s0"
TARGET_SPEED="2500"

CURRENT_SPEED=$(/usr/bin/ethtool $INTERFACE | grep "Speed :" | awk '{print $2}' | sed 's/Mb\/s//')

if [ "$CURRENT_SPEED" != "$TARGET_SPEED" ]; then
	/usr/bin/ethtool -s $INTERFACE speed 2500 duplex full autoneg off
	echo "$(date): Speed corrected from $CURRENT_SPEED to 2500 Mbps" >>/var/log/ethtool.log
	echo "$(date): Speed corrected from $CURRENT_SPEED to 2500 Mbps" >/dev/kmsg
else
	echo "LGTM"
	echo "$(date): Speed alredy to 2500 Mbps" >>/var/log/ethtool.log
	echo "$(date): Speed alredy to 2500 Mbps" >/dev/kmsg
fi

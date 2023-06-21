#!/bin/sh

# Set a custom NTP server, and set the Mac to sync the clock automatically.
NTPSERVER="fr.pool.ntp.org"

# Set clock timezone, regardless of location. Useful when MacOS changes timezone based on VPN IP address.
TIMEZONE="Europe/Paris"

#  Europe/Paris
#  Pacific/Wallis

# Set clock timezone, regardless of location. Useful when MacOS changes timezone based on VPN IP address.
systemsetup -settimezone $TIMEZONE

# set Mac to use specified server
systemsetup -setnetworktimeserver $NTPSERVER

# set Mac to sync time to server automatically
systemsetup -setusingnetworktime on

# sync time now
sntp -sS $NTPSERVER

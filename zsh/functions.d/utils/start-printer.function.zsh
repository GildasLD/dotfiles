#!/usr/bin/zsh

NC="\033[0m"
RED="\033[0;31m"

function ctrl_c() {
	clear
	printf "${RED}<C-c> pressed...${NC} stopping the demons avahi and cups\n"
	stop-printer
	exit 0
}
function start-printer() {
	trap ctrl_c INT
	sudo systemctl start avahi-daemon.service &&
		sudo systemctl start cups.service &&
		sleep 10m &&
		sudo systemctl stop avahi-daemon.service &&
		sudo systemctl stop cups.service
}
function stop-printer() {
	sudo systemctl stop avahi-daemon.service &&
		sudo systemctl stop cups.service
}

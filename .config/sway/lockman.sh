#!/bin/sh

# Times the screen off and puts it to background
swayidle \
	timeout 4 'swaymsg "output * dpms off"' \
	resume 'swaymsg "output * dpms on"' &
# Locks the screen immediately
# swaylock -c 000000
swaylock -c 000000 \
	--indicator-radius 160 \
	--indicator-thickness 20 \
	--line-uses-ring \
	--font 'NotoSans Nerd Font Mono:style=Thin,Regular 40'

kill %%

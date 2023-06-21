#!/bin/bash
if [ -z "$(xdotool search --class tilix)" ]; then
	tilix &
else
	xdotool search --class tilix windowactivate key ctrl+shift+w
fi

#!/usr/bin/zsh

screenshot() {
	grim -g "$(slurp)" "screenshot_$(date +"%Y_%m_%d__%H%M_%S").png"
}

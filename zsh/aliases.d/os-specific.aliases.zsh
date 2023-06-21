#!/usr/bin/zsh

if [[ "$(uname)" == "Darwin" ]]; then
	source ~/dotfiles/zsh/os-specific.d/macos.aliases.zsh
fi
if [[ "$(uname)" == "Linux" ]]; then
	source ~/dotfiles/zsh/os-specific.d/linux.aliases.zsh
	if [[ "$(uname -r)" == *rpi7-rpi-v8* ]]; then
		alias i="apt install"
		alias maj="sudo apt update ; sudo apt upgrade ; sudo apt dist-upgrade"
		alias si="apt search"
	fi
	if [[ "$(uname -r)" == *-rpi-ARCH* ]]; then
		source ~/dotfiles/zsh/os-specific.d/pacman.aliases.zsh
	fi
	if [[ "$(cat /proc/version)" == *archlinux* ]]; then
		source ~/dotfiles/zsh/os-specific.d/pacman.aliases.zsh
	fi
	if [[ "$(cat /proc/version)" == *debian-kernel* ]]; then
		source ~/dotfiles/zsh/os-specific.d/debian.aliases.zsh
	fi
fi

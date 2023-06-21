#!/usr/bin/zsh

function find-aliases() {
	if [ "$#" -lt 1 ]; then
		echo "You must provide an alias to search for !"
		return
	fi

	zsh -ixc : 2>&1 | grep "$1"=

}

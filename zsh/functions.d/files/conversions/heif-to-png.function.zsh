#!/bin/zsh
convert-heif-to-png() {
	find . -iname "*.heic" -exec heif-convert -q 100 {} {}.png \;
}

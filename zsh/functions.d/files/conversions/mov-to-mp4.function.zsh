#!/bin/zsh
convert-mov-to-mp4() {
	while read mov; do
		mp4=$(echo "$mov" | sed -e 's|\.mov$|.mp4|i')
		if [ "$mov" == "$mp4" ]; then
			echo "Failed to generate unique MP4 filename for file $mov"
			exit 1
		fi
		ffmpeg -i "$mov" -c:v libx264 -f mp4 "$mp4"
	done < <(find . -type f -iname '*.mov')
}

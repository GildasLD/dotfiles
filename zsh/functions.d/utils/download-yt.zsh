#!/usr/bin/env zsh

NC="\033[0m"
RED="\033[0;31m"
BOLD="\e[1m"
UNDERLINE="\e[1m"
E_BOLD="\e[22m"
E_UNDERLINE="\e[24m"

dl_yt() {
    yt-dlp -N "8" --buffer-size "64K" --no-resize-buffer \
        --merge-output-format mkv --restrict-filenames \
        --write-thumbnail --convert-thumbnails "png" --no-mtime \
        --parse-metadata "uploader:^(?P<uploader>.*?)(?:(?= - Topic)|$)" \
        --parse-metadata "%(uploader,channel,creator,artist|null)s:%(uploader)s" \
        -S "+hasaud,vcodec:h264,acodec:aac" -f "bv*[height<=8000]+ba/b" -o "%(title)s__.%(ext)s" \
        --add-metadata --parse-metadata "playlist_index:%(track_number)s" \
        --parse-metadata "playlist_index/%(n_entries)s: %(playlist_index)s/%(n_entries)s" \
        --write-subs --embed-subs --sub-format "srt/best" \
        --convert-subtitles "srt" --sub-langs "en.*,.*-orig,fr.*"  $1
    }
alias dly=dl_yt

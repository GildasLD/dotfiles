# YT-DLP

## PLaylists

yt-dlp -N "8" --buffer-size "4096" --no-resize-buffer --merge-output-format mkv --restrict-filenames --write-thumbnail --convert-thumbnails "png" --no-mtime --parse-metadata "uploader:^(?P<uploader>.*?)(?:(?= - Topic)|$)" --parse-metadata "%(uploader,channel,creator,artist|null)s:%(uploader)s" -S "+hasaud,vcodec:h264,acodec:aac" -f "bv*[height<=8000]+ba/b" --write-subs --embed-subs --sub-format "srt/best" --convert-subtitles "srt" --sub-langs "en.*,.*-orig,fr.*" -o "%(playlist_index)s_-_%(title)s_in_%(playlist)s.%(ext)s" --add-metadata --parse-metadata "playlist_index:%(track_number)s" --parse-metadata "playlist_index/%(n_entries)s: %(playlist_index)s/%(n_entries)s" "https://www.youtube.com/watch?v={YOUTUBE_CODE}"
  
yt-dlp -N "8" --buffer-size "64K" --no-resize-buffer --merge-output-format mkv --restrict-filenames --write-thumbnail --convert-thumbnails "png" --no-mtime --parse-metadata "uploader:^(?P<uploader>.*?)(?:(?= - Topic)|$)" --parse-metadata "%(uploader,channel,creator,artist|null)s:%(uploader)s" -S "+hasaud,vcodec:h264,acodec:aac" -f "bv*[height<=8000]+ba/b" -o "%(title)s__.%(ext)s" --add-metadata --parse-metadata "playlist_index:%(track_number)s" --parse-metadata "playlist_index/%(n_entries)s: %(playlist_index)s/%(n_entries)s" --write-subs --embed-subs --sub-format "srt/best" --convert-subtitles "srt" --sub-langs "en.*,.*-orig,fr.*" https://www.youtube.com/watch?v=fNk_zzaMoSs


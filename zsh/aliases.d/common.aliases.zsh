#!/usr/bin/zsh

alias -g rsync="rsync -ah --stats --info=progress2"

# depends on the SUFFIX
autoload -Uz is-at-least
if is-at-least 4.2.0; then
	# open browser on urls
	if [[ -n $BROWSER ]]; then
		_browser_fts=(htm html de org net com at cx nl se dk)
		for ft in $_browser_fts; do alias -s $ft='$BROWSER'; done
	fi

	_editor_fts=(cpp cxx cc c hh h inl asc txt TXT tex)
	for ft in $_editor_fts; do alias -s $ft='$EDITOR'; done

	if [[ -n $XIVIEWER ]]; then
		_image_fts=(jpg jpeg png gif mng tiff tif xpm)
		for ft in $_image_fts; do alias -s $ft='$XIVIEWER'; done
	fi

	_media_fts=(ape avi flv m4a mkv mov mp3 mpeg mpg ogg ogm rm wav webm)
	for ft in $_media_fts; do alias -s $ft=mplayer; done

	#read documents
	alias -s pdf=acroread
	alias -s ps=gv
	alias -s dvi=xdvi
	alias -s chm=xchm
	alias -s djvu=djview

	#list whats inside packed file
	alias -s zip="unzip -l"
	alias -s rar="unrar l"
	alias -s tar="tar tf"
	alias -s tar.gz="echo "
	alias -s ace="unace l"
fi

# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# alias find="find -print 2>/dev/null "
alias -g '....'='../../..'
alias -g '...'='../..'
alias -g BG='& exit'
alias -g C='| wc -l'
alias -g CA="2>&1 | cat -A"
alias -g G='| grep'
alias -g H='| head'
alias -g Hl=' --help |& less -r'
alias -g J='| jq'
alias -g K='| keep'
alias -g L="| less -N -M -J -s"
alias -g LL="2>&1 | less -N -M -J -s"
alias -g M="| most"
alias -g N='&>/dev/null'
alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"
alias -g P="2>&1| pygmentize -l pytb"
alias -g S='| sort'
alias -g SL='| sort | less'
alias -g T='| tail'
alias -g V='| vim -'

alias cp="cp -iva"
alias cp="rsync -ah --stats --info=progress2"
alias dl="aria2c"
alias dud='du -d 1 -h'
alias duf="/usr/bin/duf"
alias duf='du -sh *'
alias fcl="fc -l"
alias fd='find . -type d -iname'
alias ff='find "${1:-.}" -type f -iname'
alias filesmissing='find . -maxdepth 2 -xtype l'
alias filesunder='find . \( -name .git -type d \) -prune -o -type f -printf "%P\0 "'
alias format-xml="npx prettier --parser=html --write '{,!(node_modules)/**/}*.svg*'"
alias free="free -h"
alias grep='grep -i --color=auto'
alias h='history'
alias help='man'
alias hgrep="fc -El 0 | grep -i --color=auto"
alias hhead="head -30"
alias ip="ip -color -brief"
alias l="bash -c 'compgen -c | sort -u | fzf | xargs -r swaymsg -t command exec'"
alias l="ls -lAh -F -G --color=auto --time=atime --time-style=+'%d %b%Y %H:%M'"
alias l='ls -lFh' # size,show type,human readable
alias lS='ls -1FSsh'
alias la='ls -lAFh' #long list,show almost all,show type,human readable
alias lart='ls -1Fcart'
alias launch="bash -c 'compgen -c | sort -u | fzf | xargs -r swaymsg -t command exec'"
alias ldot='ls -ld "${1:-.}"*'
alias lfz="ls -lAhrt | fzf "
alias ll='ls -l'
alias ll='ls -l' #long list
alias lm="ls -lAh -F -G --color=auto --time=atime --time-style=+'%d %b%Y %H:%M'"
alias lr='ls -tRFh' #sorted by date,recursive,show type,human readable
alias lrt='ls -1Fcrt'
alias ls="ls -lAh -F -G --color=auto --time=mtime --time-style=+'%d %b%Y %H:%M'"
alias ls="ls -lAhltr -F -G --color=auto --time=atime --time-style=+'%d %b%Y %H:%M'"
alias lsArth="ls -lArth"
alias lsa="ls -lArth -F -G --color=auto --time-style=+'%d %b%Y %H:%M'"
alias lsarth="ls -larth"
alias lsf='ls -lArth -F -G --color=auto --time-style=+'\''%d %b%Y %H:%M'\'' | fzf'
alias lsn='ls -1'   #A column contains name of files and directories
alias lt='ls -ltFh' #long list,sorted by date,show type,human readable
alias mv='mv -iv'
alias ntpd="ntpd -u ntp:ntp"
alias o='xdg-open'
alias p='ps aux | grep -i --color=auto'
alias psby_cpu='ps -eo pcpu,pmem,stat,user,pid,ppid,args | sort -k 1  | cut -c -90'
alias psby_cpuusage='ps aux | sort -n -k 3'
alias psby_mem='ps -eo pmem,pcpu,stat,user,pid,ppid,args | sort -k 1  | cut -c -90'
alias psby_memusage='ps aux | sort -n -k 4'
alias psby_pid='ps aux | sort -nk 2'
alias psby_user='ps aux | sort -k 1'
alias psk='s=$1 ; _psk(){ ps aux | grep --color=auto -i "$1" | column -t | cut -d' ' -f3 | strings | xargs kill -9 }; _psk'
alias rm!='\rm -rf'
alias rm='rm -iv'
alias rsync-copy='rsync -av'
alias rsyncd='rsync --delete-during -ahz --stats --info=progress2'
alias rsync-move='rsync -av --remove-source-files'
alias rsync-synchronize='rsync -avzu --delete'
alias rsync-update='rsync -avzu '
alias rsync="rsync -ah --stats --info=progress2"
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '
alias sif='s=$1 ; _sif(){ pacman -Qlq "$1" | grep -i --color=auto -v "/$" | xargs -r du -h | sort -h }; _sif'
alias sii="pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"
alias siii="pacman -Slq | fzf --preview 'pacman -Si {}' --layout=reverse"
alias sortnr='sort -n -r'
alias sudo='sudo -E '
alias t='tail -f'
alias tree='tree -a -I .git --dirsfirst'
alias unexport='unset'
alias utc='env TZ=UTC date'
alias vi=$EDITOR; compdef vi=vim
alias vv="${EDITOR} -N -u NONE"; compdef vv=vim
alias wish="which"
alias x="xplr"
alias zshrc='${=EDITOR} ${ZDOTDIR:-$HOME}/.zshrc'
d64() { [[ $# == 1 ]] && base64 --decode <<<"$1" || base64 --decode }
e64() { [[ $# == 1 ]] && base64 -w0 <<<"$1" || base64 -w0 }
mkdirt() { mkdir "$(date +%Y-%m-%d__%s)" }
tmpd() { cd "$(mktemp -d -t "${1:-tmp}.XXXXXXXXXX")" }
tmpf() { "$(mktemp -t "${1:-tmp}.XXXXXXXXXX")" }

for cmd in chmod chown; do
    alias $cmd="$cmd --changes"
done

for cmd in rm rename; do
    alias $cmd="$cmd -v"
done

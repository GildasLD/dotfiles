#!/usr/bin/zsh

alias l="ls -lAh -F -G --color=auto --time=atime --time-style=+'%d %b%Y %H:%M'"
alias lm="ls -lAh -F -G --color=auto --time=atime --time-style=+'%d %b%Y %H:%M'"
alias ls="ls -lAhltr -F -G --color=auto --time=atime --time-style=+'%d %b%Y %H:%M'"
alias lsf='ls -lArth -F -G --color=auto --time-style=+'\''%d %b%Y %H:%M'\'' | fzf'
alias rsync-copy='rsync -avz --stats --info=progress2'
alias rsync-move='rsync -avz --stats --info=progress2 --remove-source-files'
alias rsync-synchronize='rsync -avzu --stats --info=progress2 --delete'
alias rsync-update='rsync -avzu --stats --info=progress2'
alias rsync="rsync -ah --stats --info=progress2"

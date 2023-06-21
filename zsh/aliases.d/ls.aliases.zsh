#!/usr/bin/zsh

alias l="ls -lAh -F -G --color=auto  "
alias lS='ls -1FSsh'
alias la='ls -lAFh'
alias lart='ls -1Fcart'
alias ldir='ls -l '
alias ldot='ls -ld .*'
alias lfz='ls -lAhrt | fzf '
alias lm="ls -lAh -F -G --color=auto  "
alias lr='ls -tRFh'
alias lrt='ls -1Fcrt'
alias ls="ls -lAhltr -F -G --color=auto  "
alias sl="ls"
alias lsArth='ls -lArth'
alias lsarth='ls -larth'
alias lsf='ls -lArth -F -G --color=auto '
alias lsn='ls -1'
alias lsz='du -sh * | sort -h'
alias lt='ls -ltFh'

alias dir="ls -lSrah"
# Only show dot-directories
alias lad='ls -d .*(/)'
# Only show dot-files
alias lsa='ls -a .*(.)'
# Only files with setgid/setuid/sticky flag
alias lss='ls -l *(s,S,t)'
# Only show symlinks
alias lsl='ls -l *(@)'
# Display only executables
alias lsx='ls -l *(*)'
# Display world-{readable,writable,executable} files
alias lsw='ls -ld *(R,W,X.^ND/)'
# Display the thirty biggest files
alias lsbig="ls -flh *(.OL[1,30])"
# Only show directories
alias lsdir='ls -d *(/)'
# Only show empty directories
alias lse='ls -d *(/^F)'
# Display the thirty newest files
alias lsnew="ls -rtlh *(D.om[1,30])"
# Display the thirty oldest files
alias lsold="ls -rtlh *(D.Om[1,30])"
# Display the thirty smallest files
alias lssmall="ls -Srl *(.oL[1,30])"
# Display the thirty newest directories and thirty newest .directories
alias lsnewdir="ls -rthdl *(/om[1,30]) .*(D/om[1,30])"
# Display the thirty oldest directories and thirty oldest .directories
alias lsolddir="ls -rthdl *(/Om[1,30]) .*(D/Om[1,30])"

# Remove current directory.
alias rmcdir='cd ..; rm -rf $OLDPWD || cd $OLDPWD'

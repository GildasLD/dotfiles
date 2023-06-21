[[ $- != *i* ]] && return

# alias bashconfig="mate ~/.bashrc"
# alias ohmybash="mate ~/.oh-my-bash"

PS1='\n\[\e[0;33m\] \[\e[0;35m\]\h \[\e[39m\]in \[\e[0;32m\]\w ❤️ \n\[\e[36;1m\] \[\e[0;34m\]|\[\]01:52:03|\[\e[0;32m\] \[\e[0;32m\]→\[\e[39m\] '

alias ls='ls --color=auto'

export EDITOR="vim"
export HISTCONTROL=ignoredups:erasedups 
export HISTFILESIZE=100000             
export HISTSIZE=62354
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

shopt -s globstar
shopt -s histappend 

# Loop through and source files
for f in ~/bash/aliases.d/**/*; do
	if [[ -f $f ]]; then
		source "$f"
	fi
done

for c in cp rm chmod chown rename; do
	alias $c="$c -v"
done
 
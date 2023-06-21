#!/usr/bin/zsh

NC="\033[0m"
BOLD="\033[1m"
UNDERLINE="\033[4m"
ITALICS="\033[3m"
BLACK="\033[0;30m"
WHITE="\033[0;97m"
BLUE="\033[0;34m"
CYAN="\033[0;36m"
GRAY="\033[0;90m"
GREEN="\033[0;32m"
MAGENTA="\033[0;35m"
RED="\033[0;31m"
YELLOW="\033[0;33m"
LBLUE="\033[0;94m"
LCYAN="\033[0;96m"
LGRAY="\033[0;37m"
LGREEN="\033[0;92m"
LMAGENTA="\033[0;95m"
LRED="\033[0;91m"
LYELLOW="\033[0;93m"

alias i="brew install"
alias l="ls -lAh -F -G --color=auto "
alias lm="ls -lAh -F -G --color=auto "
alias ls="ls -lAhltr -F -G --color=auto "
alias lsf='ls -lArth -F -G --color=auto '
alias maj="time brew outdated -v ; brew update && brew upgrade && brew upgrade --cask --greedy ; brew cleanup --prune=14 "
alias mù="shutdown -h now"
alias mùù="shutdown -r now"
alias myip="ipconfig getifaddr en0"
alias open='open "${1:-.}"'
alias pc="pwd -P | pbcopy"
alias rsync-move='rsync -av --info=progress2 --remove-source-files'
alias rsync-synchronize='rsync -avzu --info=progress2 --delete'
alias rsync-update='rsync -avu --info=progress2'
alias si="brew search"
alias smerge='(nohup /Applications/Sublime\ Merge.app/Contents/MacOS/sublime_merge "${1:-.}" --no-new-window 2>&1 /dev/null & disown)'
alias smerge=sm
alias st='(nohup /Applications/Sublime\ Text.app/Contents/MacOS/sublime_text -a "${1:-.}" 2>&1 /dev/null & disown)'
alias ss="lsof -iTCP -sTCP:LISTEN -P ; netstat -an | grep -E 'Proto|LISTEN'"
alias wol="wakeonlan -p 9"

function update() {

	# Homebrew
	printf "${BOLD}\n→ Checking for Homebrew packages...${NC}\n"
	brew update > /dev/null
	new_packages=$(brew outdated --quiet)
	num_packages=$(echo $new_packages | wc -w)

	if [ $num_packages -gt 0 ]; then
		printf "\n$num_packages New brew updates available :"
		for package in $new_packages; do
			echo "    * $package"
		done
		printf "\n${BOLD}→ Install brew updates ? ${NC} ${MAGENTA}(y/N)${NC}"
		brew upgrade
		brew upgrade --cask --greedy
		brew cleanup --prune= 14
		printf "\nBrew updates ${LGREEN}done !${NC}\n"
		printf "\n${BOLD}→ Clean up old versions of brew packages ? ${NC} ${MAGENTA}(y/N)${NC}"
		brew cleanup && printf "\nBrew cleanup, ${LGREEN}done !${NC}\n"
	else
		printf "\n${LYELLOW}No brew updates available${NC}"
	fi

	# Requires https://github.com/mas-cli/mas
	printf "${BOLD}\n→ Checking for Mac App Store packages...${NC}\n"
	new_packages=$(mas outdated)
	echo $new_packages
	num_packages=$(echo $new_packages | wc -w)
	if [ $num_packages -gt 0 ]; then
		printf "\n${BOLD}→ Install Mac App Store updates ? ${NC} ${MAGENTA}(y/N)${NC}"

		mas upgrade && printf "\nMac App Store updates, ${LGREEN}done !${NC}\n"

	else
		printf "\n${LYELLOW}No Mac App Store updates available${NC}"
	fi

}

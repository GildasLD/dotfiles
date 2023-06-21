#!/usr/bin/zsh

alias autoremove='sudo apt autoremove -y'
alias clean='sudo apt clean'
alias full-upgrade='sudo apt full-upgrade -y'
alias update-all='sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt clean'
alias update='sudo apt update'
alias upgrade='sudo apt upgrade -y'
alias maj='sudo apt update ; sudo apt upgrade -y'

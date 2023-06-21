#!/usr/bin/zsh

##########
# Gildas #
##########

# alias gammastep="gammastep -t 6500:2500 -l 42:2 -b 1:0.8 -r"
# alias mkdc="mkdir date +"%Y-%m-%d__%s" && cd "$_""
# alias ovpn="s=$1 ; _ovpn() { sudo openvpn --config ${1:-~/.vpn/is-fr-01.protonvpn.net.udp.ovpn } --auth-user-pass ~/.vpn/pass.txt }; _ovpn"
# alias sqlite3=" rlwrap -a -N -c -i -p -f ~/.rlwrap/sqlite3_completions sqlite3"
# alias sqlite=" rlwrap -a -N -c -i -p -f ~/.rlwrap/sqlite3_completions sqlite3"
# alias n='nnn'
# alias vsc='codium "${1:-.}"'
# alias zcc='s=$1 ; _inke(){ inkscape --export-type=png "$1" -o "${s%.*}.png" -d ${2:-300} }; _inke'

alias "?"="apropos"
alias "cd .."="cd .."
alias "cd ..."="cd ../.."
alias ......="../../../../.."
alias .....="../../../.."
alias ....="../../.."
alias ...="../.."
alias ..="cd .."
alias 1='cd -1'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'
alias RM='rm -rfv'
alias _='sudo '
alias alg="alias | grep"
alias an="awk_netstat.sh"
alias bc='bc -l'
alias c="clear"
alias cajo='/usr/bin/caja --no-desktop "${1:-.}"'
alias calc='perl -pe "print eval(\$_) . chr(10);"'
alias cd-top='cd $(git rev-parse --show-toplevel)'
alias cd...='cd ../..'
alias cd..='cd ..'
alias chmod="chmod -c -v"
alias connect-lan="sudo nmcli device disconnect wlp0s20f3 ; sudo nmcli device connect enp0s20f0u2c4i2"
alias count="_count() { find "${1:-.}" -type f | wc -l }; _count"
alias cp="cp -iv"
alias cp="rsync -ah --stats --info=progress2"
alias cpdvd="touch /media/ramdisk/1.iso && dd if=/dev/sr0 of=/media/ramdisk/1.iso status=progress"
alias ct='echo $(git rev-parse --show-toplevel)'
alias dc="docker-compose"
alias dcd="docker-compose down"
alias dcres="docker-compose down && docker-compose up -d"
alias dcu="docker-compose up -d"
alias deenv="_desenv() { source ./venv/bin/deactivate && echo $VIRTUAL_ENV }; _desenv"
alias denv="_desenv() { source ./venv/bin/deactivate && echo $VIRTUAL_ENV }; _desenv"
alias desenv="_desenv() { source ./venv/bin/deactivate && echo $VIRTUAL_ENV }; _desenv"
alias df="df -Tha --total"
alias dmesg="sudo dmesg -HxT" # -H, --human -x, --decode (facility and level (priority) numbers to human-readable), -T, --ctime (Print human-readable timestamps)
alias dmesgt="sudo dmesg -HxT --follow"
alias dms="sudo dmesg -HxT"
alias dmss="sudo dmesg -HxT --syslog"           # -S, --syslog (Force dmesg to use the syslog(2) kernel interface to read kernel messages)
alias dmsst="sudo dmesg -HxT --syslog --follow" # -S, --syslog (Force dmesg to use the syslog(2) kernel interface to read kernel messages)
alias dmst="sudo dmesg -HxT --follow"
alias du="du -h"
alias dumpTrash='find ~/.local/share/Trash -type f -exec rm {} \;'
alias e="nvim"
alias eal="nvim ~/dotfiles/zsh/aliases.d/main.aliases.zsh"
alias ebash="nvim ~/.bashrc"
alias ecom="nvim  ~/dotfiles/zsh/aliases.d/common.aliases.zsh"
alias ecomf="nvim ~/dotfiles/zsh/functions.d/common-functions.zsh"
alias ecomm="nvim ~/dotfiles/zsh/aliases.d/common.aliases.zsh"
alias ecomo="nvim ~/dotfiles/zsh/aliases.d/common.aliases.zsh"
alias ee="exit"
alias eenv="nvim $HOME/.zshenv"
alias eev="nvim $HOME/.zshenv"
alias efun="nvim ~/dotfiles/zsh/functions.d/common-functions.zsh"
alias efunc="nvim ~/dotfiles/zsh/functions.d/common-functions.zsh"
alias egit="nvim ~/.gitconfig"
alias eh="nvim ~/.zsh_history"
alias ehi="nvim ~/.zsh_history"
alias ehis="nvim ~/.zsh_history"
alias es="nvim ~/.config/sway/config"
alias esw="nvim ~/.config/sway/config"
alias etmux="nvim ~/.tmux.conf.local"
alias ev="ev() { echo \$VIRTUAL_ENV }; ev"
alias evenv="nvim $HOME/.zshenv"
alias evim="nvim ~/.vimrc"
alias exp="/usr/bin/explain.sh"
alias explain="exp=/usr/bin/explain.sh"
alias ezsh="nvim ~/.zshrc"
alias fastping='ping -c 100 -s.2'
alias firewall="iptlist"
alias free="free -mt"
alias fstab_print="sed 's/#.*//' /etc/fstab | column --table --table-columns SOURCE,TARGET,TYPE --table-hide -"
alias fz=_fz
alias gada="git add --all ; git commit -m $(date +"(%A %d %B %Y) - %Hh %Mm %Ss")"
alias gadap="git add --all ; git commit -m $(date +"(%A %d %B %Y) - %Hh %Mm %Ss") ; git push"
alias genpu="LC_ALL=C genp | sha512sum | fold -w 42 | head -n 1 |  tr '[:lower:]' '[:upper:]'"
alias gfi="git flow init -d"
alias gfl="git flow"
alias ggca='_ggca(){ google-closure-compiler -O ADVANCED --js "$1" --js_output_file ggca.min.js }; _ggca'
alias ggco='_ggco(){ google-closure-compiler --js "$1" --js_output_file ggco.min.js }; _ggco'
alias git-top='cd $(git rev-parse --show-toplevel)'
alias gitroot='cd $(git rev-parse --show-toplevel)'
alias go-top='cd $(git rev-parse --show-toplevel)'
alias gpra="git pull --rebase --autostash"
alias gr='cd $(git rev-parse --show-toplevel)'
alias grep='grep --color=tty -d skip -i '
alias gt='cd $(git rev-parse --show-toplevel)'
alias gto='cd $(git rev-parse --show-toplevel)'
alias gtop='cd $(git rev-parse --show-toplevel)'
alias h="history"
alias header='curl -I'
alias headerc='curl -I --compress'
alias hg="history | grep -i "
alias inke='s=$1 ; _ink(){ inkscape --export-type=png "$1" -o "${s%.*}.png" -d ${2:-300} -w ${3:-1024} }; _ink'
alias inr="grep -inr"
alias ip='ip -color -all -human a'
alias jb="web; dg"
alias k9="kill -9 %1"
alias k="kill -9 "
alias kusr="kill -9 -1"
alias m="mariadb --user=$USER"
alias meminfo='free -m -l -t'
alias mg="mycli -u gildas"
alias mkdir="mkdir -pv"
alias mkenv="_mkenv() { python3 -m venv venv && source ./venv/bin/activate && echo $VIRTUAL_ENV }; _mkenv"
alias mksri='s=$1 ; _mksri(){ cat "$1" | openssl dgst -sha${2:-512} -binary | openssl enc -base64 -A | strings }; _mksri'
alias mkvenv="_mkenv() { python3 -m venv venv && source ./venv/bin/activate && echo $VIRTUAL_ENV }; _mkenv"
alias mnt="mount | grep -E '^/dev' | column -t"
alias mse='_mse(){ mariadb-dump --user=$USER --routines --add-drop-database --add-drop-table --add-drop-trigger --add-locks --disable-keys --create-options --single-transaction -i "$1" >| "${1}_$(date +'%Y_%m_%d__%T').sql" }; _mse'
alias msql="mariadb -u $DB_USER -p$DB_PASS --database $DB_DEFAULT"

alias naf="npm audit fix"
alias nb='npm run build'
alias nd='npm run dev'
alias nf="_nf(){ npx prettier --write --ignore-unknown --insert-pragma  ${1:-$PWD} }; _nf"
alias ni='npm install'
alias nid='npm install --dev'
alias n='nnn'
alias nn='nnn'
alias nomnom='killall'
alias nr="grep -nri"
alias nri="grep -nri"
alias ns='npm start'
alias numfiles='find "${1:-.}" -type f | wc -l'
alias oct2dec='f(){ echo "obase=10; ibase=8; $1" | bc; unset -f f; }; f'
alias ovpn="s=$1 ; _ovpn() { sudo openvpn --config ${1:-~/.vpn/main.ovpn } --auth-user-pass ~/.vpn/pass.txt }; _ovpn"
alias p="ps aux | grep -i --color=auto"
alias tree="tree -FC --charset=ascii"
alias path='echo -e ${PATH//:/\\n}'
alias pbc="php bin/console"
alias pc="pwd -P | xclip -selection clipboard"
alias pdate="date +"%Y-%m-%d__%s""
alias phpcbf="~/.config/composer/vendor/bin/phpcbf"
alias phpcs="~/.config/composer/vendor/bin/phpcs"
alias phps='php -S localhost:8000'
alias pk="pgrep $1 | xargs kill -9"
alias pk="val=$1; _pk(){ pgrep $val | xargs kill -9 }; _pk"
alias plz='pwd'
alias pm="python3 manage.py"
alias ports="netstat -tulanp"
alias pp="pwd"
alias psCPU='ps aux --sort -%cpu'
alias psCPUusage='ps aux | sort -nk 3'
alias psMEMusage='ps aux | sort -nk 4'
alias psMem='ps aux --sort -%mem'
alias pwd="pwd -P"
alias pym="python3 manage.py"
alias raf='rm -rf '
alias reboot="systemctl reboot -i"
alias redshift='gammastep'
alias resign="!re() { git rebase --exec 'git commit --amend --no-edit -n -S' -i (; }; re"
alias rsync-move='rsync -av --info=progress2 --remove-source-files'
alias rsync-synchronize='rsync -avzu --delete'
alias rsync-update='rsync -avu'
alias rsync="rsync -ah --stats --info=progress2"
alias rzsh="source ${ZDOTDIR:-$HOME}/.zshrc"
alias s="sudo -s"
alias sail='[ -f sail ] && bash sail || bash vendor/bin/sail'
alias sen="systemctl enable"
alias senv="_senv() { source ./venv/bin/activate && echo $VIRTUAL_ENV }; _senv"
alias shfmt='shfmt --write --simplify --indent 0 --space-redirects'
alias show-top='echo $(git rev-parse --show-toplevel)'
alias showtop='echo $(git rev-parse --show-toplevel)'
alias shred="shred --iterations=7 --verbose --zero --remove"
alias sht='echo $(git rev-parse --show-toplevel)'
alias sm='(nohup smerge "${1:-.}" >/dev/null 2>&1 & disown)'
alias sqle="mariadb -u $DB_USER -p$DB_USER -D $DB_PASS --auto-vertical-output --line-numbers"
alias srel="systemctl reload"
alias ssH="ssh -p 234 gildas@mercury"
alias ssg="ss -tulnpa | grep"
alias sss="symfony server:start"
alias sst="symfony server:stop"
alias sstart="systemctl start"
alias sstop="systemctl stop"
alias sy="symfony"
alias t="tmux"
alias ta='if [ -z "$1" ]; then tmux attach -t $(tmux list-sessions -F "#S" | head -n 1) || tmux new-session -s default; else tmux attach -t "$1" || tmux new-session -s "$1"; fi'
alias tad='tmux attach -d -t'
alias taildms="sudo dmesg -HxT --follow"
alias take-screenshot='grim -g "$(slurp)" screenshot.png'
alias tarc='tar -cvzf'
alias tarx='tar -xvzf'
alias tcn="mv --force -t ~/.local/share/Trash/files"
alias tee="tee -a"
alias tkss='tmux kill-session -t'
alias tksv='tmux kill-server'
alias tl='tmux list-sessions'
alias tmuxconf='$EDITOR $ZSH_TMUX_CONFIG'
alias tn="tmux new-session -s"
alias top="htop"
alias trash="mv --force -t ~/.local/share/Trash/files"
alias trc="truncate -s 0"
alias trnc="truncate -s 0"
alias trunc="truncate -s 0"
alias truncate="truncate -s 0"
alias try="gnome-open"
alias ts="tmux new-session -s"
alias ui="uuidgen |  tr -d \- | tr a-z A-Z"
alias uid="uuidgen |  tr -d \- | tr a-z A-Z"
alias v="nvim"
alias vim="nvim"
alias vsc='codium --add "${1:-.}"'  # Add folder(s) to the last active window.
alias vsca='codium --add "${1:-.}"' # Add folder(s) to the last active window.
alias vscie="codium --install-extension"
alias vscn='codium --new-window "${1:-.}"'   # Force to open a new window
alias vscr='codium --reuse-window "${1:-.}"' # Force to open a file or folder in an already opened window
alias vsg='codium --goto "${1:-.}"'          # file:line[:character]> Open a file at the path on the specified line and character position.
alias watchdir="watch -n .5 ls -la"
alias watchsize="watch -n .5 du -h –max-depth=1"
alias watchtail="watch -n .5 tail -n 20"
alias wget="wget -c"
alias wifi_off="nmcli radio wifi off"
alias wifi_on="nmcli radio wifi on"
alias wtf="sudo dmesg -HxT"
alias wtl="journalctl -f -p 4"
alias wtw="journalctl -f -p 3"
alias yt-dlp="yt-dlp -f 'bv*[height<=2000]+ba/b' --add-metadata --merge-output-format mkv --restrict-filenames"
alias zcc='s=$1 ; _zcc(){ gcc -Wall -Wextra -pedantic -fno-common -fno-builtin "$1" -o main }; _zcc'
alias zh="fc -l -d -D"
alias zz='z -t'

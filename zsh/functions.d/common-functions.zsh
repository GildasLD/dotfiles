#!/usr/bin/zsh
date_now() {
	echo $(date +"%Y_%m_%d__%H%M_%S")
}
alias date-now=date_now
alias dnow=date_now

adminer() {
	echo "\n http://localhost:9000\n"
	nohup php -S localhost:9000 ~/adminer/index.php > /dev/null 2>&1 &
}
genp_old() {
	LC_ALL=C tr -cd '[:graph:]' < /dev/urandom | fold -w${1:-42} | head -n${2:-1}
}
genk() {

	LC_ALL=C head -c ${1:-18} /dev/urandom | base64
}
genp() {
	local prefix=$2
	local length=${1:-18}

	if [ -z "$prefix" ]; then
		LC_ALL=C head -c "$length" /dev/urandom | base64 | awk '{print "_[_" $0 "_]_"}'
	else
		length=$((length / 1)) # Noth
		LC_ALL=C head -c "$length" /dev/urandom | base64 | awk -v prefix="$prefix" '{print prefix "__[" $0 "_" $0 "]_"}'
	fi
}
mkcd() { mkdir -p -- "$1" && cd -- "$1" }
compdef mkcd=mkdir
#  cd $(mktemp -d --tmpdir=/media/ramdisk --suffix="--OOOOO")

cdtmp() { cd $(mktemp -d --tmpdir="${1:-$PWD}" --suffix="-${2:-"__DEL__"}") }
alias kk='sudo kill' # Expecting a pid
function info() { command info "$@" | vim +'exe search(".") ? "" : "quit!"' -M +MANPAGER - } # Wrap man to use Vim as MANPAGER.
# function _man() { [[ $# -eq 0 ]] && return 1 MANPAGER='cat' command man "$@" | col -b | vim +'exe search(".") ? "" : "quit!"' -M +MANPAGER - }
# alias man='_man'

pss() {
	[[ -z ${1} ]] && return                                          # bail if no argument
	pro="[${1:0:1}]${1:1}"                                           # process-name –> [p]rocess-name (makes grep better)
	ps axo pid,command | grep -i ${pro}                              # show matching processes
	pids="$(ps axo pid,command | grep -i ${pro} | awk '{print $1}')" # get pids
	complete -W "${pids}" kk                                         # make a completion list for kk
}
function _lsg() {
	find . -iname "*$1*" -print 2> /dev/null # 2> /dev/null
}
alias lsg=_lsg
alias lsr=_lsg
function find-folder() {
	find . -type f -iname '*'"$*"'*' -ls
}
alias ff=find-folder
function find-exec() {
	find . -type f -iname '*'"${1:-}"'*' \
		-exec ${2:-file} {} \;
}
alias fe=find-exec
function simple-extract() {
	emulate -L zsh
	setopt extended_glob noclobber
	if [ -f $1 ]; then
		case $1 in
		*(gz|Z)) gzip -d -c $1 ;;
		*(tar.bz2|tbz2|tbz)) tar xvjf $1 ;;
		*(tar.gz|tgz)) tar xvzf $1 ;;
		*(tar.xz|txz|tar.lzma)) tar xvJf $1 ;;
		*(xz|lzma)) xz -d -c $1 ;;
		*(zip|jar)) unzip $1 ;;
		*.7z) 7z x $1 ;;
		*.Z) uncompress $1 ;;
		*.bz2) bzip2 -d -c $1 ;;
		# *.deb) ar -x $1 ;;
		*.deb)
			mkdir -pv "./extracted--${1}/control"
			mkdir -pv "./extracted--${1}/data"
			cd "./extracted--${1}/"
			ar vx "../${1}" > /dev/null
			cd control
			tar xzvf ../control.tar.gz
			cd ../data
			tar xzvf ../data.tar.gz
			# cd ../..
			;;
		*.gz) gunzip $1 ;;
		*.lrz) lrunzip $1 ;;
		*.lzh) lha x $1 ;;
		*.rar) unrar x $1 ;;
		*.tar) tar -xvf $1 ;;
		*.tar.lrz) lrzuntar $1 ;;
		*.tar.zst) tar --zstd -xvf $1 ;;
		*.zst) zstd -d -c $1 ;;
		*) echo "'$1' cannot be extracted via >simple-extract<" >&2 ;;
		esac
	else
		echo "'$1' is not a valid file !"
	fi
}
# Make directories and files access rights sane.
function sanitize() {
	chmod -R u=rwX,g=rX,o= "$@"
}

#---------------------------------------------------#
# BEGIN Process/system related functions :          |
#---------------------------------------------------#
function my_ps() {
	ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command
}
function killps() {          # kill by process name
	local pid pname sig="-TERM" # default signal
	if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
		echo "Usage: killps [-SIGNAL] pattern"
		return
	fi
	if [ $# = 2 ]; then sig=$1; fi
	for pid in $(my_ps | awk '!/awk/ && $0~pat { print $1 }' pat=${!#}); do
		pname=$(my_ps | awk '$1~var { print $5 }' var=$pid)
		if ask "Kill process $pid <$pname> with signal $sig?"; then
			kill $sig $pid
		fi
	done
}
#-------------------------------------------------#
# END Process/system related functions :          |
#-------------------------------------------------#
alias se=simple-extract
f() {
	find . -iname "*${1:-''}*" -print 2> /dev/null
}

# Find history events by search pattern and list them by date.
function hg() {
	case $1 in
	"")
		printf '%s\n\n' 'ERROR: No search string specified. Aborting.'
		printf '%s\n%s\n\n' ${usage} ${help} && return 1
		;;
	-h)
		printf '%s\n\n' ${usage}
		print 'OPTIONS:'
		printf $format_l '-h' 'show help text'
		print '\f'
		print 'SEARCH RANGE:'
		printf $format_l "'0'" 'the whole history,'
		printf $format_l '-<n>' 'offset to the current history number; (default: -250)'
		printf $format_s '<[-]first> [<last>]' 'just searching within a give range'
		printf '\n%s\n' 'EXAMPLES:'
		printf ${format_l/(\\t)/} 'hg grml' '# Range is set to -250 by default.'
		printf $format_l 'hg zsh -250'
		printf $format_l 'hg foo 1 99'
		;;
	\?)
		printf '%s\n%s\n\n' ${usage} ${help} && return 1
		;;
	*)
		fc -r -li -m "*${first_char}${remain}*" $first $last
		;;
	esac
}
cl() {
	DIR="$*"
	if [ $# -lt 1 ]; then
		DIR=$HOME
	fi
	cd "${DIR}" &&
		ls -lAh -F -G --color=auto --time=mtime --time-style=+'%d %b%Y %H:%M'
}

# Provides useful information on globbing
function H-glob() {
	echo -e "
/      directories
.      plain files
@      symbolic links
=      sockets
p      named pipes (FIFOs)
*      executable plain files (0100)
%      device files (character or block special)
%b     block special files
%c     character special files
r      owner-readable files (0400)
w      owner-writable files (0200)
x      owner-executable files (0100)
A      group-readable files (0040)
I      group-writable files (0020)
E      group-executable files (0010)
R      world-readable files (0004)
W      world-writable files (0002)
X      world-executable files (0001)
s      setuid files (04000)
S      setgid files (02000)
t      files with the sticky bit (01000)

print *(m-1)          # Files modified up to a day ago
print *(a1)           # Files accessed a day ago
print *(@)            # Just symlinks
print *(Lk+50)        # Files bigger than 50 kilobytes
print *(Lk-50)        # Files smaller than 50 kilobytes
print **/*.c          # All *.c files recursively starting in \$PWD
print **/*.c~file.c   # Same as above, but excluding 'file.c'
print (foo|bar).*     # Files starting with 'foo' or 'bar'
print *~*.*           # All Files that do not contain a dot
chmod 644 *(.^x)      # make all plain non-executable files publically readable
print -l *(.c|.h)     # Lists *.c and *.h
print **/*(g:users:)  # Recursively match all files that are owned by group 'users'
echo /proc/*/cwd(:h:t:s/self//) # Analogous to >ps ax | awk '{print $1}'<"
}
alias help-zsh=H-glob
alias hzsh=H-glob
function vimjump() {
	"$EDITOR" -q <(printf '%s: \n' "$@")
}
alias less='less -imJMW'
alias ducks='du -cks * | sort -rn | head -15'

clint() {
	clang-format -i --verbose --style="{BasedOnStyle: LLVM, UseTab: Never, IndentWidth: 2, TabWidth: 2 }" "$@"
	# find . \( -iname "*.h" -o -iname "*.cpp" -o -iname "*.c" \) -exec clang-format -i --verbose --style=GNU {} +
}

tea-timer() {
	s=${1:-2}
	_tt() {
		termdown $s && notify-send 'Tea ! Tea is done.'
	}
	_tt
}
update-timezone() {
	timedatectl set-timezone "$(curl --no-progress-meter --fail https://ipapi.co/timezone)"
}
get-timezone() {
	printf '%s' "$(curl --no-progress-meter --fail https://ipapi.co/timezone)"
}

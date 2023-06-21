#!/usr/bin/zsh

alias clr='clear; echo Currently logged in on $TTY, as $USERNAME in directory $PWD.'
alias path='print -l $path'

function ip() {
	if [ -t 1 ]; then
		command ip -color -all -human "$@"
	else
		command ip -all -human "$@"
	fi
}

function dir-ls() {
	print -l *(/)
}

function psgrep() {
	ps aux | grep "${1:-.}" | grep -v grep
}

# Kills any process that matches a regexp
function killit() {
	ps aux | grep -v "grep" | grep "$@" | awk '{print $2}' | xargs sudo kill
}

# Printing process according to the port number
function port-process() {
	netstat -tulpna | grep "${1}" | awk '{print $7}' | cut -d/ -f1
}

# Delete 0 byte file
function delete-0-bytes-files() {
	find "${1:-.}" -type f -size 0 -exec rm -rf {} \;
}

# gather external ip address
function pubip() {
	possibleResolvers=(
		'https://ifcfg.me/json'
		'https://myexternalip.com/json'
		'https://api.ipify.org?format=json'
		'https://ipinfo.io/json'
		'https://ifcfg.me/json'
	)
	while true; do
		resolver=${possibleResolvers[$((RANDOM % ${#possibleResolvers[@]}))]}
		json=$(curl --silent --insecure $resolver 2> /dev/null)
		if [ -n "$json" ]; then
			ip=$(echo "$json" | awk -F'"' '/"ip":/ {print $4}')
			if [ -n "$ip" ]; then
				echo $json | jq
				break
			fi
		fi
		# echo "Retrying..."
		sleep 0.01
	done
}

function puboip() {
	possibleResolvers=('https://ifcfg.me/json' 'https://myexternalip.com/json' 'https://api.ipify.org?format=json' 'https://ipinfo.io/json' 'https://ifcfg.me/json')
	while true; do
		resolver=${possibleResolvers[$((RANDOM % ${#possibleResolvers[@]}))]}
		json=$(curl --silent --insecure $resolver 2> /dev/null)
		if [ -n "$json" ]; then
			ip=$(echo "$json" | awk -F'"' '/"ip":/ {print $4}')
			wholeFetch="$json"
			if [ -n "$ip" ]; then
				echo $ip
				break
			fi
		fi
		# echo "Retrying..."
		sleep 0.1
	done
}

function update_dynu_ip() {

	public_ip=$(puboip)

	if [ -n "$public_ip" ]; then
		printf "%s\n" "$public_ip"
		curl --request GET --url "https://api.dynu.com/nic/update?hostname=$DYNU_HOSTNAME&myip=$public_ip&password=$DYNU_PWD"
	else
		echo "Impossible de récupérer l'IP publique."
	fi
}

# determine local IP address(es)
function getIP() {
	ifconfig | awk '/inet /{print $2}' | command grep -v 127.0.0.1
}

# Clear zombie processes
function clear-zombies() {
	ps -eal | awk '{ if ($2 == "Z") {print $4}}' | kill -9
}
function lsofpid() {
	lsof -a -p "${1:-'1'}"
}

function lsofnet() {
	lsof -i -n -P
}

function ssemul() {
	lsof -i -n -P
	netstat -an | grep -E 'Proto|LISTEN'
}

function genRandMAC() {
	# (stdbuf -o0 tr -dc A-F0-9 < /dev/urandom | head -c 10 | sed -r 's/(..)/\1:/g;s/:$//;s/^/02:/')  2>/dev/null
	# (tr -dc A-F0-9 < /dev/urandom | head -c 10 | sed -r 's/(..)/\1:/g;s/:$//;s/^/02:/' ) 2>/dev/null
	# hexdump -n6 -e '6/1 ":%02x"' /dev/urandom | awk ' { sub(/^:../, "02"); print } '
	(cat /dev/urandom | tr -dc 'A-F0-9' | head -c 10 | sed -r 's/(..)/\1:/g;s/:$//;s/^/02:/') 2> /dev/null
}

function sysstats() {

	# Définition des couleurs
	NC="\033[0m"
	RED="\033[0;31m"
	MAGENTA="\033[0;35m"
	BOLD="\033[1m"
	export LC_TIME=fr_FR.UTF-8

	# Affiche le nombre d'utilisateurs connectés
	echo -e "${MAGENTA}Utilisateurs :${NC} $(who | wc -l)"

	# Affiche la charge moyenne du système
	echo -e "${MAGENTA}Charge${NC} :$(uptime | awk -F'load average:' '{print $2}')"
	# Informations sur la mémoire
	memoire_disponible=$(/usr/bin/free -m | awk 'NR==2{print $7}')
	memoire_utilisee=$(/usr/bin/free -m | awk 'NR==2{print $3}')
	memoire_total=$(/usr/bin/free -m | awk 'NR==2{print $2}')

	if [[ $memoire_total -ne 0 ]]; then
		pourcentage_memoire_utilisee=$((memoire_utilisee * 100 / memoire_total))
	else
		pourcentage_memoire_utilisee=0
	fi

	# Affiche la mémoire utilisée avec des couleurs
	printf "${MAGENTA}Mémoire utilisée${NC} : %'d Mo sur %'d Mo [${MAGENTA}%'d %%${NC}]\n" "$memoire_utilisee" "$memoire_total" "$pourcentage_memoire_utilisee"

	# Espace disque disponible pour la racine (/) en kilo-octets
	espace_disponible=$(/usr/bin/df --output=avail -k / | tail -n 1 | tr -d ' ')
	espace_disque_utilise=$(/usr/bin/df --output=used -k / | tail -n 1 | tr -d ' ')
	espace_disque_total=$((espace_disponible + espace_disque_utilise))
	espace_disponible_en_mo=$(echo "$espace_disponible" | awk '{print $1/1024}')
	espace_disponible_en_go=$(echo "$espace_disponible" | awk '{print $1/1024/1024}')
	espace_disque_utilise_en_mo=$(echo "$espace_disque_utilise" | awk '{print $1/1024}')
	espace_disque_utilise_en_go=$(echo "$espace_disque_utilise" | awk '{print $1/1024/1024}')

	# Pourcentage d'utilisation du disque
	pourcentage_utilisation_disque=$(/usr/bin/df --output=pcent -k / | tail -n 1 | tr -d ' %')
	pourcentage_utilisation_disque_2=$((espace_disque_utilise * 100 / espace_disque_total))

	# Affiche l'espace disque disponible avec des couleurs
	echo -e "${MAGENTA}Disque utilisé${NC} : $(printf "%.2f" "$espace_disque_utilise_en_go") G (soit $(printf "%'d" "$espace_disponible_en_mo") Mo) [${MAGENTA}${pourcentage_utilisation_disque} %${NC}]"

}

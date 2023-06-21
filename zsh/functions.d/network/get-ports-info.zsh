#!/bin/env zsh

get-infos-from-port() {

	# Vérifie si des ports sont fournis en argument
	if [ "$#" -eq 0 ]; then
		echo "Usage: $0 <port(s)>"
		echo "Exemples :"
		echo "$0 23"
		echo "$0 23,5955,333"
		echo "$0 20-30"
		exit 1
	fi

	# Convertit les ports séparés par des virgules en un tableau
	IFS=',' read -A ports <<< "$1"

	# Fonction pour obtenir des informations basées sur un port
	get_info() {
		local port=$1

		# Vérifie si le port est non vide
		if [[ -z $port ]]; then
			echo "Port invalide ou vide"
			return
		fi

		echo "Port: $port"

		# Utilise lsof pour obtenir les informations de processus pour le port
		lsof_output=$(lsof -i :$port)
		if [[ -z $lsof_output ]]; then
			echo "Aucune connexion active sur le port $port"
			return
		else
			echo "Sortie lsof :"
			echo "$lsof_output"
		fi

		# Extrait l'ID de processus de lsof
		pid=$(echo "$lsof_output" | awk 'NR==2 {print $2}')
		if [[ -z $pid ]]; then
			echo "Impossible de récupérer le PID"
			return
		fi

		# Utilise netstat pour obtenir les détails de la connexion (IP source, IP destination, etc.)
		netstat_output=$(netstat -tnp 2> /dev/null | grep ":$port " | grep " $pid/")
		if [[ -z $netstat_output ]]; then
			echo "Pas de détails de connexion réseau disponibles pour le PID $pid sur le port $port"
		else
			src_ip=$(echo "$netstat_output" | awk '{print $4}' | cut -d':' -f1)
			dst_ip=$(echo "$netstat_output" | awk '{print $5}' | cut -d':' -f1)
			echo "IP Source: $src_ip"
			echo "IP Destination: $dst_ip"
		fi

		# Récupère les adresses MAC
		src_mac=$(arp -n | grep "$src_ip" | awk '{print $3}')
		dst_mac=$(arp -n | grep "$dst_ip" | awk '{print $3}')
		echo "MAC Source: ${src_mac:-'Non disponible'}"
		echo "MAC Destination: ${dst_mac:-'Non disponible'}"

		# Durée de la connexion si disponible
		start_time=$(ps -p $pid -o lstart=)
		if [[ -z $start_time ]]; then
			echo "Impossible de récupérer l'heure de début pour le PID $pid"
		else
			echo "Heure de début de la connexion : $start_time"

			# Calcule la durée
			duration=$(ps -p $pid -o etimes=)
			echo "Durée (secondes) : ${duration:-'N/A'}"
		fi

		echo "-----------------------"
	}

	# Parcourt chaque port ou plage de ports spécifiée
	for port_item in $ports; do
		if [[ $port_item =~ "-" ]]; then
			# Gère une plage de ports
			start_port=${port_item%-*}
			end_port=${port_item#*-}
			for port in $(seq $start_port $end_port); do
				get_info $port
			done
		else
			# Port unique
			get_info $port_item
		fi
	done
}

# Exemple d'appel de la fonction avec un port
# get-infos-from-port 3702

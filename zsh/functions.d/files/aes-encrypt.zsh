#!/bin/env bash

# Définir les couleurs
BLUE='\033[0;34m'
BOLD="\033[1m"
GREEN='\033[0;32m'
MAGENTA="\033[0;35m"
NC="\033[0m"
RED='\033[0;31m'
RED="\033[0;31m"
RESET='\033[0m'
YELLOW='\033[0;33m'

print_color() {
	local color="$1"
	shift
	echo -e "${color}$*${RESET}"
}

# Lire le mot de passe
read_password() {
	local input_key
	print_color "$BLUE" "Entrez le mot de passe :" >&2
	read -s input_key
	echo "$input_key"
}

# Lire une clé depuis un fichier
get_key_from_file() {
	local key_file="$1"
	local key_content
	if [[ -z $key_file ]]; then
		key_file="$HOME/.clef"
	fi

	if [[ -f $key_file && -r $key_file ]]; then
		key_content=$(cat "$key_file")
		echo "$key_content"
	else
		print_color "$RED" "Erreur : Le fichier de clé '$key_file' n'existe pas ou ne peut pas être lu." >&2
		return 1
	fi
}

# Chiffrer un fichier
encrypt_file() {
	local USE_PASSWORD=false
	local key_source
	local fichier_a_chiffrer
	local output_file
	local password

	while getopts "pf:k:" opt; do
		case $opt in
		p)
			USE_PASSWORD=true
			;;
		f)
			fichier_a_chiffrer="$OPTARG"
			;;
		k)
			key_source="$OPTARG"
			;;
		\?)
			print_color "$RED" "Option invalide : -$OPTARG" >&2
			return 1
			;;
		esac
	done

	shift $((OPTIND - 1))

	if [[ -z $fichier_a_chiffrer ]]; then
		print_color "$RED" "Erreur : Aucun fichier à chiffrer spécifié. Utilisation : encrypt_file -f <fichier> [-k <clé> | -p]" >&2
		return 1
	fi

	if [[ ! -f $fichier_a_chiffrer ]]; then
		print_color "$RED" "Erreur : Le fichier à chiffrer '$fichier_a_chiffrer' n'existe pas." >&2
		return 1
	fi

	output_file="${1:-$fichier_a_chiffrer.enc}"

	if $USE_PASSWORD; then
		password=$(read_password)
	else
		if [[ -n $key_source ]]; then
			password=$(get_key_from_file "$key_source")
		else
			password=$(get_key_from_file)
		fi
	fi

	if [[ -z $password ]]; then
		print_color "$RED" "Erreur : Aucun mot de passe ou clé valide fourni !" >&2
		return 1
	fi
	# 131072
	sudo nice -n -15 openssl enc -e -aes-256-cbc -base64 -A -salt -pbkdf2 -iter 100000 -bufsize 524288 -pass pass:"$password" -in "$fichier_a_chiffrer" -out "$output_file"
	if [[ $? -eq 0 ]]; then
		print_color "$GREEN" "Le fichier a été chiffré avec succès et enregistré dans '$output_file'."
		sudo chown --changes $USER:$USER "$output_file"
	else
		print_color "$RED" "Erreur lors du chiffrement du fichier."
		return 1
	fi
}

# Déchiffrer un fichier
decrypt_file() {
	local USE_PASSWORD=false
	local key_source
	local fichier_a_dechiffrer
	local output_file
	local password

	while getopts "pf:k:" opt; do
		case $opt in
		p)
			USE_PASSWORD=true
			;;
		f)
			fichier_a_dechiffrer="$OPTARG"
			;;
		k)
			key_source="$OPTARG"
			;;
		\?)
			print_color "$RED" "Option invalide : -$OPTARG" >&2
			return 1
			;;
		esac
	done
	shift $((OPTIND - 1))

	if [[ -z $fichier_a_dechiffrer ]]; then
		print_color "$RED" "Erreur : Aucun fichier à déchiffrer spécifié. Utilisation : decrypt_file -f <fichier> [-k <clé> | -p]" >&2
		return 1
	fi

	if [[ ! -f $fichier_a_dechiffrer ]]; then
		print_color "$RED" "Erreur : Le fichier à déchiffrer '$fichier_a_dechiffrer' n'existe pas." >&2
		return 1
	fi

	output_file="${1:-${fichier_a_dechiffrer%.enc}}"

	if [[ -e $output_file ]]; then
		print_color "$YELLOW" "Attention :\nLe fichier '$output_file' existe déjà. Voulez-vous le remplacer ? (o/n)"
		read -r choix
		if [[ $choix != [oO] ]]; then
			print_color "$BLUE" "Déchiffrement annulé."
			return 1
		fi
	fi

	if $USE_PASSWORD; then
		password=$(read_password)
	else
		if [[ -n $key_source ]]; then
			password=$(get_key_from_file "$key_source")
		else
			password=$(get_key_from_file)
		fi
	fi

	if [[ -z $password ]]; then
		print_color "$RED" "Erreur :\nAucun mot de passe ou clé valide fourni !" >&2
		return 1
	fi

	sudo nice -n -15 openssl enc -d -aes-256-cbc -base64 -A -salt -pbkdf2 -iter 100000 -bufsize 524288 -pass pass:"$password" -in "$fichier_a_dechiffrer" -out "$output_file"

	if [[ $? -eq 0 ]]; then
		print_color "$GREEN" "Le fichier a été déchiffré avec succès et enregistré dans '$output_file'."
		sudo chown --changes $USER:$USER "$output_file"
	else
		print_color "$RED" "Erreur lors du déchiffrement du fichier."
		rm -f -v "$output_file"
		return 1
	fi
}

# Alias

alias dec-file=decrypt_file
alias decfile=decrypt_file
alias decf=decrypt_file

alias enc-file=encrypt_file
alias encfile=encrypt_file
alias encf=encrypt_file

# LC_ALL=C head -c 42 /dev/urandom | base64 | tee $PWD/key.key
# LC_ALL=C dd if=/dev/urandom bs=1024 count=1 | base64 --wrap=0 | tee >| $PWD/key.key

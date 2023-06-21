#!/usr/bin/zsh

function restrict-filenames() {
	# Variables par défaut
	folder="."
	max_depth=0
	process_dirs=false

	# Parcourt les arguments pour identifier leurs types
	for arg in "$@"; do
		case "$arg" in
		-d | --dir)
			process_dirs=true
			;;
		[0-9]*)
			max_depth="$arg"
			;;
		*)
			folder="$arg"
			;;
		esac
	done

	# Vérifie si le dossier est défini
	if [[ -z $folder ]]; then
		echo "Usage : restrict-filenames <dossier> [profondeur_maximale] [-d|--dir]"
		echo "  <dossier>            : Le dossier de départ (obligatoire)"
		echo "  [profondeur_maximale]: La profondeur maximale pour la recherche (optionnel)"
		echo "  -d, --dir            : Traiter uniquement les dossiers (optionnel)"
		return 1 # Retourne une erreur
	fi

	# Utilise une commande 'find' appropriée selon l'option et la profondeur maximale
	find "$folder" $([[ $max_depth -gt 0 ]] && echo "-maxdepth $max_depth") \
		$($process_dirs && echo "-type d" || echo "-type f") \
		! -path '*/.git/*' ! -path '*/node_modules/*' ! -path '*/venv/*' | while IFS= read -r filepath; do

		# Récupère le nom du fichier et le répertoire
		filename=$(basename -- "$filepath")
		directory=$(dirname -- "$filepath")

		# Remplace les espaces par des underscores
		newfilename=$(echo "$filename" | LANG=C.UTF-8 sed 's/ /_/g')

		# Vérifie si le nom du fichier a été modifié
		[[ $filename != "$newfilename" ]] && {
			echo "De : $filepath"
			echo "À : $directory/$newfilename"

			# Renomme le fichier
			mv -n "$filepath" "$directory/$newfilename"
			echo "Fichier renommé."
			echo "--------------------------------------------"
		}
	done
}

alias normalize=restrict-filenames
alias nle=restrict-filenames
alias nlz=restrict-filenames

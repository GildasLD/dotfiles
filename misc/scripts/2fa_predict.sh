#!/bin/bash

# Définit des couleurs pour l'affichage
BLANC='\033[0;37m'
BLEU='\033[0;34m'
CYAN='\033[0;36m'
JAUNE='\033[0;33m'
MAGENTA='\033[1;95m'
ROUGE='\033[0;31m'
VERT='\033[0;32m'
RESET='\033[0m'

# Vérifie si au moins une clef a été fournie
if [ $# -eq 0 ]; then
	echo -e "${ROUGE}Usage: $0 clef1 [clef2 ... clefN]${RESET}"
	exit 1
fi

# Formater un jeton en groupes de 3 caractères
format_jeton() {
	local JETON="$1"
	echo "${JETON:0:3} ${JETON:3:3}"
}

for CLE_SECRETE in "$@"; do
	RESULTATS=()

	RESULTATS+=("${BLEU}Clef : ${MAGENTA}$CLE_SECRETE${RESET}")
	RESULTATS+=("${JAUNE}Date       | Jeton${RESET}")
	RESULTATS+=("${CYAN}--------------------------------${RESET}")

	TEMPS_UNIX=$(date +%s)
	DATE_IMMEDIATE=$(date -u -d "@$TEMPS_UNIX" +"%Y-%m-%d %H:%M:%S UTC")
	HEURE_IMMEDIATE=$(date -u -d "@$TEMPS_UNIX" +"%H:%M:%S")

	JETON=$(oathtool --totp -b --now "$DATE_IMMEDIATE" "$CLE_SECRETE")
	JETON_FORMAT=$(format_jeton "$JETON")

	RESULTATS+=("${BLANC}$HEURE_IMMEDIATE${RESET} ${ROUGE}*${RESET} | ${VERT}$JETON_FORMAT${RESET} | ${VERT}$JETON${RESET} ${ROUGE}*${RESET}")

	# Génère 5 jetons
	for i in {1..4}; do
		TEMPS_UNIX_ALIGNE=$((TEMPS_UNIX / 30 * 30 + i * 30))

		# Convertit en format lisible
		DATE_ARRONDIE=$(date -u -d "@$TEMPS_UNIX_ALIGNE" +"%Y-%m-%d %H:%M:%S UTC")
		HEURE_ARRONDIE=$(date -u -d "@$TEMPS_UNIX_ALIGNE" +"%H:%M:%S")

		# Calcule le jeton pour la date courante
		JETON=$(oathtool --totp -b --now "$DATE_ARRONDIE" "$CLE_SECRETE")
		JETON_FORMAT=$(format_jeton "$JETON")

		# Ajoute la date et le jeton au tableau
		RESULTATS+=("${BLANC}$HEURE_ARRONDIE${RESET}   | ${VERT}$JETON_FORMAT${RESET} | ${VERT}$JETON${RESET}")
	done

	# Affiche les résultats
	for LIGNE in "${RESULTATS[@]}"; do
		echo -e "$LIGNE"
	done

	# Sépare les résultats pour chaque clef
	echo -e "${CYAN}--------------------------------${RESET}"
done

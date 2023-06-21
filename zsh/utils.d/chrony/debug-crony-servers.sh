#!/bin/bash

# Script pour analyser les serveurs NTP configurés dans Chrony
# et sélectionner les meilleurs serveurs à conserver.

# Nombre maximum de serveurs à afficher
MAX_SERVERS=9

echo "Analyse des serveurs NTP configurés avec chronyc..."
echo "==================================================="

# Récupère la liste des serveurs avec des statistiques détaillées
chronyc sources -v | awk '
/^\^/ {
    server=$2;         # Adresse du serveur
    stratum=$3;        # Stratum du serveur
    reach=$4;          # Indicateur de reachability
    delay=$5;          # Temps de transit (latence)
    offset=$6;         # Décalage (précision par rapport au serveur)
    jitter=$7;         # Variation des délais

    if (stratum > 0 && reach > 0) {
        # Ajoute les informations valides à une liste
        printf "%s %d %.3f %.3f %.3f\n", server, stratum, delay, offset, jitter
    }
}' | sort -k2,2n -k3,3n -k4,4n -k5,5n | head -n "$MAX_SERVERS" >ntp_best_servers.txt

# Affiche les meilleurs serveurs
echo "Serveurs NTP les plus fiables :"
echo "--------------------------------"
cat ntp_best_servers.txt | awk '{ printf "Serveur: %-30s | Stratum: %d | Latence: %.3f ms | Décalage: %.3f ms | Jitter: %.3f ms\n", $1, $2, $3, $4, $5 }'

echo
echo "Les meilleurs serveurs ont été enregistrés dans le fichier : ntp_best_servers.txt"

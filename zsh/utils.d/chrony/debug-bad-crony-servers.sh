#!/bin/bash

# Script pour analyser les serveurs NTP configurés avec chronyc
# et identifier les serveurs les moins fiables.

# Nombre maximum de serveurs "mauvais" à afficher
MAX_BAD_SERVERS=15

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
}' | sort -k2,2nr -k3,3nr -k4,4nr -k5,5nr | head -n "$MAX_BAD_SERVERS" >ntp_worst_servers.txt

# Affiche les mauvais serveurs
echo "Serveurs NTP les moins fiables :"
echo "---------------------------------"
cat ntp_worst_servers.txt | awk '{ printf "Serveur: %-30s | Stratum: %d | Latence: %.3f ms | Décalage: %.3f ms | Jitter: %.3f ms\n", $1, $2, $3, $4, $5 }'

echo
echo "Les pires serveurs ont été enregistrés dans le fichier : ntp_worst_servers.txt"

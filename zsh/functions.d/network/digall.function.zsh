#!/bin/env zsh

digall() {
    # Force l'encodage UTF-8 pour le script
    export LANG=C.UTF-8
    export LC_ALL=C.UTF-8
    # Définition des couleurs pour l'affichage des résultats
    DIGALL_COLOR_RESTORE='\033[0m'
    DIGALL_COLOR_RED='\033[0;31m'
    DIGALL_COLOR_LIGHT_GREEN='\033[1;32m'
    DIGALL_COLOR_LIGHT_BLUE='\033[1;34m'
    DIGALL_COLOR_LIGHT_CYAN='\033[1;36m'

    # Vérifie si un argument a été passé (domaine ou adresse IP)
    if [ -z "$1" ]; then
        printf "${DIGALL_COLOR_RED}Erreur : Passez un domaine ou une adresse IP comme premier argument${DIGALL_COLOR_RESTORE}\n"
        return
    fi

    # Expressions régulières pour identifier les adresses IP (IPv4 et IPv6)
    IPV4_REGEX="^([0-9]{1,3}\.){3}[0-9]{1,3}$"
    IPV6_REGEX="^([a-fA-F0-9:]+:+)+[a-fA-F0-9]+$"

    # Liste complète des types d'enregistrements DNS à interroger
    types=("A" "AAAA" "CNAME" "MX" "NS" "SOA" "TXT" "SPF" "SRV" "PTR" "CAA" "NAPTR" "CERT" "DNSKEY" "DS" "LOC" "TLSA")

    # Vérifie si l'argument est une adresse IP
    if [[ $1 =~ $IPV4_REGEX || $1 =~ $IPV6_REGEX ]]; then
        printf "${DIGALL_COLOR_LIGHT_GREEN}Adresse IP détectée, recherche des enregistrements PTR...\n${DIGALL_COLOR_RESTORE}"
        dig -x "$1" +noall +answer
    else
        printf "${DIGALL_COLOR_LIGHT_BLUE}\nRequêtes : (dig +noall +answer '$1' '<type>')...${DIGALL_COLOR_LIGHT_CYAN}\n\n"

        # Boucle sur les types d'enregistrements DNS pour un domaine
        for t in "${types[@]}"; do
            printf "${DIGALL_COLOR_LIGHT_GREEN}Requête pour les enregistrements $t...\n${DIGALL_COLOR_RESTORE}${DIGALL_COLOR_LIGHT_CYAN}"
            dig +noall +answer "$1" "${t}"
            printf "${DIGALL_COLOR_RESTORE}"
        done

        # Recherche des CNAME associés et résolution récursive
        printf "${DIGALL_COLOR_LIGHT_BLUE}\nRecherche des CNAME associés...\n${DIGALL_COLOR_RESTORE}"
        CNAMES=$(dig +short "$1" CNAME)
        if [ -n "$CNAMES" ]; then
            printf "${DIGALL_COLOR_LIGHT_GREEN}CNAME trouvés : $CNAMES\n${DIGALL_COLOR_RESTORE}"
            for cname in $CNAMES; do
                printf "${DIGALL_COLOR_LIGHT_GREEN}Résolution des enregistrements pour $cname...\n${DIGALL_COLOR_RESTORE}"
                for t in "${types[@]}"; do
                    printf "${DIGALL_COLOR_LIGHT_CYAN}"
                    dig +noall +answer "$cname" "${t}"
                    printf "${DIGALL_COLOR_RESTORE}"
                done
            done
        else
            printf "${DIGALL_COLOR_RED}Aucun CNAME trouvé pour $1.\n${DIGALL_COLOR_RESTORE}"
        fi

        # Recherche des enregistrements MX et résolution des domaines MX
        printf "${DIGALL_COLOR_LIGHT_BLUE}\nRecherche des enregistrements MX...\n${DIGALL_COLOR_RESTORE}"
        MX_DOMAINS=$(dig +short "$1" MX | awk '{print $2}' | iconv -f UTF-8 -t UTF-8//IGNORE)
        if [ -n "$MX_DOMAINS" ]; then
            printf "${DIGALL_COLOR_LIGHT_GREEN}Enregistrements MX trouvés :\n$MX_DOMAINS\n${DIGALL_COLOR_RESTORE}"
            for mx in $MX_DOMAINS; do
                printf "${DIGALL_COLOR_LIGHT_GREEN}Résolution des enregistrements pour le domaine MX : $mx...\n${DIGALL_COLOR_RESTORE}${DIGALL_COLOR_LIGHT_CYAN}"
                for t in "${types[@]}"; do
                    # Nettoie la chaîne pour supprimer les caractères non imprimables
                    type_cleard=$(echo "$t" | tr -cd '[:print:]')
                    # Remplace la chaîne '\010' par un espace
                    dig +noall +answer "$mx" "$type_cleard" | sed 's/\\010//g'
                done
                printf "${DIGALL_COLOR_RESTORE}"
            done
        else
            printf "${DIGALL_COLOR_RED}Aucun enregistrement MX trouvé pour $1.\n${DIGALL_COLOR_RESTORE}"
        fi
    fi
}

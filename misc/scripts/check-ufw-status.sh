#!/bin/bash

# Définir le chemin du fichier de log
log_file="/var/log/ufw-check.log"

# Vérifie si le fichier de log existe, sinon le crée avec les bonnes permissions
if [[ ! -f $log_file ]]; then
	touch "$log_file"
	chmod 644 "$log_file" # Définit les permissions pour lecture/écriture par le propriétaire et lecture par les autres
fi

# Vérifie si UFW est actif
ufw_status=$(ufw status | grep -i "inactive")

# Si UFW est inactif, active-le et consigne dans le log
if [[ -n $ufw_status ]]; then
	echo "$(date '+%Y-%m-%d %H:%M:%S'): UFW est inactif, activation en cours..." >> "$log_file"
	ufw --force enable
	ufw logging on
	echo "$(date '+%Y-%m-%d %H:%M:%S'): UFW a été activé." >> "$log_file"
fi

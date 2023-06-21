#!/usr/bin/env bash

# Définit la date actuelle au format année-mois
DATE=$(date +%Y-%m)

# Met à jour GeoIP
sudo geoipupdate -v

# Change le répertoire vers /usr/share/GeoIP, termine le script en cas d'échec
cd /usr/share/GeoIP || exit 1

# Définit un tableau avec les types de bases de données à télécharger
DB_TYPES=("city-lite" "asn-lite")

# Parcourt chaque type de base de données
for TYPE in "${DB_TYPES[@]}"; do
	# Définit le nom du fichier distant et local
	FILE_NAME="dbip-${TYPE}-${DATE}.mmdb.gz"
	LOCAL_FILE="${FILE_NAME%.gz}"

	# Télécharge la base de données uniquement si une nouvelle version est disponible
	if [ -f "$FILE_NAME" ]; then
		sudo curl -LRO -z "$FILE_NAME" "https://download.db-ip.com/free/$FILE_NAME"
	else
		# Télécharge le fichier si aucune version locale n'existe
		sudo curl -LRO "https://download.db-ip.com/free/$FILE_NAME"
	fi

	# Décompresse le fichier téléchargé
	if [ -f "$FILE_NAME" ]; then
		sudo gunzip --keep --force "$FILE_NAME"
	fi

	# Met à jour le lien symbolique pour pointer vers la version actuelle
	sudo ln -sf "$LOCAL_FILE" "dbip-${TYPE}.mmdb"
done

sudo rm -fv DBIP-City.mmdb

sudo ln -sfv /usr/share/GeoIP/dbip-city-lite-$(date +%Y-%m).mmdb /usr/share/GeoIP/DBIP-City.mmdb
sudo ln -sfv /usr/share/GeoIP/DBIP-City.mmdb /var/lib/GeoIP/DBIP-City.mmdb

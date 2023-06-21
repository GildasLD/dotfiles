#!/bin/bash
handle_error() {
	echo "Erreur : $1"
	exit 1
}
# Vérifie si l'utilisateur est root
if [ "$(id -u)" -ne 0 ]; then
	handle_error "Ce script doit être exécuté avec les droits root."
fi
# Variables
# Demande le périphérique disque
read -p "Entrez le périphérique disque (ex: /dev/sda) : " DISK
if [ ! -b "$DISK" ]; then
	handle_error "Erreur : $DISK n'est pas un périphérique valide."
fi
echo "Attention : Toutes les données sur $DISK seront supprimées !"
read -t 30 -p "Êtes-vous sûr de vouloir continuer ? (yes/no) : " confirmation
confirmation=${confirmation:-no} # Définit "no" comme valeur par défaut
if [ "$confirmation" != "yes" ]; then
	handle_error "Opération annulée."
fi
echo "Création d'une nouvelle table GPT sur $DISK..."
# Étape 2 : Supprime toutes les signatures existantes
echo "Suppression des signatures existantes..."
wipefs -a "$DISK" ||
	handle_error "Erreur lors de la suppression des signatures."
# Étape 3 : Crée une nouvelle table de partition GPT
echo "Création de la table GPT..."
parted "$DISK" mklabel gpt ||
	handle_error "Erreur lors de la création de la table GPT."
TOTAL_SIZE=1048576 # 1 Tio en Mio
# Demande la taille totale du disque
# read -p "Entrez la taille totale du disque en Mio : " TOTAL_SIZE
if ((TOTAL_SIZE < 20480)); then
	handle_error "Erreur : La taille totale doit être d'au moins 20480 MiO (20 Go)."
fi
# Définitions des tailles fixes
BOOT_SIZE=1024  # en Mio (1 GiO)
SWAP_SIZE=8192  # en Mio (8 GiO)
ROOT_SIZE=61440 # en Mio (60 GiO)
VAR_SIZE=102400 # en Mio (100 GiO)
# Calcul des tailles dynamiques
DYNAMIC_SIZE=$((TOTAL_SIZE - BOOT_SIZE - SWAP_SIZE - ROOT_SIZE - VAR_SIZE))
# ROOT_SIZE=$((DYNAMIC_SIZE * 2 / 10))      # 30% pour /
HOME_SIZE=$((DYNAMIC_SIZE / 1)) # 100% du reste pour /home
# Vérification des tailles calculées
if ((ROOT_SIZE <= 0 || HOME_SIZE <= 0 || VAR_SIZE <= 0)); then
	handle_error "Erreur : Les tailles dynamiques sont invalides. Vérifiez la taille totale du disque."
fi
# Conversion en secteurs (512 octets par secteur)
SECTOR_CONVERSION=2048
BOOT_SECTORS=$((BOOT_SIZE * SECTOR_CONVERSION))
SWAP_SECTORS=$((SWAP_SIZE * SECTOR_CONVERSION))
ROOT_SECTORS=$((ROOT_SIZE * SECTOR_CONVERSION))
HOME_SECTORS=$((HOME_SIZE * SECTOR_CONVERSION))
VAR_SECTORS=$((VAR_SIZE * SECTOR_CONVERSION))
# Création des partitions
echo "Création des partitions sur $DISK..."
sgdisk --zap-all "$DISK"
sgdisk -n 1:2048:+${BOOT_SECTORS} -t 1:8300 -c 1:"boot" "$DISK" # /boot
sgdisk -n 2:0:+${SWAP_SECTORS} -t 2:8200 -c 2:"swap" "$DISK"    # swap
sgdisk -n 3:0:+${ROOT_SECTORS} -t 3:8300 -c 3:"root" "$DISK"    # /
sgdisk -n 4:0:+${HOME_SECTORS} -t 4:8300 -c 4:"home" "$DISK"    # /home
sgdisk -n 5:0:+${VAR_SECTORS} -t 5:8300 -c 5:"var" "$DISK"      # /var
BOOT_PART="${DISK}1"
SWAP_PART="${DISK}2"
ROOT_PART="${DISK}3"
HOME_PART="${DISK}4"
VAR_PART="${DISK}5"
# Formattage des partitions
echo "Formatage des partitions..."
# Utilise mkfs.fat pour formater la partition en FAT32
mkfs.fat -F 32 "${BOOT_PART}" -n boot || handle_error "Erreur de formatage de /boot en FAT32."
mkswap "${SWAP_PART}" -L swap || handle_error "Erreur de formatage du swap."
mkfs.ext4 "${ROOT_PART}" -b 4096 -L root || handle_error "Erreur de formatage de /."
mkfs.xfs -f "${HOME_PART}" -b size=4k -L home || handle_error "Erreur de formatage de /home."
mkfs.xfs -f -L 'var' -b size=4k "${VAR_PART}" || handle_error "Erreur de formatage de /var."
# Activation du swap
echo "Activation du swap..."
swapon "${SWAP_PART}" || handle_error "Erreur lors de l'activation du swap."
# Montage des partitions
echo "Montage des partitions..."
mount "${ROOT_PART}" /mnt || handle_error "Erreur de montage pour /."
mkdir -p /mnt/boot
mount "${BOOT_PART}" /mnt/boot || handle_error "Erreur de montage pour /boot."
mkdir -p /mnt/home
mount "${HOME_PART}" /mnt/home || handle_error "Erreur de montage pour /home."
mkdir -p /mnt/var
mount "${VAR_PART}" /mnt/var || handle_error "Erreur de montage pour /var."
# Montage temporaire de /tmp
# echo "Configuration de /tmp en tmpfs..."
# mkdir -p /mnt/tmp
# mount -t tmpfs -o size=2G tmpfs /mnt/tmp || handle_error "Erreur de montage pour /mnt/tmp."
echo "Partitionnement et montage terminés avec succès."

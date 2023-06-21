#!/bin/bash

# Vérifie si l'utilisateur est root
if [ "$(id -u)" -ne 0 ]; then
	echo "Ce script doit être exécuté avec les droits root."
	exit 1
fi

# Variables
read -p "Entrez le point de montage du disque : " DEVICE
# DEVICE="/dev/sda"

echo "Attention : Toutes les données sur $DEVICE seront supprimées !"
read -p "Êtes-vous sûr de vouloir continuer ? (yes/no) : " confirmation
if [ "$confirmation" != "yes" ]; then
	echo "Opération annulée."
	exit 0
fi

DEVICE="/dev/sda"

echo "Vérification des montages pour $DEVICE..."
# Trouve les partitions montées
mounted_partitions=$(mount | grep "^$DEVICE" | awk '{print $1}')

# Démonte les partitions montées
if [ -n "$mounted_partitions" ]; then
	echo "Partitions montées trouvées : $mounted_partitions"
	for partition in $mounted_partitions; do
		echo "Démontage de $partition..."
		umount "$partition" || {
			echo "Échec du démontage de $partition"
			exit 1
		}
	done
else
	echo "Aucune partition montée trouvée sur $DEVICE."
fi

echo "Vérification des processus utilisant $DEVICE..."
# Trouve les processus utilisant le périphérique
processes=$(lsof "$DEVICE" 2> /dev/null | awk 'NR>1 {print $2}' | sort -u)
if [ -n "$processes" ]; then
	echo "Processus trouvés : $processes"
	for pid in $processes; do
		echo "Arrêt du processus $pid..."
		kill -9 "$pid" || {
			echo "Échec de l'arrêt du processus $pid"
			exit 1
		}
	done
else
	echo "Aucun processus utilisant $DEVICE."
fi

echo "Vérification des volumes RAID..."
# Arrête les volumes RAID associés
if grep -q "$DEVICE" /proc/mdstat; then
	raid_devices=$(cat /proc/mdstat | grep "$DEVICE" | awk '{print $1}')
	for raid in $raid_devices; do
		echo "Arrêt du volume RAID $raid..."
		mdadm --stop "/dev/$raid" || {
			echo "Échec de l'arrêt du RAID $raid"
			exit 1
		}
	done
else
	echo "Aucun volume RAID trouvé pour $DEVICE."
fi

echo "Vérification des volumes LVM..."
# Désactive les volumes LVM associés
lvm_volumes=$(lvdisplay 2> /dev/null | grep "$DEVICE" -B1 | grep "LV Path" | awk '{print $3}')
if [ -n "$lvm_volumes" ]; then
	for lv in $lvm_volumes; do
		echo "Désactivation du volume logique $lv..."
		lvchange -an "$lv" || {
			echo "Échec de la désactivation de $lv"
			exit 1
		}
	done
else
	echo "Aucun volume LVM trouvé pour $DEVICE."
fi

echo "Vérification de l'utilisation comme swap..."
# Désactive le swap associé
swaps=$(swapon --show=NAME | grep "$DEVICE")
if [ -n "$swaps" ]; then
	for swap in $swaps; do
		echo "Désactivation du swap $swap..."
		swapoff "$swap" || {
			echo "Échec de la désactivation du swap $swap"
			exit 1
		}
	done
else
	echo "Aucun swap trouvé pour $DEVICE."
fi

echo "Exécution de wipefs pour effacer les signatures..."
# Exécute wipefs
wipefs --all "$DEVICE" || {
	echo "Échec de l'exécution de wipefs sur $DEVICE"
	exit 1
}
# Étape 3 : Crée une nouvelle table de partition GPT
echo "Création de la table GPT..."
parted "$DEVICE" mklabel gpt || {
	echo "Erreur lors de la création de la table GPT."
	exit 1
}

echo "Opérations terminées avec succès sur $DEVICE."

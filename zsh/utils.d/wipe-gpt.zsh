#!/bin/bash

# Vérifie si l'utilisateur est root
if [ "$(id -u)" -ne 0 ]; then
    echo "Ce script doit être exécuté avec les droits root."
    exit 1
fi

# Variables
read -p "Entrez le point de montage du disque : " DISK
# DISK="/dev/sda"

echo "Attention : Toutes les données sur $DISK seront supprimées !"
read -p "Êtes-vous sûr de vouloir continuer ? (yes/no) : " confirmation
if [ "$confirmation" != "yes" ]; then
    echo "Opération annulée."
    exit 0
fi


echo "Création d'une nouvelle table GPT sur $DISK..."

# Étape 2 : Supprime toutes les signatures existantes
echo "Suppression des signatures existantes..."
wipefs -a "$DISK" || { echo "Erreur lors de la suppression des signatures."; exit 1; }

# Étape 3 : Crée une nouvelle table de partition GPT
echo "Création de la table GPT..."
parted "$DISK" mklabel gpt || { echo "Erreur lors de la création de la table GPT."; exit 1; }

# Étape 4 : Crée une nouvelle partition couvrant tout le disque
# echo "Création d'une nouvelle partition..."
# parted "$DISK" mkpart primary ext4 0% 100% || { echo "Erreur lors de la création de la partition."; exit 1; }

#!/bin/bash

# Augmente la taille du cache de l'index pour améliorer les performances
git config --global core.bigFileThreshold 250m
echo "Seuil des gros fichiers ajusté pour une meilleure performance."

# Augmente la taille de la mémoire pour la fenêtre de compression Delta
git config --global pack.windowMemory "1g"  # Utilise 1 Go pour une compression plus rapide et efficace
git config --global pack.packSizeLimit "1g" # Limite la taille des packs à 1 Go
git config --global pack.threads "$(nproc)" # Utilise tous les threads disponibles du CPU
echo "Optimisation de la compression Delta configurée avec une utilisation accrue des ressources CPU et RAM."

# Active le nettoyage automatique des fichiers pack inutiles après le ramassage des ordures
git config --global gc.auto 1000 # Désactive le ramassage automatique pour éviter des conflits avec `git gc` manuel
git config --global gc.autoPackLimit 30

# Affiche un message de confirmation de la fin du processus
echo "Configuration de Git complétée avec succès."

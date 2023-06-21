#!/bin/zsh

cd ~/AUR_PACKAGES || exit

# Parcourt chaque sous-dossier dans AUR_PACKAGES
for dir in */ ; do
  # Entre dans le sous-dossier
  cd "$dir" || continue
  
  # Effectue un git pull avec rebase et autostash
  output=$(git pull --rebase --autostash)
  # Vérifie si des modifications ont été tirées
  if [[ "$output" == *"Déjà à jour."* ]]; then
    # Si le dépôt est déjà à jour, ignore l'installation
    echo "$dir est déjà à jour, aucune réinstallation nécessaire."
  else
    # S'il y a des changements, compile et installe le paquet sans demande de confirmation
    echo "Mise à jour du paquet dans $dir avec makepkg."
    makepkg -si --noconfirm
  fi
  
  # Retourne dans le répertoire parent
  cd ..
done
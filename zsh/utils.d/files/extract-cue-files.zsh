#!/bin/zsh

# Recherche tous les fichiers *.cue dans le répertoire actuel et ses sous-dossiers
find "$PWD" -type f -name "*.cue" | while IFS= read -r cuefile; do
    # Génère le nom du fichier audio correspondant
    audiofile="${cuefile%.cue}.flac"
    
    # Vérifie si le fichier audio existe
    if [ -f "$audiofile" ]; then
        echo "Traitement du fichier : $cuefile"
        
        # Découpe le fichier audio en plusieurs pistes
        shnsplit -f "$cuefile" -t "%n - %t" -o flac "$audiofile"
        
        # Ajoute les tags aux fichiers FLAC générés
        cuetag "$cuefile" *.flac
    else
        echo "Fichier audio manquant pour : $cuefile"
    fi
done

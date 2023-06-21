#!/bin/bash

# Répertoire des fichiers Vim centralisés
VIM_DIR="$HOME/.vim"
UNDO_DIR="$VIM_DIR/undodir"
BACKUP_DIR="$VIM_DIR/backup"
SWAP_DIR="$VIM_DIR/swap"

# Crée les répertoires nécessaires
mkdir -pv "$UNDO_DIR" "$BACKUP_DIR" "$SWAP_DIR"

# Ajoute ou met à jour les configurations dans le fichier vimrc
VIMRC="$HOME/.vimrc"

{
	echo "\" Activer les fichiers d'annulation"
	echo "set undofile"
	echo "set undodir=$UNDO_DIR"

	echo ""
	echo "\" Activer les fichiers de sauvegarde"
	echo "set backup"
	echo "set backupdir=$BACKUP_DIR//"

	echo ""
	echo "\" Activer les fichiers temporaires"
	echo "set directory=$SWAP_DIR//"
} >>"$VIMRC"

# Message de confirmation
echo "Configuration de Vim mise à jour. Les fichiers sont centralisés dans :"
echo "- Fichiers d'annulation : $UNDO_DIR"
echo "- Fichiers de sauvegarde : $BACKUP_DIR"
echo "- Fichiers temporaires : $SWAP_DIR"

# Recharger automatiquement Vim si installé
if command -v vim >/dev/null 2>&1; then
	vim -c "source $VIMRC" -c "q!"
	echo "Configuration Vim rechargée."
fi

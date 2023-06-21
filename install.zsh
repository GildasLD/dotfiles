#!/usr/bin/env zsh

setopt ERR_EXIT

alias -g ln="ln -sfv"

GIT_TOP_LEVEL=$(git rev-parse --show-toplevel)
DOTFILES=$GIT_TOP_LEVEL

# Colors :
NC="\033[0m"
RED="\033[0;31m"

# Stderr and exit with an error
die() {
	clear
	echo -e "${RED}$* ${NC}\n" >&2
	exit 2
}

if [[ $EUID == 0 ]]; then
	die "Do not run this script with sudo !"
elif [ "$PWD" != "$GIT_TOP_LEVEL" ]; then
	die "You must be at the location of the script in order to execute it..."
fi

bypass=false

while [[ $# -gt 0 ]]; do
	case $1 in
	-y | --yes)
		bypass=true
		shift
		;;
	*)
		die "Option unknown : $1"
		;;
	esac
done

if [ "$bypass" = true ]; then
	install=1
else
	printf "Do you want to install dotfiles ? (y/N)\n"
	while true; do
		read -r choice
		case $choice in
		[Yy])
			install=1
			break
			;;
		[Nn])
			install=0
			break
			;;
		*)
			printf "${RED}Please answer y or n.${NC}\n"
			;;
		esac
	done
fi

if [ "$install" = "1" ]; then
	clear
	printf "${RED}Dotfiles is being installed...${NC}\n\n"
	# Updating sub-modules
	git submodule update --init --checkout --force --recursive --remote --verbose &&
		git submodule sync --recursive

	git submodule foreach '
		echo "Updating submodule in $(pwd)"
		git stash push --include-untracked -m "Auto stash before rebase"
		# Check if we are on a branch
		BRANCH=$(git symbolic-ref --short -q HEAD)
		if [ -z "$BRANCH" ]; then
			# Switch to main or master if in detached HEAD
			if git show-ref --verify --quiet refs/heads/main; then
				echo "Switching to main branch"
				git checkout main
				BRANCH="main"
			elif git show-ref --verify --quiet refs/heads/master; then
				echo "Switching to master branch"
				git checkout master
				BRANCH="master"
			else
				echo "No 'main' or 'master' branch found, please check the default branch"
				exit 1
			fi
		fi
		# Rebase on the remote branch with autostash
		git pull origin "$BRANCH" --rebase=interactive --autostash
		# Apply the stash if it exists
		if git stash list | grep -q "Auto stash before rebase"; then
			git stash pop
		fi
	'
	printf "\n"

	rm -rf $HOME/vim
	rm -rf $HOME/.config/nvim

	ln $DOTFILES/vim $HOME
	ln $DOTFILES/vim/.vimrc $HOME

	mkdir -pv $HOME/.config/nvim
	ln $DOTFILES/vim/.vimrc $HOME/.config/nvim/init.vim
	printf "\n"

	rm -rf $HOME/zsh
	ln $DOTFILES/zsh $HOME
	ln $DOTFILES/zsh/.zshrc $HOME
	ln $DOTFILES/zsh/.zshenv $HOME
	ln $DOTFILES/zsh/.zstyles $HOME
	ln $DOTFILES/zsh/.zshopts $HOME
	ln $DOTFILES/zsh/.zshtheme $HOME
	printf "\n"

	rm -rf $HOME/bash
	ln $DOTFILES/bash $HOME
	ln $DOTFILES/bash/.bashrc $HOME
	printf "\n"

	rm -rf $HOME/.tmux
	ln $DOTFILES/.config/.tmux $HOME
	if [ -d "oh-my-tmux" ]; then
		cp -avf oh-my-tmux/.tmux.conf $DOTFILES/.config/.tmux/.tmux.conf &&
			ln $DOTFILES/.config/.tmux/.tmux.conf $HOME
		ln $DOTFILES/.config/.tmux/.tmux.conf.local $HOME
		printf "\n"
	else
		die "Le répertoire oh-my-tmux n'existe pas, vérifie l'initialisation des sous-modules"
	fi

	rm -rf $HOME/.config/alacritty
	ln $DOTFILES/.config/alacritty $HOME/.config
	printf "\n"

	mkdir -pv $HOME/.config/VSCodium
	rm -f $HOME/.config/VSCodium/User/{settings,keybindings}.json
	rm -rf $HOME/.config/VSCodium/User/snippets
	ln $DOTFILES/vscode/snippets $HOME/.config/VSCodium/User
	ln $DOTFILES/vscode/settings.json $HOME/.config/VSCodium/User/settings.json
	ln $DOTFILES/vscode/keybindings.json $HOME/.config/VSCodium/User/keybindings.json
	printf "\n"

	rm -rf $HOME/.config/swaync
	ln $DOTFILES/.config/swaync $HOME/.config
	printf "\n"

	rm -rf $HOME/.config/sway
	ln $DOTFILES/.config/sway $HOME/.config
	printf "\n"

	rm -rf $HOME/.config/htop
	ln $DOTFILES/.config/htop $HOME/.config
	printf "\n"

	rm -rf $HOME/.config/aria2
	ln $DOTFILES/.config/aria2 $HOME/.config
	printf "\n"

	rm -rf $HOME/.config/wofi
	ln $DOTFILES/.config/wofi $HOME/.config
	printf "\n"

	mkdir -pv "$HOME/.config/sublime-text/Packages/User"
	rm -fv "$HOME/.config/sublime-text/Packages/User/Default (Linux).sublime-keymap"
	ln "$DOTFILES/.config/sublime-text/Default (Linux).sublime-keymap" "$HOME/.config/sublime-text/Packages/User/Default (Linux).sublime-keymap"

	printf "\n"

	rm -fv $HOME/.config/sublime-text/Packages/User/Preferences.sublime-settings
	ln $DOTFILES/.config/sublime-text/Preferences.sublime-settings $HOME/.config/sublime-text/Packages/User/Preferences.sublime-settings
	printf "\n"

	rm -rf $HOME/.config/claws-mails
	ln $DOTFILES/.config/claws-mails $HOME/.config
	ln $DOTFILES/.config/claws-mails/signature.sh $HOME
	printf "\n"

	rm -rf $HOME/.config/yt-dlp
	ln $DOTFILES/.config/yt-dlp $HOME/.config
	printf "\n"

	rm -rf $HOME/.config/gammastep
	ln $DOTFILES/.config/gammastep $HOME/.config

	rm -rf $HOME/.config/waybar
	ln $DOTFILES/.config/waybar $HOME/.config
else
	printf "${RED}We won't install the dotfiles.${NC}\n"
	exit 0
fi

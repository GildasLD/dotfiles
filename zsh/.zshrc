############
## Gildas ##
############

set -o noclobber

export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# Includes
source ~/zsh/.zshenv
source ~/zsh/.zshopts
source ~/zsh/.zshtheme
source ~/zsh/.zstyles

zmodload zsh/zprof

# bind UP and DOWN arrow keys for history substring search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# Plugins
plugins=(
	aliases
	colored-man-pages
	colorize
	composer
	fancy-ctrl-z
	fzf
	git
	git-flow-avh
	gnu-utils
	history
	laravel
	macos
	man
	nmap
	sublime-merge
	sudo
	symfony
	systemd
	timer
	tmux
	zsh-autopair
	zsh-completions
	zsh-history-substring-search
	zsh-interactive-cd
	zsh-z
)

# Aliases & Fonctions
for f in ~/zsh/{aliases.d,functions.d}/**/*; do
	source $f
done

# macOS
if [[ "$(uname)" == "Darwin" ]]; then
	# export PATH="/usr/local/opt/node@18/bin:$PATH"
	export PATH="/usr/local/opt/node@20/bin:$PATH"
	export PATH="/usr/local/opt/php@8.2/bin:$PATH"
	export PATH="/usr/local/opt/php@8.2/sbin:$PATH"
	for plugin in zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search; do
		source $(brew --prefix)/share/$plugin/$plugin.zsh
	done
	source $HOME/dotfiles/zsh/plugins.d/zsh-z/zsh-z.plugin.zsh
	[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# Autres
else
	zstyle ':completion:*:sudo:*' command-path /usr/local/sbin \
		/usr/local/bin \
		/usr/sbin \
		/usr/bin \
		/sbin \
		/bin \
		/usr/X11R6/bin

	fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
	for plugin in zsh-syntax-highlighting zsh-autosuggestions zsh-z zsh-history-substring-search zsh-autopair; do
		source $HOME/dotfiles/zsh/plugins.d/$plugin/$plugin.plugin.zsh
	done
fi

# theme : jtriley
export PATH="$PATH:$HOME/.local/bin"

# export NVM_DIR="$HOME/.config/nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# export LD_LIBRARY_PATH=/usr/local/lib
export PATH="/usr/local/go/bin/:$PATH"
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export PATH="/usr/local/opt/postgresql@16/bin:$PATH"
# export PATH="${HOME}/.config/composer/vendor/bin/phpcbf:$PATH"
export PATH="${HOME}/.config/composer/vendor/bin:$PATH"
export PKG_CONFIG_PATH="/usr/local/opt/zlib/lib/pkgconfig"


# debug (find alias ls=)
# zsh -ixc : 2>&1 | grepls=

sysstats

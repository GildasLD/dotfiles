#!/bin/zsh

# export DOCKER_USER="$(id -u):$(id -g)"
# export DOCKER_USER="1000:1000"
# export GID=1000
# export UID=1000
# export XDG_RUNTIME_DIR=/run/user/$(id -u)

# Vérifie si Wayland est utilisé
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
	export BEMENU_BACKEND=wayland
	export CLUTTER_BACKEND=wayland
	export GUAKE_ENABLE_WAYLAND=1
	export MOZ_DISABLE_RDD_SANDBOX=1
	export MOZ_ENABLE_WAYLAND=1
	export MOZ_WAYLAND_USE_VAAPI=1
    export MOZ_USE_XINPUT2=1
fi

# Vérifie si l'OS n'est pas macOS
if [[ "$(uname)" != "Darwin" ]]; then
	# export HOME="${HOME:-$(eval echo ~$USER)}"
	export _JAVA_AWT_WM_NONREPARENTING=1
	export GREP_OPTIONS='--color=auto --ignore-case --extended-regexp --recursive'
	export HOME="${HOME:-$(getent passwd $USER 2> /dev/null | cut -d: -f6)}"
	export LESS='--line-numbers --long-prompt --status-column --squeeze-blank-lines --file-size --save-marks --ignore-case --hilite-unread'
	export SDL_VIDEODRIVER="wayland,x11"
	export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"
	export USER=${USER:-$(id -u -n)}
	export XDG_CACHE_HOME="${HOME}/.cache"
	export XDG_CONFIG_HOME="${HOME}/.config"
	export XDG_CURRENT_DESKTOP=gnome
	export XDG_DATA_HOME="$HOME/.local/share"
	export XDG_RUNTIME_DIR="/run/user/1000"
	export XDG_STATE_HOME="${HOME}/.local/state"
else
	export GREP_OPTIONS='--color=auto --extended-regexp'
	export HOMEBREW_CASK_OPTS=--require-sha
	export HOMEBREW_NO_ANALYTICS=1
	export HOMEBREW_NO_INSECURE_REDIRECT=1
fi

# Exports globaux

export BAT_THEME="ansi"
export CHROME_BIN=/usr/bin/chromium
export COMPLETION_WAITING_DOTS="true"
export COMPOSE_DOCKER_CLI_BUILD=1
export CPPFLAGS="-I/usr/local/opt/llvm/include"
export DATE_="$(date +"%Y_%m_%d__%H%M_%S")"
export DISABLE_AUTO_TITLE="true"
export DISABLE_AUTO_UPDATE="true"
export DOCKER_BUILDKIT=1
export DOCKER_USER="$(id -u):$(id -g)"
export EDITOR='vim'
export ENABLE_CORRECTION="false"
export ENV=$HOME/.zshrc
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --extended'
export GID=$(id -g)
export GPG_TTY=$(tty)
export HIST_STAMPS="%-d.%-m.%Y %H:%M:%S"
export HISTCONTROL=ignoredups:erasedups
export HISTFILESIZE=65536
export HISTSIZE=4096
export HYPHEN_INSENSITIVE="true"
export JUPYTERLAB_DIR=$HOME/.local/share/jupyter/lab
export LANG="fr_FR.UTF-8"
export LANGUAGE="fr:en"
export LC_ADDRESS="fr_FR.UTF-8"
export LC_ALL=
export LC_COLLATE="fr_FR.UTF-8"
export LC_CTYPE="fr_FR.UTF-8"
export LC_IDENTIFICATION="fr_FR.UTF-8"
export LC_MEASUREMENT="fr_FR.UTF-8"
export LC_MESSAGES="fr_FR.UTF-8"
export LC_MONETARY="fr_FR.UTF-8"
export LC_NAME="fr_FR.UTF-8"
export LC_NUMERIC="fr_FR.UTF-8"
export LC_PAPER="fr_FR.UTF-8"
export LC_TELEPHONE="fr_FR.UTF-8"
export LC_TIME="fr_FR.UTF-8"
export LDFLAGS="-L/usr/local/opt/llvm/lib"
export LESS_TERMCAP_mb=$(printf '\33[01;35m')
export LESS_TERMCAP_md=$(printf '\33[01;35m')
export LESS_TERMCAP_me=$(printf '\33[0m')
export LESS_TERMCAP_se=$(printf '\33[0m')
export LESS_TERMCAP_so=$(printf '\33[01;44;33m')
export LESS_TERMCAP_ue=$(printf '\33[0m')
export LESS_TERMCAP_us=$(printf '\33[01;32m')
export PAGER='less -imMWR'
export QT_STYLE_OVERRIDE=adwaita-dark
export REPORTTIME=16
export SAVEHIST=4096
export SHELL_SESSIONS_DISABLE=1
export TERM='xterm-256color'
export TIMEFMT=$'\t \e[32m%J\e[0m\ntime: \e[34m%U user;\e[0m \e[33m%S system;\e[0m \e[31m%E real;\e[0m\n\e[36m%P cpu;\e[0m total disk \e[35m%K KB;\e[0m max RSS \e[31m%M KB\e[0m\n\t '
export TZ='Europe/Paris'
export UID=$(id -u)
export VISUAL=$EDITOR
export VISUAL=vim
export WATCH=all
export WATCH=notme
export WATCHFMT='%n %a %l from %m at %T.'
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=242,bold" 
export ZSH_DISABLE_COMPFIX=true
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
export ZSH="$HOME/.oh-my-zsh"
export ZSHZ_CASE=smart
export ZSHZ_ECHO=1
  
# Android et Java paths
export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_NDK_HOME=$HOME/Android/Sdk/ndk/28.0.12674087
# 26.1.10909125
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
export NDK_VERSION=28.0.12433566
export PATH=$PATH:$JAVA_HOME/bin

# Sourcing des fichiers zsh si existants
[ -f "$HOME/.zshcolors" ] && source "$HOME/.zshcolors"
[ -f "$HOME/.zshdebug" ] && source "$HOME/.zshdebug"
if test -f "$HOME/.zshcolors"; then
    source $HOME/.zshcolors
fi




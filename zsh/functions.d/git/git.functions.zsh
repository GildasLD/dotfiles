#!/usr/bin/zsh

fetchRepos() {
	local username=$1

	if [ -z "$username" ]; then
		echo "Veuillez fournir un nom d'utilisateur GitHub."
		return 1
	fi

	curl -s "https://api.github.com/users/$username/repos" | grep -e 'clone_url*' | cut -d \" -f 4 | xargs -L1 git clone --recurse-submodules
}

# fetch_repos gildas-ld
alias fetch_repos="fetchRepos"

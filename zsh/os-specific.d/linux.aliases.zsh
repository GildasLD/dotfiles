#!/usr/bin/zsh

alias ss="ss -tulpna"
alias sm='(nohup /usr/bin/smerge "${1:-.}" >/dev/null 2>&1 )' # & disown)'
alias st='(nohup /usr/bin/sublime_text "${1:-.}" >/dev/null 2>&1 )' # & disown)'
alias myip="hostname -i | awk '{ print $1 }'"
if [[ "$SHOULD_POWER_OFF" == "1" ]]; then
    alias mù='systemctl poweroff -i'
fi
alias mùù='systemctl reboot -i'

# pacman
function pac_unused {
  sudo pacman -Rns $(pacman -Qtdq)
}
alias pac_clean="sudo paccache -rk 1"

# systemd
alias daemon-reload="sudo systemctl daemon-reload"
alias disable="sudo systemctl disable"
alias enable="sudo systemctl enable"
alias reload-or-restart="sudo systemctl reload-or-restart"
alias restart="sudo systemctl restart"
alias start="sudo systemctl start"
alias status="sudo systemctl status"
alias stop="sudo systemctl stop"

# systemd system messages
alias journal-now="sudo journalctl -f"
alias journal-boot="sudo journalctl -b"
alias journal-prev-boot="sudo journalctl --since=today | tac | sed -n '/-- Reboot --/{n;:r;/-- Reboot --/q;p;n;b r}' | tac"

# git remove all merged branches, except current and master
alias git-clean-branches="git branch --merged | grep -v '\*' | grep -v master | xargs -n 1 git branch -d"

# encrypt and decrypt
alias rsa-enc="openssl rsautl -encrypt -pubin -inkey <(ssh-keygen -f ~/.ssh/id_rsa.pub -e -m PKCS8) -ssl | openssl base64"
alias rsa-dec="openssl base64 -d | openssl rsautl -decrypt -inkey ~/.ssh/id_rsa"
alias gpg-enc="gpg --encrypt --armor"
alias gpg-dec="gpg --decrypt"

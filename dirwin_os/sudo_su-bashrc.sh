# sudo su; cp sudo_su-bashrc.sh /var/root/.bashrc

# Change root shell to bash (or /bin/zsh)
# sudo su; dscl . -change /Users/root UserShell /bin/sh /bin/bash
# Or for zsh: sudo dscl . -change /Users/root UserShell /bin/sh /bin/zsh

# sudo visudo
# ==== For nnn file manger ====
# Defaults	env_keep += "NNN_ORDER NNN_PLUG NNN_COLORS NNN_OPENER NNN_OPTS NNN_ARCHIVE NNN_FCOLORS"
# Defaults	env_keep += "PATH"

export EDITOR="/Users/pritam/.local/bin/nvim"
export ZED_ALLOW_ROOT=true

PS1=" \[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]# "

# aliases ---------------------------------------------------
alias erc="$EDITOR ~/.bashrc"
alias hc="cat /dev/null > ~/.bash_history"
alias which="which -a"
# -----------------------------------------------------------

#  Some more ls aliases
alias ls="command ls --color=auto"
alias grep="command grep --color=auto"
alias fgrep="command fgrep --color=auto"
alias egrep="command egrep --color=auto"

alias ll="command ls -lh"
alias la="command ls -A"
alias l="command ls -lAh"

#  SOME MORE ALIES
alias cp="command cp -ip"
alias mv="command mv -i"
alias du="command du -h"

function n () {
	[ "${NNNLVL:-0}" -eq 0 ] || {
		echo "nnn is already running"
		return
	}

	/Users/pritam/.local/bin/nnn "$@"

	[ ! -f "$NNN_TMPFILE" ] || {
		. "$NNN_TMPFILE"
	}
}

function pathcp {
	local file="${1:-}"
	if [[ ! $file = /* ]]; then
		file="$PWD/$file"
	fi
	printf "$(realpath "$file")" | pbcopy
}

function bash() {
	if [ -f "$HOME/.bashrc" ]; then
		source "$HOME/.bashrc"
	fi
}

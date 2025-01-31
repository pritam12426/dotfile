#  .bashrc

export EDITOR="nvim"

if [ -f "$HOME/.bash_profile" ]; then
	source "$HOME/.bash_profile"
fi

if [ -f "$HOME/.alias.zsh" ]; then
	source "$HOME/.alias.zsh"
fi

# aliases ---------------------------------------------------
alias erc="$EDITOR ~/.bashrc"
alias hc="cat /dev/null > ~/.bash_history"
alias which="which -a"
# -----------------------------------------------------------

#  For setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100
HISTFILESIZE=200

#  PS1 variable
PS1=" \[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "

function bash() {
	if [ -f "$HOME/.bashrc" ]; then
		source "$HOME/.bashrc"
	fi
}

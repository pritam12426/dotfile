#  .bashrc

if [ -f "$DOT_FILE/dirwin_os/.alias.zsh" ]; then
	source "$DOT_FILE/dirwin_os/.alias.zsh"
fi

if [ -f "$HOME/.bash_profile" ]; then
	source "$HOME/.bash_profile"
fi

export EDITOR="nvim"

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

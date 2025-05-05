#  .zshrc use this file for setting up the shell environment this file is sourced by zsh

export EDITOR="/Users/pritam/.local/bin/nvim"


if [ -f "$HOME/.alias.zsh" ]; then
	source "$HOME/.alias.zsh"
fi

#  PS1 Variables
PROMPT="%B%F{green}%n@%m%f%b:%F{blue}%B%~%b%f$ " # bash theme
# PROMPT="%B%F{magenta}%n@%m%f%b: [ %F{cyan}%B%U%~%u%b%f ] 🔪"$'\n'"  "
# RPROMPT="~ %F{241}%t%f"


function zsh() {
	if [ -f "$HOME/.alias.zsh" ]; then
		source "$HOME/.alias.zsh"
	fi

	if [ -f "$HOME/.zshrc" ]; then
		source "$HOME/.zshrc"
	fi

	if [ -f "$HOME/.zprofile" ]; then
		source "$HOME/.zprofile"
	fi
}

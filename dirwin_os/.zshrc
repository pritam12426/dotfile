#  .zshrc

export EDITOR="nvim"

if [ -f "$HOME/.alias.zsh" ]; then
	source "$HOME/.alias.zsh"
fi

#  For setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100
HISTFILESIZE=200

#  PS1 Variables
# PROMPT="%B%F{green}%n@%m%f%b:%F{blue}%B%~%b%f$ " # bash theme
PROMPT="%B%F{green}%n@%m%f%b:%F{blue}%B%~%b%f$ " # bash theme
# PROMPT="%B%F{magenta}%n@%m%f%b: [ %F{cyan}%B%U%~%u%b%f ] 🔪"$'\n'"  "
# RPROMPT="~ %F{241}%t%f"


function zsh() {
	if [ -f "$HOME/.alias.zsh" ]; then
		source "$HOME/.alias.zsh"
	fi
}

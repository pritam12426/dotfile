export EDITOR="/Users/pritam/.local/bin/nvim"

if [ -f "$DOT_FILE/dirwin_os/.alias.zsh" ]; then
	source "$DOT_FILE/dirwin_os/.alias.zsh"
fi

#  PS1 Variables
PROMPT="%B%F{green}%n@%m%f%b:%F{blue}%B%~%b%f$ " # bash theme
# PROMPT="%B%F{magenta}%n@%m%f%b: [ %F{cyan}%B%U%~%u%b%f ] 🔪"$'\n'"  "
# RPROMPT="~ %F{241}%t%f"

# aliases ---------------------------------------------------
alias erc="$EDITOR ~/.zshrc"
# -----------------------------------------------------------

# auto completion -----------------------------
fpath=($HOME/.zsh/completions $fpath)
# Load and initialize the completion system
autoload -Uz compinit
compinit -i   # -i ignores insecure directories

# Optional: cache completions for speed
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
# ---------------------------------------------

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

source /Users/pritam/.config/broot/launcher/bash/br

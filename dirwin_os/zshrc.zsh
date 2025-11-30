export LIBS_DIR="/usr/local/big_library"
export EDITOR="$HOME/.local/bin/nvim"
export DOT_FILE="$HOME/Developer/git_repository/my_dotfile"

export CXX="/usr/bin/clang++"
export CC="/usr/bin/clang"
export PREFIX="$HOME/.local"

# SUPPORTING SOME PRIVATE VARIABLES INSIDE .zshenv =============================
# export ARIA2C_SESSION_TOKEN="go to .zshenv"
# export GITHUB_AUTH_TOKEN="go to .zshenv"     # this pritam_lpu_12416
# ==============================================================================

# TEX-LIVE-SMALL ===============================================================
export PATH="/usr/local/cli-programs/tex-live-small/bin/universal-darwin:$PATH"
export PATH="/usr/local/big_library-bin:$PATH"
# ==============================================================================

# FOR THE DEVELOPER ============================================================
export PATH="$HOME/Library/Python/3.9/bin:$PATH"
export MANPATH="$HOME/Library/Python/3.9/share/man:$MANPATH"
fpath=("$HOME/Library/Python/3.9/share/zsh/site-functions" $fpath)

export DYLD_LIBRARY_PATH="/usr/local/lib:$DYLD_LIBRARY_PATH"
export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH"
export CMAKE_PREFIX_PATH="/usr/local/lib/cmake:$CMAKE_PREFIX_PATH"

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/github-releases-bin:$PATH"
# ==============================================================================


if [ -f "$DOT_FILE/dirwin_os/functions.sh" ]; then
	source "$DOT_FILE/dirwin_os/functions.sh"
fi

if [ -f "$DOT_FILE/dirwin_os/alias.zsh" ]; then
	source "$DOT_FILE/dirwin_os/alias.zsh"
fi

#  PS1 Variables
PROMPT="%B%F{green}%n@%m%f%b:%F{blue}%B%~%b%f$ " # bash theme
# PROMPT="%B%F{magenta}%n@%m%f%b: [ %F{cyan}%B%U%~%u%b%f ] 🔪"$'\n'"  "
# RPROMPT="~ %F{241}%t%f"

# aliases ---------------------------------------------------
# Load Apple’s default interactive zsh environment (fixes most issues)
[ -f /etc/zshrc ] && source /etc/zshrc
setopt SHARE_HISTORY

# HISTFILE="$HOME/.zhistory"
# completion using arrow keys (based on history)
# bindkey '^[[A' history-search-backward
# bindkey '^[[B' history-search-forward

alias erc="$EDITOR ~/.zshrc"
alias eenv="$EDITOR ~/.zshenv"
# -----------------------------------------------------------

# auto completion -----------------------------
fpath=("$HOME/.zsh/completions" $fpath)
# Load and initialize the completion system
autoload -Uz compinit
compinit -i # -i ignores insecure directories

# Optional: cache completions for speed
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
# ---------------------------------------------


# =============================================
# When you open a new terminal window on macOS Zsh, the order is:
# ~/.zshenv → ~/.zprofile → ~/.zshrc → (then ~/.zlogin, if exists)
# =============================================


function zsh() {
	if [ -f "$HOME/.zhsenv" ]; then
		source "$HOME/.zhsenv"
	fi

	if [ -f "$DOT_FILE/dirwin_os/functions.sh" ]; then
		source "$DOT_FILE/dirwin_os/functions.sh"
	fi

	if [ -f "$DOT_FILE/dirwin_os/alias.zsh" ]; then
		source "$DOT_FILE/dirwin_os/alias.zsh"
	fi

	if [ -f "$HOME/.zshrc" ]; then
		source "$HOME/.zshrc"
	fi

	if [ -f "$HOME/.zprofile" ]; then
		source "$HOME/.zprofile"
	fi
}

source /Users/pritam/.config/broot/launcher/bash/br

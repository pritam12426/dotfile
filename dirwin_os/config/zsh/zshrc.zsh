export LIBS_DIR="/usr/local/big_library"
export EDITOR="$HOME/.local/bin/nvim"
export DOT_FILE="$HOME/Developer/git_repository/my_dotfile/dirwin_os/"

export CXX="/usr/bin/clang++"
export CC="/usr/bin/clang"
export PREFIX="$HOME/.local"

# SUPPORTING SOME PRIVATE VARIABLES INSIDE .zshenv =============================
# export ARIA2C_SESSION_TOKEN="go to .zshenv"
# export GITHUB_AUTH_TOKEN="go to .zshenv"     # this pritam_lpu_12416
# ==============================================================================

# FOR THE DEVELOPER ============================================================
export PATH="$HOME/Library/Python/3.9/bin:$PATH"
export MANPATH="$HOME/Library/Python/3.9/share/man:$MANPATH"
fpath=("$HOME/Library/Python/3.9/share/zsh/site-functions" $fpath)

export PATH="/usr/local/big_library-bin:$PATH"
export DYLD_LIBRARY_PATH="/usr/local/lib:$DYLD_LIBRARY_PATH"
export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH"
export CMAKE_PREFIX_PATH="/usr/local/lib/cmake:$CMAKE_PREFIX_PATH"

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/github-releases-bin:$PATH"
# ==============================================================================

if [ -f "$DOT_FILE/config/zsh/functions.sh" ]; then
	source "$DOT_FILE/config/zsh/functions.sh"
fi

if [ -f "$DOT_FILE/config/zsh/alias.zsh" ]; then
	source "$DOT_FILE/config/zsh/alias.zsh"
fi

#  PS1 Variables
PROMPT="%B%F{green}%n@%m%f%b:%F{blue}%B%~%b%f$ " # bash theme
# PROMPT="%B%F{magenta}%n@%m%f%b: [ %F{cyan}%B%U%~%u%b%f ] 🔪"$'\n'"  "
# RPROMPT="~ %F{241}%t%f"

# aliases ---------------------------------------------------
# HISTFILE="$HOME/.zhistory"
# completion using arrow keys (based on history)
# bindkey '^[[A' history-search-backward
# bindkey '^[[B' history-search-forward

alias erc="$EDITOR  ~/.zshrc"
alias eenv="$EDITOR ~/.zshenv"
# -----------------------------------------------------------

# auto completion -----------------------------
# Load Apple’s default interactive zsh environment (fixes most issues)
[ -f /etc/zshrc ] && source /etc/zshrc
bindkey "^K" kill-whole-line    # ctrl-k
bindkey "^[[3~" kill-whole-line # delete key

bindkey "^[[1;2D" beginning-of-line # shift + left
bindkey "^[[1;2C" end-of-line       # shift + right

fpath=("$HOME/.local/share/zsh/site-functions" $fpath)
# Load and initialize the completion system
autoload -U compinit && compinit
zmodload -i zsh/complist

# man zshcontrib
zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:*' enable git #svn cvs

# Enable completion caching, use rehash to clear
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

# Fallback to built in ls colors
zstyle ':completion:*' list-colors ''

# Make the list prompt friendly
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'

# Make the selection prompt friendly when there are a lot of choices
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# Add simple colors to kill
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

zstyle ':completion:*' menu select=1 _complete _ignored _approximate

# insert all expansions for expand completer
# zstyle ':completion:*:expand:*' tag-order all-expansions

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:scp:*' tag-order files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:scp:*' group-order files all-files users hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:ssh:*' group-order hosts-domain hosts-host users hosts-ipaddr
zstyle '*' single-ignored show

# ZAW styles
zstyle ':filter-select:highlight' matched fg=yellow,standout
zstyle ':filter-select' max-lines 10         # use 10 lines for filter-select
zstyle ':filter-select' max-lines -10        # use $LINES - 10 for filter-select
zstyle ':filter-select' rotate-list yes      # enable rotation for filter-select
zstyle ':filter-select' case-insensitive yes # enable case-insensitive search
zstyle ':filter-select' extended-search no   # see below

# ===== Basics

# If you type foo, and it isn't a command, and it is a directory in your cdpath, go there
setopt AUTO_CD

# Allow comments even in interactive shells (especially for Muness)
# setopt INTERACTIVE_COMMENTS

# ===== History

# Allow multiple terminal sessions to all append to one zsh command history
setopt APPEND_HISTORY

# Add comamnds as they are typed, don't wait until shell exit
setopt INC_APPEND_HISTORY

# Do not write events to history that are duplicates of previous events
setopt HIST_IGNORE_DUPS

# When searching history don't display results already cycled through twice
setopt HIST_FIND_NO_DUPS

# Remove extra blanks from each command line being added to history
setopt HIST_REDUCE_BLANKS

# Include more information about when the command was executed, etc
setopt EXTENDED_HISTORY

# ===== Completion

# Allow completion from within a word/phrase
setopt COMPLETE_IN_WORD

# When completing from the middle of a word, move the cursor to the end of the word
setopt ALWAYS_TO_END

# ===== Prompt

# Enable parameter expansion, command substitution, and arithmetic expansion in the prompt
setopt PROMPT_SUBST

unsetopt MENU_COMPLETE
setopt AUTO_MENU
# -----------------------------------------------------------

# =============================================
# When you open a new terminal window on macOS Zsh, the order is:
# ~/.zshenv → ~/.zprofile → ~/.zshrc → (then ~/.zlogin, if exists)
# =============================================

function zsh() {
	if [ -f "$HOME/.zhsenv" ]; then
		source "$HOME/.zhsenv"
	fi

	if [ -f "$DOT_FILE/config/zsh/functions.sh" ]; then
		source "$DOT_FILE/config/zsh/functions.sh"
	fi

	if [ -f "$DOT_FILE/config/zsh/alias.zsh" ]; then
		source "$DOT_FILE/config/zsh/alias.zsh"
	fi

	if [ -f "$HOME/.zshrc" ]; then
		source "$HOME/.zshrc"
	fi

	if [ -f "$HOME/.zprofile" ]; then
		source "$HOME/.zprofile"
	fi
}

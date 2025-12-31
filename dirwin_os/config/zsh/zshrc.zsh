# printf "Importing \t %s \n" "$HOME/.config/zsh/zshrc.zsh"

[[ $- != *i* ]] && return

# IMPORTING SOME PLUGINS =======================================================================================
# # Load Apple’s default interactive zsh environment (fixes most issues)
# [ -f /etc/zshrc ] && source /etc/zshrc


if [ -f "$HOME/.config/zsh/alias.zsh" ]; then
	source "$HOME/.config/zsh/alias.zsh"
fi

if [ -f "$HOME/.local/share/zsh/plugins/__fzf-history__" ]; then
	source "$HOME/.local/share/zsh/plugins/__fzf-history__"
else
	if hash fzf 2>/dev/null; then
		printf "You have not installed the fzf history plugin \t %s:%d\n" "$HOME/.config/zsh/zshrc.zsh" ${LINENO}
		# mkdir -vp "$HOME/.local/share/zsh/plugins/" && fzf --zsh > "$HOME/.local/share/zsh/plugins/__fzf-history__"
	fi
fi

if [ -f "$HOME/.local/share/zsh/plugins/__navi_widget__" ]; then
	source "$HOME/.local/share/zsh/plugins/__navi_widget__"
else
	if hash navi 2>/dev/null; then
		printf "You have not installed the fzf history plugin \t %s:%d\n" "$HOME/.config/zsh/zshrc.zsh" ${LINENO}
		# mkdir -vp "$HOME/.local/share/zsh/plugins/" && fzf --zsh > navi widget zsh > "$HOME/.local/share/zsh/plugins/__navi_widget__"
	fi
fi

if [ -f "$HOME/.local/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh" ]; then
	# source "$HOME/.local/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
else
	printf "You have not installed the fast-syntax-highlighting-plugin \t %s:%d\n" "$HOME/.config/zsh/zshrc.zsh" ${LINENO}

	# mkdir -vp "$HOME/.local/share/zsh/plugins/fast-syntax-highlighting"
	# cd "$HOME/.local/share/zsh/plugins/zsh-autosuggestions"
	# wget "https://github.com/zdharma-continuum/fast-syntax-highlighting/archive/refs/heads/master.zip"
fi

if [[ -f "$HOME/.local/share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh" ]]; then
	source "$HOME/.local/share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh"
else
	printf "You have not installed the you-should-use-plugin \t %s:%d\n" "$HOME/.config/zsh/zshrc.zsh" ${LINENO}

	# mkdir -vp "$HOME/.local/share/zsh/plugins/you-should-use-plugin"
	# wget "https://raw.githubusercontent.com/MichaelAquilina/zsh-you-should-use/refs/heads/master/you-should-use.plugin.zsh" -P \
	# "$HOME/.local/share/zsh/plugins/you-should-use-plugin" -O "you-should-use.plugin.zsh"
fi

if [ -f "$HOME/.local/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh" ]; then
	# source "$HOME/.local/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh"
else
	printf "You have not installed the zsh-autosuggestions-plugin \t %s:%d\n" "$HOME/.config/zsh/zshrc.zsh" ${LINENO}

	# mkdir -vp "$HOME/.local/share/zsh/plugins/zsh-autosuggestions"
	# cd "$HOME/.local/share/zsh/plugins/zsh-autosuggestions"
	# wget "https://github.com/zsh-users/zsh-autosuggestions/archive/refs/heads/master.zip"
fi
# ============================================================================================================

# Bookmark dir ====================================
hash -d  go="$HOME/Developer/go_lang"


# Copy current command buffer to clipboard (macOS)
function copy-buffer-to-clipboard() {
  echo -n "$BUFFER" | pbcopy
  zle -M "Copied to clipboard"
}
zle -N copy-buffer-to-clipboard
bindkey '^Xc' copy-buffer-to-clipboard
# =================================================


# OPEN BUFFER LINE INTO EDITOR FOR EDITING =======================================================
# https://www.youtube.com/watch?v=3fVAtaGhUyU
# https://gist.github.com/elliottminns/09a598082d77f795c88e93f7f73dba61

bindkey -e # user emac key pattern by defalut
autoload -Uz edit-command-line
autoload -Uz zmv
zle -N edit-command-line
bindkey '^[' edit-command-line

bindkey ' ' magic-space #!?docker?

chpwd() {
	if [[ -d .venv ]]; then
		source .venv/bin/activate
	elif [[ -d venv ]]; then
		source venv/bin/activate
	elif [[ -n "$VIRTUAL_ENV" ]]; then
		deactivate
	fi
}

# ================================================================================================


# AUTO COMPLETION ============================================================================================
# https://zsh.sourceforge.io/Doc/Release/Zsh-Modules.html
# https://github.com/spicycode/ze-best-zsh-config
# See this dir "/usr/lib/zsh/5.9"
zmodload -i zsh/complist
autoload -Uz compinit && compinit
autoload -Uz vcs_info && vcs_info

# man zshcontrib
zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:*' enable git #svn cvs

# Enable completion caching, use rehash to clear
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "$HOME/.zsh/cache/$HOST"

# Fallback to built in ls colors
# zstyle ':completion:*' list-colors ''

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
zstyle ':completion:*:expand:*' tag-order all-expansions

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# formatting and messages
# https://www.masterzen.fr/2009/04/19/in-love-with-zsh-part-one/
zstyle ':completion:*' verbose yes
# zstyle ':completion:*'                 format '%B---- %d%b'
# '\e[04;38;5;196m'
# zstyle ':completion:*:descriptions' format $'========== %{\e[04;38;5;196m%}Completing %B%d%b%{\e[0m%}'
zstyle ':completion:*:descriptions' format "%{$fg[red]%}▶%{$reset_color%} %{$fg_bold[white]%}%d%{$reset_color%}"
# zstyle ':completion:*:messages' format '%B%U+ %d%u%b'
# zstyle ':completion:*:warnings' format 'No matches for: %d'
# zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:scp:*' tag-order files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:scp:*' group-order files all-files users hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:ssh:*' group-order hosts-domain hosts-host users hosts-ipaddr
zstyle ':completion:*' menu select
zstyle '*' single-ignored show

# ZAW styles
zstyle ':filter-select:highlight' matched fg=yellow,standout
zstyle ':filter-select' max-lines 10         # use 10 lines for filter-select
zstyle ':filter-select' max-lines -10        # use $LINES - 10 for filter-select
zstyle ':filter-select' rotate-list yes      # enable rotation for filter-select
zstyle ':filter-select' case-insensitive yes # enable case-insensitive search
zstyle ':filter-select' extended-search no   # see below
# ============================================================================================================


# ZSH KEYMAPKING ============================================================================================
# VIM MODE =======
# bindkey -v
# export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
# bindkey -M menuselect 'h' vi-backward-char
# bindkey -M menuselect 'k' vi-up-line-or-history
# bindkey -M menuselect 'l' vi-forward-char
# bindkey -M menuselect 'j' vi-down-line-or-history
# bindkey -v '^?' backward-delete-char

# Edit line in vim with ctrl-e:
# autoload edit-command-line && zle -N edit-command-line
# bindkey '^e' edit-command-line
# bindkey -M vicmd '^[[P' vi-delete-char
# bindkey -M vicmd '^e' edit-command-line
# bindkey -M visual '^[[P' vi-delete


# bindkey "^K"      kill-whole-line    # ctrl-k
# bindkey "^[[3~"   kill-whole-line    # delete key

# bindkey "^[[1;2D" beginning-of-line  # shift + left
# bindkey "^[[1;2C" end-of-line        # shift + right
# ============================================================================================================


# ZSH HISTORY ================================================================================================
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..|cd ...)"
# ===== Basics

# If you type foo, and it isn't a command, and it is a directory in your cdpath, go there
setopt AUTO_CD

# Allow comments even in interactive shells (especially for Muness)
setopt INTERACTIVE_COMMENTS

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

# unsetopt MENU_COMPLETE
setopt AUTO_MENU
# ============================================================================================================


# SETTING THE ZSH PROMPT VAR && SOME CONFIG ==================================================================
zmodload  zsh/datetime
autoload -Uz add-zsh-hook

# if [[ -f /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh ]]; then
	# source "/Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh"
# else
	# printf "You have not installed the git-prompt plugin \t %s:%d\n" "$HOME/.config/zsh/zshrc.zsh" ${LINENO}
	# curl "https://raw.githubusercontent.com/git/git/refs/heads/master/contrib/completion/git-prompt.sh" -o "$HOME/.local/share/zsh/plugins/git-prompt.sh"
# fi

preexec() {
	timer=$EPOCHREALTIME
}

precmd() {
	if [[ -n $timer ]]; then
		local exit_code=${pipestatus[1]}

		# Compute elapsed time in milliseconds (pure zsh math)
		local now=$EPOCHREALTIME
		local start_int=${timer%.*}
		local start_frac=${timer#*.}
		local now_int=${now%.*}
		local now_frac=${now#*.}

		(( elapsed_ms = (now_int - start_int) * 1000 + (10#${now_frac:0:3} - 10#${start_frac:0:3}) ))
		(( elapsed_ms < 0 )) && (( elapsed_ms += 1000 ))

		unset timer

		# Split into units
		local ms=$(( elapsed_ms % 1000 ))
		local total_s=$(( elapsed_ms / 1000 ))
		local s=$(( total_s % 60 ))
		local m=$(( total_s / 60 ))

		# Format time string
		local timer_show
		if (( total_s == 0 )); then
			timer_show="${ms}ms"
		elif (( m == 0 )); then
			timer_show="${s}.$(printf '%03d' $ms)s"
		else
			timer_show="${m}m ${s}.$(printf '%03d' $ms)s"
		fi

		# Colors
		local code_color="%B%F{red}"
		local err_time_color="%B%F{208}"
		local dim="%F{245}"
		local superdim="%F{240}"

		if [[ $exit_code -eq 0 ]]; then
			RPROMPT="${superdim}[ ${timer_show} ]%f%b"
			return
		fi

		RPROMPT="${dim}[ ERR ${code_color}${exit_code}${dim} ] : ${err_time_color}${timer_show}%f%b"
	fi
}


PROMPT="%F{green}%B%n@%m%b%f:%F{blue}%B%~%b%f%(#.#.$) " # bash theme
# PROMPT="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%m %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

#bindkey '^F' history-incremental-search-backward
bindkey '^F' fzf-history-widget

alias erc="$EDITOR    ~/.zshrc"
alias eenv="$EDITOR   ~/.zshenv"
alias hc=': > "$HISTFILE"; fc -p'

alias -g ...="../.."
alias -g R=" | rg"
alias -g L=" | less"
alias -g C=" | pbcopy"
alias -g P="pbpaste"
alias -g NE="2 > /dev/null"
alias -g DN=" > /dev/null"
alias -g NULL=" > /dev/null 2>&1"
alias -s json="jless"l

# https://www.masterzen.fr/2009/04/19/in-love-with-zsh-part-one/
# ============================================================================================================


# ============================================================================================================
# When you open a new terminal window on macOS Zsh, the order is:
# ~/.zshenv → ~/.zprofile → ~/.zshrc → (then ~/.zlogin, if exists) --- at-exit ---> .zlogout  (then ~/.zlogin, if exists)

function zsh() {
	if [ -f "$HOME/.zshenv" ]; then
		# THIS FILE WILL CONTAIN ALL THE PRIVATE CONFIGURATION, WHICH I CAN'T PUBLISH AND GET UP
		source "$HOME/.zshenv"

		#THIS FILE WILL CONTAIN ALL THE ENVIRONMENT VARIABLE AND THE CONFIGURATION WHICH I COMFORTABLE TO PUBLISH ON GITHUB
		# source "$HOME/.config/zsh/zshenv-footer.zsh"
	fi

	if [ -f "$HOME/.zprofile" ]; then
		source "$HOME/.zprofile"
	fi

	if [ -f "$HOME/.config/zsh/alias.zsh" ]; then
		source "$HOME/.config/zsh/alias.zsh"
	fi
}
# ============================================================================================================

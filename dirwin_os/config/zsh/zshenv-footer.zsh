# printf "Importing \t %s \n" "$HOME.config/zsh/zshenv-footer.zsh"

# echo "[ -f "$HOME/.config/zsh/zshenv-footer.zsh" ] && source "$HOME/.config/zsh/zshenv-footer.zsh"" >> ~/.zshenv

# SUPPORTING SOME PRIVATE VARIABLES INSIDE .zshenv =============================
# export ARIA2C_SESSION_TOKEN="go to ~/.zshenv"
# export GITHUB_AUTH_TOKEN="go to    ~/.zshenv"     # this pritam_lpu_12416
# ==============================================================================

# -----------------------------------------------
# Helper to safely add to PATH without duplicates
# -----------------------------------------------
typeset -g PATH MANPATH

# Safely add a directory to PATH if it exists and is not already included
export PATH="$PATH"
__PATH_ADD() {
	local dir="$1"
	[[ -n $dir && -d $dir ]] || return
	case ":$PATH:" in
	*":$dir:"*) ;;                   # already present → do nothing
	*) PATH="${PATH:+$PATH:}$dir" ;; # append with colon only if PATH is non-empty
	esac
}

# Safely add a directory to MANPATH if it exists and is not already included
export MANPATH="$MANPATH"
# echo $MANPATH
__MANPATH_ADD() {
	local dir="$1"

	# directory must exist
	[[ -n $dir && -d $dir ]] || return

	# If MANPATH is empty -> add with trailing colon to keep system defaults
	if [[ -z $MANPATH ]]; then
		MANPATH="$dir:"
		return
	fi

	# Remove trailing ':' to prevent "::"
	MANPATH="${MANPATH%%:}"

	# Add only if not already present
	case ":$MANPATH:" in
	*":$dir:"*) ;; # already exists
	*) MANPATH="$MANPATH:$dir" ;;
	esac
}

autoload -Uz colors && colors

# sudo curl -L https://curl.se/ca/cacert.pem -o /usr/local/etc/ca-certificates/cert.pem
export SSL_CERT_FILE="/usr/local/etc/ca-certificates/cert.pem"

# FOR THE DEVELOPER===========================================================================================
export CXX="/usr/bin/clang++"
export CC="/usr/bin/clang"
export PREFIX="$HOME/.local"
export Boost_DIR="/usr/local/boost-1.87.0"


# FOR PYTHON ======
__PATH_ADD "/Library/Frameworks/Python.framework/Versions/3.14/bin"
__MANPATH_ADD "/Library/Frameworks/Python.framework/Versions/3.14/share/man"
__PATH_ADD "$HOME/Library/Python/3.14/bin"
__PATH_ADD "$HOME/Library/Python/3.14/share/man"
fpath=($fpath "$HOME/Library/Python/3.14/share/zsh/site-functions")

# __PATH_ADD "$HOME/Library/Python/3.9/bin"
# __PATH_ADD "$HOME/Library/Python/3.9/share/man"
# fpath=($fpath "$HOME/Library/Python/3.9/share/zsh/site-functions")

# FOR DEVELOPMENT LIBRARIES ==========
__PATH_ADD "/usr/local/big_library-bin"
export CMAKE_GENERATOR=Ninja
export DYLD_LIBRARY_PATH="/usr/local/lib:$DYLD_LIBRARY_PATH"
export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH"
export CMAKE_PREFIX_PATH="/usr/local/lib/cmake:$CMAKE_PREFIX_PATH"
export CMAKE_INSTALL_PATH="$PREFIX"
export CPP_LIB_DIR="/usr/local/big_library"

# FOR DEVELOPMENT LIBRARIES ==========
__PATH_ADD "$HOME/.local/bin"
__PATH_ADD "$HOME/.local/github-releases-binary"
__MANPATH_ADD "$HOME/.local/share/man"
fpath=($fpath "$HOME/.local/share/zsh/site-functions")

# export EDITOR="hx"
export EDITOR="nvim"                               # $EDITOR use nvim in terminal
# export VISUAL="zed --wait"                         # $VISUAL use zed  in GUI mode
export DOT_FILE="$HOME/Developer/git_repository/my_dotfile/dirwin_os"
export TERM="xterm-256color"                      # getting proper colors
# ============================================================================================================

# Linux LS color theme =======================================================================================
# Allow Zed editor to run as root
export ZED_ALLOW_ROOT=true

# Enable colored diagnostics in CMake
export CMAKE_COLOR_DIAGNOSTICS=true

# Enable colored output for ls
export CLICOLOR=true

# Set default pager to less
export PAGER="less"

# Configure less for raw control characters and case-insensitive search
export LESS="-Rir -j5"

# Define ls color scheme
export LSCOLORS="ExFxBxDxCxegedabagacad"
# ============================================================================================================

# FZF & SK Configuration ==========================================================================================
# export SKIM_DEFAULT_COMMAND="fd --type f || git ls-tree -r --name-only HEAD || rg --files || find ."

# Set up FZF default options for appearance and layout
# export FZF_DEFAULT_OPTS="--height 50% --layout=default --border --color=hl:#2dd4bf"
export FZF_DEFAULT_OPTS="--layout=reverse --exact --border=bold --border=rounded --margin=3% --color=dark"

# Configure FZF previews for file selection
# export FZF_CTRL_T_OPTS="--preview 'bat --color=always -n --line-range :500 {}'"

# Uncomment the following line to enable directory previews with eza
# export FZF_ALT_C_OPTS="--preview 'eza --icons=always --tree --color=always {} | head -200'"

# Uncomment to enable FZF preview for tmux
# export FZF_TMUX_OPTS=" -p90%,70% "
# ============================================================================================================

# Red & Green Man Page Theme (2025 edition) ==================================================================
# Bold text & headings → Bright green (function names, section titles)
export LESS_TERMCAP_md=$'\e[01;38;5;82m' # vivid neon green

# Start blinking (rarely used) → Bright red (makes it actually noticeable)
export LESS_TERMCAP_mb=$'\e[05;38;5;196m' # blinking bright red

# Search highlight bar / standout → White text on red background (super visible)
export LESS_TERMCAP_so=$'\e[01;97;41m' # bright white on red

# End standout
export LESS_TERMCAP_se=$'\e[0m'

# Underlined text (options, arguments, --flags) → Bright red underline
export LESS_TERMCAP_us=$'\e[04;38;5;196m' # bright red underline

# End underline
export LESS_TERMCAP_ue=$'\e[0m'

# End all bold/attributes
export LESS_TERMCAP_me=$'\e[0m'
# ============================================================================================================

# NNN File Manager Integration ===============================================================================
# Define NNN plugins for various tasks
NNN_PLUG_PERSONAL+="a:personal/adb_push;"
NNN_PLUG_PERSONAL+="r:personal/fix_ugly_name;"
NNN_PLUG_PERSONAL+="p:personal/ffplay_playlist;"
NNN_PLUG_PERSONAL+="e:personal/fetch_metadata;"
NNN_PLUG_PERSONAL+="q:personal/perview_with_quicklook;"

NNN_PLUG+='z:!&zed "$nnn" *;'
NNN_PLUG+='c:fzcd;'
NNN_PLUG+='o:!|otool -L "$nnn";'
NNN_PLUG+='f:!&ffplay -loop -1 -sn -loglevel level+warning -seek_interval 5 "$nnn";'
NNN_PLUG+='m:!mpv "$nnn"   *   *;'

NNN_PLUG+=$NNN_PLUG_PERSONAL
export NNN_PLUG

# Set NNN color scheme
export NNN_COLORS="5236"
# Set default opener for files
export NNN_OPENER="/usr/bin/open"
# Define NNN options
export NNN_OPTS="AUBRNEdefag"
# Define NNN selection file
export NNN_SEL="$TMPDIR/nnn.sel"
# Define NNN temporary file for last directory
export NNN_TMPFILE="$TMPDIR/nnn.lastd"
# Define NNN FIFO file
export NNN_FIFO="$TMPDIR/nnn.fifo"
# Define NNN trash command
export NNN_TRASH="/usr/bin/trash"
# Define NNN help file
export NNN_HELP="cat $DOT_FILE/../global/nnn_help.txt"
# Define regex for archive file extensions
export NNN_ARCHIVE="\\.(7z|a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|rar|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)$"
# Define NNN file colors
export NNN_FCOLORS="c1e2272e006033f7c6d6abc4"

export LC_ALL="en_US.UTF-8"

# cd ON QUIT WITH NNN FILE MANGER
function n() {
	[ "${NNNLVL:-0}" -eq 0 ] || {
		echo "nnn is already running"
		return
	}

	command nnn "$@"

	[ ! -f "$NNN_TMPFILE" ] || {
		. "$NNN_TMPFILE"
	}
}
# ============================================================================================================

# GPG CONFIGURATION ==========================================================================================
# Set GPG_TTY for signing commits with GPG
export GPG_TTY=$(tty)
# ============================================================================================================

### SETTING OTHER ENVIRONMENT VARIABLES ======================================================================
if [ -z "$XDG_CONFIG_HOME" ] ; then
    export XDG_CONFIG_HOME="$HOME/.config"
fi

if [ -z "$XDG_DATA_HOME" ] ; then
    export XDG_DATA_HOME="$HOME/.local/share"
fi

if [ -z "$XDG_CACHE_HOME" ] ; then
    export XDG_CACHE_HOME="$HOME/Library/Caches"
fi
# ============================================================================================================


if [ -f "$HOME/.config/zsh/functions.sh" ]; then
	source "$HOME/.config/zsh/functions.sh"
fi

source ~/.config/broot/launcher/bash/br

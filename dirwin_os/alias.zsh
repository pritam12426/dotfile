# --- Fix Apple verification issue for certain libraries ---
# Uncomment and use the following command to fix the "Apple could not verify" issue for specific libraries.
# sudo install_name_tool -change @rpath/libglfw.3.dylib \
# /usr/local/big_library/glfw-3.4/lib/libglfw.3.4.dylib

# --- General utility commands ---
# Use gpg for encryption
# gpg -c
# Use sips for working with image metadata
# sips -g all

# --- Remove quarantine attribute from files ---
# Use this command to remove the quarantine attribute from a file.
# sudo xattr -rd com.apple.quarantine <file>

# --- Environment variables ---
# Allow Zed editor to run as root
export ZED_ALLOW_ROOT=true
# Set CMake generator to Ninja
export CMAKE_GENERATOR=Ninja
# Enable colored diagnostics in CMake
export CMAKE_COLOR_DIAGNOSTICS=true

# --- Linux LS color theme ---
# Enable colored output for ls
export CLICOLOR=true
# Set default pager to less
export PAGER="less"
# Configure less for raw control characters and case-insensitive search
export LESS="-Rir"
# Define ls color scheme
export LSCOLORS="ExFxBxDxCxegedabagacad"
# Use this var for use proxy

# --- Directory navigation aliases ---
alias lldir="cd \` sk < $LIBS_DIR/index.txt \`"        # Navigate to directory from index file
alias cpdir="cd /Users/pritam/Developer/cxx_lang"      # Navigate to C++ development directory
alias cdir="cd /Users/pritam/Developer/c_lang"         # Navigate to C development directory
alias gdir="cd /Users/pritam/Developer/git_repository" # Navigate to Git repository directory
alias bdir="cd /Users/pritam/.local/bin"               # Navigate to local binaries directory

# --- Firefox aliases ---
alias firefox="/Applications/Firefox.app/Contents/MacOS/firefox"                    # Launch Firefox
alias firefox-p="/Applications/Firefox.app/Contents/MacOS/firefox --private-window" # Launch Firefox in private mode

# --- NNN file manager configuration ---
# Define NNN plugins for various tasks
NNN_PLUG_PERSONAL+="a:personal/adb_push;"
NNN_PLUG_PERSONAL+="r:personal/fix_ugly_name;"

NNN_PLUG+='z:!&zed "$nnn" *;'
NNN_PLUG+='c:fzcd;'
NNN_PLUG+='e:!|exiftool "$nnn";'
NNN_PLUG+='o:!|otool -L "$nnn";'
# NNN_PLUG+='p:!ffplay  -loop -1 -sn -loglevel level+warning -seek_interval 5 "$nnn" *;'
NNN_PLUG+='f:!&ffplay -loop -1 -sn -loglevel level+warning -seek_interval 5 "$nnn";'
NNN_PLUG+='q:!qlmanage -p "$nnn"*;'
NNN_PLUG+='m:!&mpv "$nnn";'

NNN_PLUG+=$NNN_PLUG_PERSONAL
export NNN_PLUG

# Set NNN color scheme
export NNN_COLORS="5236"
# Set default opener for files
export NNN_OPENER="/usr/bin/open"
# Define NNN options
export NNN_OPTS="AUBRNEdefagx"
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

# ------------ FZF Configuration ------------
# Set up FZF default options for appearance and layout
export FZF_DEFAULT_OPTS="--height 50% --layout=default --border --color=hl:#2dd4bf"

# Configure FZF previews for file selection
export FZF_CTRL_T_OPTS="--preview 'bat --color=always -n --line-range :500 {}'"
# Uncomment the following line to enable directory previews with eza
# export FZF_ALT_C_OPTS="--preview 'eza --icons=always --tree --color=always {} | head -200'"

# Uncomment to enable FZF preview for tmux
# export FZF_TMUX_OPTS=" -p90%,70% "
# --------------------------------------------

# ------------ Man Page Colors (static) ------------
# Green for blinking/bold text (mb, md)
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'

# Yellow for standout text (so)
export LESS_TERMCAP_so=$'\e[1;33m'

# Reset standout/bold (se)
export LESS_TERMCAP_se=$'\e[0m'

# Red + underline for US
export LESS_TERMCAP_US=$'\e[1;4;31m'

# Reset all (me)
export LESS_TERMCAP_me=$'\e[0m'
# -----------------------------------------

# ------------ LS and File Management Aliases ------------
# Enable colorized output for common commands
alias ls="command ls --color=auto"
alias grep="command grep --color=auto"
alias fgrep="command fgrep --color=auto"
alias egrep="command egrep --color=auto"

# Common ls shortcuts
alias ll="command ls -lh"                    # List with human-readable sizes
alias la="command ls -A"                     # List all files, excluding . and ..
alias l="command ls -lAh"                    # Detailed list including hidden files
alias lh="command ls -d --color=auto .[^.]*" # List hidden directories

# File operation aliases with safety prompts
alias cp="command cp -ip" # Copy with interactive prompt
alias mv="command mv -i"  # Move with interactive prompt
alias du="command du -h"  # Display disk usage in human-readable format
# ---------------------------------------------------------

# ------------ NeoVim and System Aliases ------------
# Shortcuts for editing configuration files
alias enrc="$EDITOR ~/.config/nvim/init.lua"         # Edit NeoVim config
alias eza="$EDITOR $DOT_FILE/dirwin_os/alias.zsh"    # Edit alias file
alias efz="$EDITOR $DOT_FILE/dirwin_os/functions.sh" # Edit alias file


# System utility aliases
alias o="command open ."                                                                        # Open current directory in Finder
alias c.="command code ."                                                                       # Open current directory in VS Code
alias z.="command zed ."                                                                        # Open current directory in Zed editor
alias live-server="command live-server -H 127.0.0.1 -p 8085 -o"                                 # Start live server
alias tree="command tre -a"                                                                     # Display directory tree
alias python="command python3 -u"                                                               # Use Python 3 as default
alias nq="command networkquality -s"                                                            # Check network quality
alias hc="command cat /dev/null > ~/.zsh_history"                                               # Clear ZSH history
alias search="command ls -AF | grep -i"                                                         # Search files in current directory
alias sayy="command pbpaste | command say -i"                                                   # Convert clipboard text to speech
alias per="command find . -type f -exec chmod 644 {} \; ; find . -type d -exec chmod 755 {} \;" # Fix permissions
alias seelog="command tail -n 1 -f -- "                                                         # Tail logs
alias exportlib="source $LIBS_DIR/env"                                                          # Load library environment
alias zzz="bsdtar -xf "                                                                         # Extract archives
alias exportembdlib="source $DOT_FILE/global/embedded/embedded-ENV.sh"                          # Load embedded environment
alias ninja-tree="command ninja -t targets "                                                    # Display Ninja build targets
alias chownroot="command sudo chown -R root:wheel"                                              # Change ownership to root
alias chownself="command sudo chown -R pritam:staff"                                            # Change ownership to user
alias bk="open 'http://localhost:8080/'; shiori server"                                         # Open bookmarks server
alias wget="command wget --no-check-certificate -c"                                             # Download with wget
alias off="pmset displaysleepnow"                                                               # Turn off display
alias soff="pmset sleepnow"                                                                     # Put system to sleep
alias zed-editor="eval \"export EDITOR='zed --wait'\""                                          # setting EDITOR = zed
alias rclone-gui="rclone rcd --rc-web-gui --rc-no-auth"                                         # setting EDITOR = zed
alias find-zombies="ps -axo pid,ppid,stat,command | grep -w Z+"                                 # Find zombies + parent PID

alias aria2-reload="launchctl unload ~/Library/LaunchAgents/com.user.aria2.plist &&
				    launchctl load ~/Library/LaunchAgents/com.user.aria2.plist"
# --------------------------------------------------

# ------------ NNN File Manager Integration ------------
export LC_ALL="en_US.UTF-8"

# Launch nnn and handle last directory
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
# -------------------------------------------------------

# ------------ EXIFTool Aliases ------------
alias exf="command exiftool -sort -P -overwrite_original_in_place" # Modify metadata
alias exfcpy="exf -TagsFromFile"                                   # Copy metadata from another file
# ------------------------------------------

# ------------ Miscellaneous Functions ------------
# Pretty-print media file metadata using ffprobe and jq
function hhhh() {
	command ffprobe -v quiet -print_format json -show_format -show_streams $@ | jq
}

# Copy absolute file path to clipboard
function pc {
	local file="${1:-}"
	if [[ $file != /* ]]; then
		file="$PWD/$file"
	fi
	local abs_path=$(realpath "$file")
	# Escape special characters in the path
	abs_path=$(printf "%q" "$abs_path")
	printf "$abs_path" | pbcopy
	# echo -e "\033[1;36m==> [ \033[1;33mCopy to clipboard: \033[1;35m$abs_path\033[1;36m ] <==\033[0m"
}


# ------------ GPG Configuration --------------
# Set GPG_TTY for signing commits with GPG
export GPG_TTY=$(tty)
# ---------------------------------------------

# ------------ IP and MAC Address Aliases -----
# Fetch public IP information
alias ipinfo="command curl https://raw.githubusercontent.com/jarun/nnn/master/plugins/ipinfo 2> /dev/null | sh | $PAGER"

# Fetch WAN (public) IP address
alias wanip="command curl -s http://checkip.dyndns.org/ | sed 's/[a-zA-Z<>/ :]//g'"

# Fetch MAC address of the computer
alias macid="command ifconfig -a | grep ether | grep -oE '([0-9][0-9]:[a-z][0-9]:[a-z][a-z]:[a-z][a-z]:[0-9][0-9]:[0-9][0-9])' | head -n 1"

# Fetch LAN (local) IP address
alias lanip="command ifconfig -a | egrep -A 7 '^en0' | grep inet | grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])' | head -n 1"
# ---------------------------------------------

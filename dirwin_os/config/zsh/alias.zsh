# printf "Importing \t %s \n" "$HOME/.config/zsh/alias.zsh"


# --- Fix Apple verification issue for certain libraries ---
# Uncomment and use the following command to fix the "Apple could not verify" issue for specific libraries.
# sudo install_name_tool -change @rpath/libglfw.3.dylib \
# /usr/local/big_library/glfw-3.4/lib/libglfw.3.4.dylib

# --- General utility commands ---
# Use gpg for encryption
# gpg -c           # quick encryption with temp password
# gpg  --encrypt --recipient <email>   <file>
# gpg --decrypt  <file>

# gpg  -er                   <email>   <file>
# gpg -d  <file>


# Use sips for working with image metadata
# sips -g all

# --- Remove quarantine attribute from files ---
# Use this command to remove the quarantine attribute from a file.
# sudo xattr -rd com.apple.quarantine <file>


# --- Directory navigation aliases ---
alias lldir="cd \` sk < $LIBS_DIR/index.txt \`"        #navigate To Directory From Index File
alias cpdir="cd /Users/pritam/Developer/cxx_lang"      # Navigate To C++ Development Directory
alias cdir="cd /Users/pritam/Developer/c_lang"         # Navigate To C Development Directory
alias gdir="cd /Users/pritam/Developer/git_repository" # Navigate To Git Repository Directory
alias bdir="cd /Users/pritam/.local/bin"               # Navigate To Local Binaries Directory
alias .dir="cd $DOT_FILE"                              # Navigate To Local Dotfilf Directory

# --- Firefox aliases ---
alias firefox="/Applications/Firefox.app/Contents/MacOS/firefox"                    # Launch Firefox
alias firefox-p="/Applications/Firefox.app/Contents/MacOS/firefox --private-window" # Launch Firefox in private mode

alias firefox-clean="rm -fv ~/Library/Application\ Support/Firefox/Profiles/*/formhistory.sqlite\
					 rm -fv ~/Library/Application\ Support/Firefox/Profiles/*/formhistory.dat"
# ----------------------------------------------------------


# ------------ NNN File Manager Integration ------------
# Define NNN plugins for various tasks
NNN_PLUG_PERSONAL+="a:personal/adb_push;"
NNN_PLUG_PERSONAL+="r:personal/fix_ugly_name;"
NNN_PLUG_PERSONAL+="p:personal/ffplay_playlist;"

NNN_PLUG+='z:!&zed "$nnn" *;'
NNN_PLUG+='c:fzcd;'
NNN_PLUG+='e:!|exiftool "$nnn";'
NNN_PLUG+='o:!|otool -L "$nnn";'
NNN_PLUG+='f:!&ffplay -loop -1 -sn -loglevel level+warning -seek_interval 5 "$nnn";'
NNN_PLUG+='q:!echo "qlmanage -p $nnn" >&2 && qlmanage -p "$nnn" > /dev/null*;'
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
export NNN_HELP="cat $DOT_FILE/global/nnn_help.txt"
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
# -------------------------------------------------------


# ------------ LS and File Management Aliases ------------
# Enable colorized output for common commands
alias ls="command ls --color=auto"
alias grep="command grep --color=auto"
alias fgrep="command fgrep --color=auto"
alias egrep="command egrep --color=auto"
alias rsync="command rsync -vrPlu"

# Common ls shortcuts
alias ls="ls -GFh"
alias ll="command ls -GFhl"                       # List with human-readable sizes
alias la="command ls -AGFh"                       # List all files, excluding . and ..
alias l="command ls -lAhFG"                       # Detailed list including hidden files
alias lh="command ls -lhGFd --color=auto .[^.]*"  # List hidden directories

# File operation aliases with safety prompts
alias cp="command cp -ip" # Copy with interactive prompt
alias mv="command mv -i"  # Move with interactive prompt
alias du="command du -h"  # Display disk usage in human-readable format

# https://www.masterzen.fr/2009/04/19/in-love-with-zsh-part-one/
alias -g ...="../.."
alias -s php=nano
# ---------------------------------------------------------


# ------------ NeoVim and System Aliases ------------
# Shortcuts for editing configuration files
alias enrc="$EDITOR $HOME/.config/nvim/init.lua"          # Edit NeoVim config
alias enhc="$EDITOR $HOME/.config/helix/config.toml"      # Edit helix config
alias eza="$EDITOR  $HOME/.config/zsh/alias.zsh"          # Edit alias file
alias efz="$EDITOR  $HOME/.config/zsh/functions.sh"       # Edit alias file
# ---------------------------------------------------------


# System utility aliases ------------------------------
alias o="command open ."                                                                           # Open current directory in Finder
alias c.="command code ."                                                                          # Open current directory in VS Code
alias z.="command zed ."                                                                           # Open current directory in Zed editor
alias live-server="command live-server -H localhost -p 8085 -o"                                    # Start live server
alias tree="command tre -ea"                                                                       # Display directory tree
alias python="command python3 -u"                                                                  # Use Python 3 as default
alias nq="command networkquality -s"                                                               # Check network quality
alias search="command ls -AF | grep -i"                                                            # Search files in current directory
alias sayy="command pbpaste | command say -i"                                                      # Convert clipboard text to speech
alias per="command find . -type f -exec chmod 644 {} \; ; find . -type d -exec chmod 755 {} \;"    # Fix permissions
alias seelog="command tail -n 1 -f -- "                                                            # Tail logs
alias exportlib="source $LIBS_DIR/env"                                                             # Load library environment
alias zzz="bsdtar -xf "                                                                            # Extract archives
alias exportembdlib="source $DOT_FILE/global/embedded/embedded-ENV.sh"                             # Load embedded environment
alias ninja-tree="command ninja -t targets "                                                       # Display Ninja build targets
alias chownroot="command sudo chown -R root:wheel"                                                 # Change ownership to root
alias chownself="command sudo chown -R pritam:staff"                                               # Change ownership to user
alias bk="open 'http://localhost:8080/' &&bshiori server"                                          # Open bookmarks server
alias wget="command wget -c"                                                                       # Download with wget
alias off="pmset displaysleepnow"                                                                  # Turn off display
alias soff="pmset sleepnow"                                                                        # Put system to sleep
alias zed-editor="eval \"export EDITOR='zed --wait'\""                                             # setting EDITOR = zed
alias rclone-gui="rclone rcd --rc-web-gui --rc-no-auth"                                            # setting EDITOR = zed
alias find-zombies="ps -axo pid,ppid,stat,command | grep -w Z+"                                    # Find zombies + parent PID

alias aria2-reload="launchctl unload ~/Library/LaunchAgents/com.user.aria2.plist &&
				    launchctl load ~/Library/LaunchAgents/com.user.aria2.plist"
# --------------------------------------------------


# ------------ EXIFTool Aliases ------------
alias exf="command exiftool -sort -P -overwrite_original_in_place" # Modify metadata
alias exfcpy="exf -TagsFromFile"                                   # Copy metadata from another file
# ============================================================================================================

# IP and MAC Address Aliases =================================================================================
# Fetch public IP information
alias ipinfo="command curl https://raw.githubusercontent.com/jarun/nnn/master/plugins/ipinfo 2> /dev/null | sh | $PAGER"

# Fetch WAN (public) IP address
alias wanip="command curl -s http://checkip.dyndns.org/ | sed 's/[a-zA-Z<>/ :]//g'"

# Fetch MAC address of the computer
alias macid="command ifconfig -a | grep ether | grep -oE '([0-9][0-9]:[a-z][0-9]:[a-z][a-z]:[a-z][a-z]:[0-9][0-9]:[0-9][0-9])' | head -n 1"

# Fetch LAN (local) IP address
alias lanip="command ifconfig -a | egrep -A 7 '^en0' | grep inet | grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])' | head -n 1"
# ============================================================================================================

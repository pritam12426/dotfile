# printf "Importing \t %s \n" "$HOME/.config/zsh/alias.zsh"

[[ $- != *i* ]] && return

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
alias lldir="cd \` sk < $CPP_LIB_DIR/index.txt \`"     # Navigate To Directory From Index File
alias cpdir="cd /Users/pritam/Developer/cxx_lang"      # Navigate To C++ Development Directory
alias cdir="cd /Users/pritam/Developer/c_lang"         # Navigate To C Development Directory
alias gdir="cd /Users/pritam/Developer/git_repository" # Navigate To Git Repository Directory
alias bdir="cd /Users/pritam/.local/bin"               # Navigate To Local Binaries Directory
alias .dir="cd $DOT_FILE"                              # Navigate To your dotfiles Directory

# --- Firefox aliases ---
alias firefox="/Applications/Firefox.app/Contents/MacOS/firefox"                    # Launch Firefox
alias firefox-p="/Applications/Firefox.app/Contents/MacOS/firefox --private-window" # Launch Firefox in private mode

alias firefox-clean="rm -fv ~/Library/Application\ Support/Firefox/Profiles/*/formhistory.sqlite ; \
					 rm -fv ~/Library/Application\ Support/Firefox/Profiles/*/formhistory.dat"
# ----------------------------------------------------------


# ------------ LS and File Management Aliases ------------
# Enable colorized output for common commands
alias ls="ls --color=auto -GFh"
alias grep="grep -i --color=auto"
alias fgrep="fgrep -i --color=auto"
alias egrep="egrep -i --color=auto"
alias rsync="rsync -vrPlu"

# Common ls shortcuts
alias ll="ls -l"                       # List with human-readable sizes
alias la="ls -A"                       # List all files, excluding . and ..
alias l="ls -lA"                       # Detailed list including hidden files
alias lh="ls -ld --color=auto .[^.]*"  # List hidden directories

# File operation aliases with safety prompts
alias cp="cp -ip"        # Copy with interactive prompt
alias mv="mv -vi"        # Move with interactive prompt
alias du="du -hs"        # Display disk usage in human-readable format
# ---------------------------------------------------------


# ------------ NeoVim and System Aliases ------------
# Shortcuts for editing configuration files
alias enrc="$EDITOR $HOME/.config/nvim/init.lua"          # Edit NeoVim config
alias enhc="$EDITOR $HOME/.config/helix/config.toml"      # Edit helix config
alias eza="$EDITOR  $HOME/.config/zsh/alias.zsh"          # Edit alias file
alias efz="$EDITOR  $HOME/.config/zsh/functions.sh"       # Edit functon file
alias .e="edot"                                           # Edit functon file
# ---------------------------------------------------------


# System utility aliases ------------------------------
alias o="open ."                                                                           # Open current directory in Finder
alias c.="code ."                                                                          # Open current directory in VS Code
alias z.="zed ."                                                                           # Open current directory in Zed editor
# alias live-server="open 'http://localhost:8085/' && python3 -m http.server 8085"           # Start live server with python
alias live-server="live-server -H localhost -p 8085 -o"                                    # Start live server with rust binary
alias tre="tre -a"                                                                         # Display directory tree
# alias python="python3 -u"                                                                  # Use Python 3 as default
alias envpath="envpath | less"                                                             # Print the environment variable in prettiest form
alias nq="networkquality -s"                                                               # Check network quality
alias search="command ls -AF | grep -i"                                                    # Search files in current directory
alias sayy="pbpaste | command say -i"                                                      # Convert clipboard text to speech
alias per="find . -type f -exec chmod 644 {} \; ; find . -type d -exec chmod 755 {} \;"    # Fix permissions
alias seelog="tail -n 1 -f --"                                                             # Tail logs
alias exportlib="source $LIBS_DIR/env"                                                     # Load library environment
alias zzz="bsdtar -vxf"                                                                    # Extract archives
alias exportembdlib="source $DOT_FILE/../global/embedded/embedded-ENV.sh"                  # Load embedded environment
alias ninja-tree="ninja -t targets"                                                        # Display Ninja build targets
alias chownroot="sudo chown -R root:wheel"                                                 # Change ownership to root
alias chownself="sudo chown -R pritam:staff"                                               # Change ownership to user
alias bk="open 'http://localhost:8080/' && shiori server"                                  # Open bookmarks server
alias wget="wget -c"                                                                       # Download with wget
alias off="pmset displaysleepnow"                                                          # Turn off display
alias soff="pmset sleepnow"                                                                # Put system to sleep
alias zed-editor="eval \"export EDITOR='zed --wait'\""                                     # setting EDITOR = zed
alias gui-rclone="rclone rcd --rc-web-gui --rc-no-auth"                                    # configure our rclone with webui
#alias gui-docker=""                                                                        # configure our docker with webui
alias eget="eget --download-only "                                                         # Tell eget to only download the System wise release zip file
alias find-zombies="ps -axo pid,ppid,stat,command | grep -w Z+"                            # Find zombies + parent PID
alias aria2="aria2c --dir . --summary-interval=10"                                         # aria2c download file in $PWD

alias reload-aria2c="launchctl unload ~/Library/LaunchAgents/com.user.aria2.plist &&
				    launchctl load ~/Library/LaunchAgents/com.user.aria2.plist"
# --------------------------------------------------

# ------------ EXIFTool Aliases ------------
alias exf="exiftool -sort -P -overwrite_original_in_place" # Modify metadata
alias exfcpy="exf -TagsFromFile"                           # Copy metadata from another file
# ============================================================================================================

# IP and MAC Address Aliases =================================================================================
# Fetch public IP information
alias ipinfo="curl https://raw.githubusercontent.com/jarun/nnn/master/plugins/ipinfo 2> /dev/null | sh | $PAGER"

# Fetch WAN (public) IP address
alias wanip="curl -s http://checkip.dyndns.org/ | sed 's/[a-zA-Z<>/ :]//g'"

# Fetch MAC address of the computer
alias macid="ifconfig -a | grep ether | grep -oE '([0-9][0-9]:[a-z][0-9]:[a-z][a-z]:[a-z][a-z]:[0-9][0-9]:[0-9][0-9])' | head -n 1"

# Fetch LAN (local) IP address
alias lanip="ifconfig -a | egrep -A 7 '^en0' | grep inet | grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])' | head -n 1"
# ============================================================================================================

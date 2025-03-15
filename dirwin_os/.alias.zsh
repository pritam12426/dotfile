# this file is use for setting up the alias and functions for the zhs shell

#  LINUX LS COLOR THEME
export CLICOLOR=true
export PAGER="less"
export LESS="-Rir"
export LSCOLORS=ExFxBxDxCxegedabagacad


#  NNN FILE MANAGER
export NNN_COLORS="5236"
export NNN_OPTS="RAUNdxe"
export NNN_SEL="/tmp/nnn.sel"
export NNN_TMPFILE="/tmp/nnn.lastd"
export NNN_FIFO="/tmp/nnn.fifo"
export NNN_TRASH="/usr/bin/trash"
# export NNN_OPENER="open"
export NNN_HELP="cat $DOT_FILE/../global/nnn_help.txt"
export NNN_FCOLORS="c1e2272e006033f7c6d6abc4"
export NNN_PLUG='r:-!rrr "$nnn";e:!|exiftool "$nnn";p:!ffplay "$nnn";q:!qlmanage -p "$nnn"'
export NNN_ARCHIVE="\\.(7z|a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|rar|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)$"


#  Color in man page
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # green
# Start bold
export LESS_TERMCAP_md=$(tput bold; tput setaf 2) # green
# Start stand out
export LESS_TERMCAP_so=$(tput bold; tput setaf 3) # yellow
# End standout
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
# Start underline
export LESS_TERMCAP_US=$(tput smul; tput bold; tput setaf 1) # red
# End bold, blinking, standout, underline
export LESS_TERMCAP_me=$(tput sgr0)


#  Some more ls aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ll='ls -lh'
alias la='ls -A'
alias l='ls -lAh'


#  SOME MORE ALIES
alias cp="command cp -ip"
alias mv="command mv -i"
alias du="command du -h"


#  FOR NEO NVIM
alias erc="$EDITOR ~/.zshrc"
alias enrc="$EDITOR ~/.config/nvim/init.vim"
alias eza="$EDITOR ~/.alias.zsh"


#  SYSTEM ALIAS
alias o="command open ."
alias c.="command code ."
alias z.="command zed ."
alias quicklook="command qlmanage -p"
alias tree="command tree -atsh "
alias tre="command tre -ae "
alias which="command which -a "
alias python="command python3 -u "
alias nq="command networkquality -s"
alias hc="command cat /dev/null > ~/.zsh_history"
alias gfind="command ls -AF | grep -i"
alias lh="command ls -AF| grep '^\.'"
alias sayy="command pbpaste | command say -i"
alias per="command find . -type f -exec chmod 644 {} \; && find . -type d -exec chmod 755 {} \;"
alias seelog="tail -n 1 -f -- "

function exportlib() {
	local lib="/usr/local/big_library"
	export CMAKE_PREFIX_PATH="$(find $lib -type 'd' -name 'cmake'     | tr '\n' ':')$CMAKE_PREFIX_PATH"
	export PKG_CONFIG_PATH="$(  find $lib -type 'd' -name 'pkgconfig' | tr '\n' ':')$PKG_CONFIG_PATH"
	# export PATH="$(             find $lib -type 'd' -name 'bin'       | tr '\n' ':')$PATH"
	export MANPATH="$(             find $lib -type 'd' -name 'man'       | tr '\n' ':')$MANPATH"
	export DYLD_LIBRARY_PATH="$(find $lib -type 'd' -name 'lib'       | tr '\n' ':')$DYLD_LIBRARY_PATH"
}

function _make_() {
	command make -qp | awk -F':' '/^[a-zA-Z0-9][^$#\/\t=]*:([^=]|$)/ {split($1,A,/ /);for(i in A)print A[i]}' | command sort -u
}

function ss() {
	screencapture -w "./Img-$(date +"%Y-%b-%d_at_%H.%M.%S").png"
}

function sss() {
    screencapture -s "./Img-$(date +"%Y-%b-%d_at_%H.%M.%S").png"
}


#  EXIFTOOL
alias exf="command exiftool -sort -P -overwrite_original_in_place"
alias exfcpy="exf -TagsFromFile"


#  YT-DLP
alias yt-dlpx="command yt-dlp -o '%(title)s.%(ext)s' -f 'best/bestvideo*+bestaudio*'"
alias yt-dlpp="command yt-dlp -o '~/Downloads/yt_dlp/youtube_playlist/%(playlist)s-%(uploader)s/%(playlist_index)s-%(title)s.%(ext)s'"
alias short="command yt-dlp --ignore-config  --config-locations '~/.config/yt-dlp/you-tube_short_vidoe.txt'"
alias insta="command yt-dlp --ignore-config  --config-locations '~/.config/yt-dlp/instagram.txt'"

export LC_ALL="en_US.UTF-8"
#  NNN FILE MANGER CD ON QUIT
function n () {
	[ "${NNNLVL:-0}" -eq 0 ] || {
		echo "nnn is already running"
		return
	}

	command n "$@"

	[ ! -f "$NNN_TMPFILE" ] || {
		. "$NNN_TMPFILE"
	}
}

function hhhh() {
	command ffprobe -v quiet -print_format json -show_format -show_streams $@ | jq
}


function pathcp {
	local file="${1:-}"
	if [[ ! $file = /* ]]; then
		file="$PWD/$file"
	fi
	printf "$(realpath "$file")" | pbcopy
}


function diff {
	command diff -u --color=always $@ | less -r -;
}


function clanginit {
	if [[ $# -eq 0 ]]; then
		echo "Usage: $1 <c cxx c++>"
		return 1
	fi

	lower_input=$(echo "$1" | tr '[:upper:]' '[:lower:]')

	case "$lower_input" in
	c)
		COMMAND="   cp -rp $DOT_FILE/../global/vscode/C                $PWD/.vscode"
		COMMAND+="; cp -p  $DOT_FILE/../global/vscode/clangd-c         $PWD/.clangd"
		COMMAND+="; cp -p  $DOT_FILE/../global/vscode/clang-format     $PWD/.clang-format"
		COMMAND+="; cp -p  $DOT_FILE/../global/vscode/clang-tidy       $PWD/.clang-tidy"
		COMMAND+="; cp -p  $DOT_FILE/../global/vscode/CMakeLists.txt   $PWD/CMakeLists.txt"
		COMMAND+="; cp -p  $DOT_FILE/../global/vscode/Makefile         $PWD/Makefile"
		;;
	c++)
		COMMAND="   cp -rp $DOT_FILE/../global/vscode/CXX              $PWD/.vscode"
		COMMAND+="; cp -p  $DOT_FILE/../global/vscode/clangd-cxx       $PWD/.clangd"
		COMMAND+="; cp -p  $DOT_FILE/../global/vscode/clang-format     $PWD/.clang-format"
		COMMAND+="; cp -p  $DOT_FILE/../global/vscode/clang-tidy       $PWD/.clang-tidy"
		COMMAND+="; cp -p  $DOT_FILE/../global/vscode/CMakeLists.txt   $PWD/CMakeLists.txt"
		COMMAND+="; cp -p  $DOT_FILE/../global/vscode/Makefile         $PWD/Makefile"
		;;
	cxx)
		COMMAND="   cp -rp  $DOT_FILE/../global/vscode/c++/* ."
		COMMAND+="; cp -rp  $DOT_FILE/../global/vscode/c++/.* ."
		;;
	*)
		echo "Unsupported: <c cxx c++>: $1"
		return 1
		;;
	esac

    echo $COMMAND | tr ';' '\n'
	eval $COMMAND
    touch input.txt

	mkdir -p src test
}



#  FOR COMMIT THE COMMIT WITH GPG
export GPG_TTY=$(tty)

#  IP / MACID ALIAS AND FUNCTIONS
alias ipinfo="command curl https://raw.githubusercontent.com/jarun/nnn/master/plugins/ipinfo 2> /dev/null | sh | $PAGER"
alias wanip="command curl -s http://checkip.dyndns.org/ | sed 's/[a-zA-Z<>/ :]//g'"  # will print the loal ipv4 in termial.
alias macid="command ifconfig -a | grep ether | grep -oE '([0-9][0-9]:[a-z][0-9]:[a-z][a-z]:[a-z][a-z]:[0-9][0-9]:[0-9][0-9])' | head -n 1"  # will print the return the macid of the computer
alias lanip="command ifconfig -a | egrep -A 7 '^en0' | grep inet | grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])' | head -n 1"

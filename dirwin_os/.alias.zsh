# this file is use for setting up the alias and functions for the zhs shell

#  LINUX LS COLOR THEME
export CLICOLOR=true
export PAGER="less"
export LESS="-Rir"
export LSCOLORS=ExFxBxDxCxegedabagacad


#  NNN FILE MANAGER
NNN_PLUG='r:-!rrr "$nnn"*;'
NNN_PLUG+='e:!|exiftool "$nnn";'
NNN_PLUG+='p:!ffplay "$nnn"*;'
NNN_PLUG+='q:!qlmanage -p "$nnn"'
export NNN_PLUG

export NNN_COLORS="5236"
export NNN_OPENER="/usr/bin/open"
# export NNN_ORDER=""
export NNN_OPTS="ARUNdxe"
export NNN_SEL="/tmp/nnn.sel"
export NNN_TMPFILE="/tmp/nnn.lastd"
export NNN_FIFO="/tmp/nnn.fifo"
export NNN_TRASH="/usr/bin/trash"
export NNN_HELP="cat $DOT_FILE/../global/nnn_help.txt"
export NNN_FCOLORS="c1e2272e006033f7c6d6abc4"
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
alias wget="command wget --no-check-certificate "
alias sudo="command sudo -E"
alias c.="command code ."
alias z.="command zed ."
alias quicklook="command qlmanage -p"
alias tree="command tree -atsh "
# alias tre="command tre -ae "
alias which="command which -a "
alias python="command python3 -u "
alias nq="command networkquality -s"
alias hc="command cat /dev/null > ~/.zsh_history"
alias gfind="command ls -AF | grep -i"
alias lh="command ls -AF| grep '^\.'"
alias sayy="command pbpaste | command say -i"
alias per="command find . -type f -exec chmod 644 {} \; && find . -type d -exec chmod 755 {} \;"
alias seelog="command tail -n 1 -f -- "
alias exportlib="source $LIBS_DIR/env"

function _make_() {
	command make -qp | awk -F':' '/^[a-zA-Z0-9][^$#\/\t=]*:([^=]|$)/ {split($1,A,/ /);for(i in A)print A[i]}' | command sort -u
}

# Take screen short with shadow
function ss() {
	screencapture -w "./Screen–short–$(date +"%Y-%b-%d_at_%H.%M.%S").png"
}

# Take screen short without shadow
function sss() {
	screencapture -s "./Screen–short–$(date +"%Y-%b-%d_at_%H.%M.%S").png"
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
		COMMAND="   cp -rp  $DOT_FILE/../global/vscode/c/* ."
		COMMAND+="; cp -rp  $DOT_FILE/../global/vscode/c/.* ."
		;;
	c++)
		COMMAND="   cp -rp  $DOT_FILE/../global/vscode/c++/* ."
		COMMAND+="; cp -rp  $DOT_FILE/../global/vscode/c++/.* ."
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

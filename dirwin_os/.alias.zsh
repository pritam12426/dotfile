#  defaultn write com.apple.dock autohide-time-modifier -float 0.5; defaults write com.apple.dock autohide-delay -float 0; defaults write com.apple.dock showhidden -bool YES; killall Dock
#  LINUX LS COLOR THEME

export CLICOLOR=true
export PAGER="less"
export LESS="-Rir"
export LSCOLORS=ExFxBxDxCxegedabagacad


#  COLORED GCC WARNINGS AND ERRORS
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


#  NNN FILE MANAGER
export NNN_COLORS="5236"
export NNN_OPTS="RAUNdxe"
export NNN_SEL="/tmp/nnn.sel"
export NNN_TMPFILE="/tmp/nnn.lastd"
export NNN_FIFO="/tmp/nnn.fifo"
# export NNN_OPENER="open"
export NNN_HELP="cat $HOME/Developer/git_repositories/my_dotfiles/global/nnn_help.txt"
export NNN_FCOLORS="c1e2272e006033f7c6d6abc4"
export NNN_PLUG='g:gitroot;r:-!rrr "$nnn";e:!|exiftool "$nnn";n:-fixname;s:-oldbigfile'
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


#  SOME MORE ALIES
alias cp="cp -ip"
alias mv="mv -i"
alias du="du -h"


#  FOR NEO NVIM
alias erc="$EDITOR ~/.zshrc"
alias enrc="$EDITOR ~/.config/nvim/init.vim"
alias eza="$EDITOR ~/.alias.zsh"


#  FOR CHANGE DIR()
alias dd=". change_dir"
alias cdd=". change_dir && code ."
alias pdir="cd  $PRESENT_WORKING_PROJECT_DIRECTORY"


#  SYSTEM ALIAS
alias o="open ."
alias vless="$PAGER $DOT_FILE/../global/vim_key.txt"
alias eless="$EDITOR $DOT_FILE/../global/vim_key.txt"
alias c.="code ."
alias m="make"
alias z.="zed ."
alias quicklook="qlmanage -p"
alias tree="tre -e"
alias which="which -sa"
alias python="python3"
alias lfind="alias | grep -i"
alias nq="networkquality -s"
# alias nq="speedtest -u MB/s"
alias hc="cat /dev/null > ~/.zsh_history"
alias gfind="ls -aF --color=auto | grep -i"
alias lh="ls -AF --color=auto | egrep '^\.'"
alias findds="find . -name '.DS_Store'"
alias envpath="echo -e 'PATH\n'$PATH '\n\nMAN\n'$MANPATH | tr ':' '\n' | less"
alias scrcpy_r="scrcpy -r ~/Movies/screen_cast/scrcpy_$(date +'%Y-%m-%d_%H-%M-%S').mp4"
alias per="find . -type f -exec chmod 644 {} \; && find . -type d -exec chmod 755 {} \;"
alias removeds="find . -name '.DS_Store' -exec rm -f {} +"


_make_() {
	make -qp | awk -F':' '/^[a-zA-Z0-9][^$#\/\t=]*:([^=]|$)/ {split($1,A,/ /);for(i in A)print A[i]}' | sort -u
}


#  EXIFTOOL
alias exf="exiftool -sort -P -overwrite_original_in_place"
alias exfcpy="exf -TagsFromFile"
alias exfcpy="exf -TagsFromFile"

hhhh() {
  ffprobe -v quiet -print_format json -show_format -show_streams $@ | jq
}

# alias ffprobe="ffprobe -v quiet -print_format json -show_format -show_streams"


#  YT-DLP
alias yt-dlpwd="yt-dlp -o '%(title)s.%(ext)s'"
alias yt-dlpx="yt-dlp -o '%(title)s.%(ext)s' -f 'best/bestvideo*+bestaudio*'"
alias yt-dlpp="yt-dlp -o '~/Downloads/yt_dlp/youtube_playlist/%(playlist)s-%(uploader)s/%(playlist_index)s-%(title)s.%(ext)s'"
alias short="yt-dlp --ignore-config  --config-locations '~/.config/yt-dlp/you-tube_short_vidoe.txt'"
alias insta="yt-dlp --ignore-config  --config-locations '~/.config/yt-dlp/instagram.txt'"


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

LANG="en_US.UTF-8"
LC_COLLATE="en_US.UTF-8"
LC_CTYPE="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_NUMERIC="en_US.UTF-8"
LC_TIME="en_US.UTF-8"
LC_ALL="en_US.UTF-8"


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

#  FOR COMMIT THE COMMIT WITH GPG
export GPG_TTY=$(tty)


#  IP / MACID ALIAS AND FUNCTIONS
alias ipinfo="curl https://raw.githubusercontent.com/jarun/nnn/master/plugins/ipinfo 2> /dev/null | sh | less"
alias wanip="curl -s http://checkip.dyndns.org/ | sed 's/[a-zA-Z<>/ :]//g'"  # will print the loal ipv4 in termial.
alias macid="ifconfig -a | grep ether | grep -oE '([0-9][0-9]:[a-z][0-9]:[a-z][a-z]:[a-z][a-z]:[0-9][0-9]:[0-9][0-9])' | head -n 1"  # will print the return the macid of the computer
alias lanip="ifconfig -a | egrep -A 7 '^en0' | grep inet | grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])' | head -n 1"

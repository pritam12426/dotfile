# sudo install_name_tool -change @rpath/libglfw.3.dylib \
# /usr/local/big_library/glfw-3.4/lib/libglfw.3.4.dylib \
# this will fix thie Apple could not verify “libsfml-audio.3.0.0.dylib” is free of malware that may harm your Mac or compromise your privacy
# gpg -c
# sips -g all  >> this can be use for working image

# sudo xattr -rd com.apple.quarantine <file>
# this file is use for setting up the alias and functions for the zhs shell

export ZED_ALLOW_ROOT=true
export CMAKE_GENERATOR=Ninja
export CMAKE_COLOR_DIAGNOSTICS=true

#  LINUX LS COLOR THEME
export CLICOLOR=true
export PAGER="less"
export LESS="-Rir"
export LSCOLORS="ExFxBxDxCxegedabagacad"

#  Change dir
alias lldir="cd \` sk < $LIBS_DIR/index.txt \`"
alias cpdir="cd /Users/pritam/Developer/cxx_lang"
alias cdir="cd /Users/pritam/Developer/c_lang"
alias gdir="cd /Users/pritam/Developer/git_repository"
alias bdir="cd /Users/pritam/.local/bin"

alias firefox="/Applications/Firefox.app/Contents/MacOS/firefox"
alias firefox-p="/Applications/Firefox.app/Contents/MacOS/firefox   --private-window"

#  NNN FILE MANAGER
NNN_PLUG='r:!rrr -- "$nnn" *;'
NNN_PLUG+='b:cdpath;'
NNN_PLUG+='i:fzcd;'
NNN_PLUG+="a:!adb push --sync -- "$nnn" /sdcard/Download/$(hostname)/;"
NNN_PLUG+='e:!|exiftool -- "$nnn";'
NNN_PLUG+='o:!|otool -L -- "$nnn";'
NNN_PLUG+='p:!ffplay  -loop -1 -sn -loglevel level+warning -seek_interval 5 "$nnn" *;'
NNN_PLUG+='f:!&ffplay -loop -1 -sn -loglevel level+warning -seek_interval 5 "$nnn" *;'
NNN_PLUG+='q:!qlmanage -p -- "$nnn"*;'
NNN_PLUG+='m:!&mpv -- "$nnn"*'
export NNN_PLUG

export NNN_COLORS="5236"
export NNN_OPENER="/usr/bin/open"
# export NNN_ORDER=""
export NNN_OPTS="AUBRdefagxp"
# export NNN_OPTS="ANUdixefaog"
export NNN_SEL="$TMPDIR/nnn.sel"
export NNN_TMPFILE="$TMPDIR/nnn.lastd"
export NNN_FIFO="$TMPDIR/nnn.fifon"
export NNN_TRASH="/usr/bin/trash"
export NNN_HELP="cat $DOT_FILE/../global/nnn_help.txt"
export NNN_ARCHIVE="\\.(7z|a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|rar|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)$"
export NNN_FCOLORS="c1e2272e006033f7c6d6abc4"

#  Color in man page
export LESS_TERMCAP_mb=$(
	tput bold
	tput setaf 2
) # green

# Start bold
export LESS_TERMCAP_md=$(
	tput bold
	tput setaf 2
) # green

# Start stand out
export LESS_TERMCAP_so=$(
	tput bold
	tput setaf 3
) # yellow

# End standout
export LESS_TERMCAP_se=$(
	tput rmso
	tput sgr0
)

# Start underline
export LESS_TERMCAP_US=$(
	tput smul
	tput bold
	tput setaf 1
) # red

# End bold, blinking, standout, underline
export LESS_TERMCAP_me=$(tput sgr0)

#  Some more ls aliases
alias ls="command ls --color=auto"
alias grep="command grep --color=auto"
alias fgrep="command fgrep --color=auto"
alias egrep="command egrep --color=auto"

alias ll="command ls -lh"
alias la="command ls -A"
alias l="command ls -lAh"

#  SOME MORE ALIES
alias cp="command cp -ip"
alias mv="command mv -i"
alias du="command du -h"

#  FOR NEO NVIM
alias enrc="$EDITOR ~/.config/nvim/init.lua"
alias eza="$EDITOR $DOT_FILE/dirwin_os/.alias.zsh"

#  SYSTEM ALIAS
alias o="command open ."
# alias sudo="command sudo -E"
alias c.="command code ."
alias z.="command zed ."
alias live-server="command live-server -o"
# alias quicklook="command qlmanage -p"
# alias tree="command tree -atsh "
alias tree="command  tre -a "
# alias tre="command tre -ae "
alias python="command python3 -u "
alias nq="command networkquality -s"
alias hc="command cat /dev/null > ~/.zsh_history"
alias search="command ls -AF | grep -i"
alias lh="command ls -AF| grep '^\.'"
alias sayy="command pbpaste | command say -i"
alias per="command find . -type f -exec chmod 644 {} \; && find . -type d -exec chmod 755 {} \;"
alias seelog="command tail -n 1 -f -- "
alias exportlib="source $LIBS_DIR/env"
alias zzz="bsdtar -xf "
# alias exportembdlib="source /Applications/ArmGNUToolchain/embedded-ENV"
alias ninja-tree="command ninja -t targets "
alias chownroot="command sudo chown -R root:wheel"
alias chownself="command sudo chown -R pritam:staff"
alias bk="open 'http://localhost:8080/'; shiori server"
alias wget="command wget --no-check-certificate -c"
alias off="pmset displaysleepnow"

function ww() {
	command wget \
	--no-check-certificate \
	-c "$(pbpaste)"
}

function _make_() {
	command make -qp | awk -F':' '/^[a-zA-Z0-9][^$#\/\t=]*:([^=]|$)/ {split($1,A,/ /);for(i in A)print A[i]}' | command sort -u
}

function doc() {
	local doc=$(fzf <$LIBS_DIR/doc.txt)
	open "file://$doc"
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
alias yt-dlp-u="command pip install --upgrade yt-dlp"

function yt-dlpp() {
	command yt-dlp \
		-o '~/Downloads/yt_dlp/%(extractor_key)s/%(playlist)s-%(uploader)s/%(playlist_index)s-%(title)s.%(ext)s' \
		--yes-playlist \
		$@ "$(pbpaste)"
}

function yt-dlpxx() {
	command yt-dlp \
		-o '~/Downloads/yt_dlp/.dlpxx/%(extractor_key)s-%(title)s.%(ext)s' \
		-f 'best/bestvideo*+bestaudio*' \
		$@ "$(pbpaste)"
}

function yt-dlpx() {
	command yt-dlp -o '%(title)s.%(ext)s' -f 'best/bestvideo*+bestaudio*' $@ "$(pbpaste)"
}

function short() {
	command yt-dlp --ignore-config --config-locations '~/.config/yt-dlp/you-tube_short_vidoe.txt' $@ "$(pbpaste)"
}

function insta() {
	command yt-dlp --ignore-config --config-locations '~/.config/yt-dlp/instagram.txt' $@ "$(pbpaste)"
}

export LC_ALL="en_US.UTF-8"
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

function hhhh() {
	command ffprobe -v quiet -print_format json -show_format -show_streams $@ | jq
}

function pathcp {
	local file="${1:-}"
	if [[ $file != /* ]]; then
		file="$PWD/$file"
	fi
	printf "$(realpath "$file")" | pbcopy
}

function diff {
	command diff -u --color=always $@ | less -r -
}

function clanginit {
	if [[ $# -eq 0 ]]; then
		echo "Usage: $1 <c, cxx, c++>  <project name>"
		return 1
	fi

	lower_input=$(echo "$1" | tr '[:upper:]' '[:lower:]')

	case "$lower_input" in
	c)
		COMMAND="   cp -rp  $DOT_FILE/global/c-cpp-template/c/ $2"
		;;
	c++)
		COMMAND="   cp -rp  $DOT_FILE/global/c-cpp-template/c++/ $2"
		;;
	cxx)
		COMMAND="   cp -rp  $DOT_FILE/global/c-cpp-template/c++/ $2"
		;;
	*)
		echo "Unsupported: <c cxx c++>: $1"
		return 1
		;;
	esac

	eval $COMMAND
}

function gg() {
	# https://www.reddit.com/prefs/apps
	local dest="~/Downloads/yt_dlp/posts"
	# local fileName="{category}-{username}-{date:%Y-%m-%d}-{num}.{extension}"

	# If first argument is '-', use current directory
	if [[ $1 == "-" ]]; then
		dest="$PWD"
		shift # remove the '-' from $@
	fi

	if [[ $1 == "xx" ]]; then
		dest+="/../.dlpxx/post"
		shift # remove the '-' from $@
	fi

	echo -e "\033[1;36m===[ gallery-dl \033[1;33mDownloading to: \033[1;35m$dest\033[1;36m ]===\033[0m"
	echo -e "\033[1;36m===[ \033[1;33mURL: \033[1;35m$(pbpaste)\033[1;36m ]===\033[0m"

	gallery-dl --cookies-from-browser firefox --destination "$dest" "$@" "$(pbpaste)"
}

# === Smart vcpkg: Debug = Dynamic, Release = Static (Release-only) ===
function vcpkg() {
	local VCPKG="/usr/local/bin/vcpkg" # ← Full path to REAL vcpkg

	if [[ $1 == "install" ]]; then
		shift # Remove 'install'
		for lib in "$@"; do
			echo "===[ Installing $lib (Debug → Dynamic, debug-only)...    ]==="
			echo "===> vcpkg install $lib --triplet arm64-osx-dynamic <==="
			VCPKG_BUILD_TYPE=debug "$VCPKG" install "$lib" --triplet arm64-osx-dynamic

			echo "===[ Installing $lib (Release → Static, Release-only)... ]==="
			echo "===> vcpkg install $lib --triplet arm64-osx <==="
			VCPKG_BUILD_TYPE=release "$VCPKG" install "$lib" --triplet arm64-osx
		done
	elif [[ $1 == "rem" ]]; then
		shift # Remove 'rem'
		for lib in "$@"; do
			echo "===[ Removing $lib (Debug → Dynamic, debug-only)...    ]==="
			echo "===> vcpkg remove $lib --triplet arm64-osx-dynamic <==="
			"$VCPKG" remove "$lib" --triplet arm64-osx-dynamic

			echo "===[ Removing $lib (Release → Static, Release-only)... ]==="
			echo "===> vcpkg remove $lib --triplet arm64-osx <==="
			"$VCPKG" remove "$lib" --triplet arm64-osx
		done
	else
		# Forward all other commands: list, remove, search, etc.
		"$VCPKG" "$@"
	fi

	# add this at the top of the file     $CMAKE_TOOLCHAIN_FILE
	# if(CMAKE_BUILD_TYPE STREQUAL "Debug")
	#   set(VCPKG_TARGET_TRIPLET "arm64-osx-dynamic")
	# else()
	#   set(VCPKG_TARGET_TRIPLET "arm64-osx")
	# endif()
}

function _zzz() {
	local f d supported

	if [[ $# -eq 0 ]]; then
		echo "Usage: $1 <c, cxx, c++>  <project name>"
		return 1
	fi

	# Expand globs safely
	set -- *.{7z,a,ace,alz,arc,arj,bz,bz2,cab,cpio,deb,gz,jar,lha,lzh,lzma,lzo,rar,rpm,rz,t7z,tar,tbz,tbz2,tgz,tlz,txz,tZ,tzo,war,xpi,xz,Z,zip} 2>/dev/null || set --

	# If no files matched, exit early
	[ $# -eq 0 ] && {
		echo "No archives found."
		return 0
	}

	for f; do
		# Skip if not a regular file
		[ -f "$f" ] || {
			printf 'SKIP: "%s" is not a regular file\n' "$f"
			continue
		}

		# Try to list contents with bsdtar → if fails, unsupported
		if ! bsdtar -t -f "$f" >/dev/null 2>&1; then
			printf 'ERROR: Unsupported format or corrupted: "%s"\n' "$f"
			continue
		fi

		# Build safe output directory
		d="${f%.*}"
		# Handle double extensions like .tar.gz
		case "$f" in
		*.tar.gz | *.tar.bz2 | *.tar.xz | *.tar.lzma | *.tar.Z | *.tgz | *.tbz | *.tbz2 | *.txz)
			d="${d%.*}" # remove .tar too
			;;
		esac
		d="${d}.extract"

		# Avoid overwrite
		if [ -e "$d" ]; then
			i=1
			while [ -e "${d}.$i" ]; do i=$((i + 1)); done
			d="${d}.$i"
		fi

		printf 'Extracting: "%s" → "%s"\n' "$f" "$d"
		mkdir -p "$d"
		bsdtar -x -f "$f" -C "$d"
		printf 'Done: %s\n' "$d"
	done
}

function link_executables() {
	local target_dir="$1"

	# --- Validate input ---
	if [[ -z $target_dir ]]; then
		echo "Usage: link_executables <target_directory>"
		return 1
	fi

	# Expand ~ and get absolute path
	target_dir="${target_dir/#\~/$HOME}"
	target_dir="$(cd "$(dirname "$target_dir")" >/dev/null 2>&1 && pwd)/$(basename "$target_dir")"

	if [[ ! -d $target_dir ]]; then
		echo "Error: Directory '$target_dir' does not exist."
		return 1
	fi

	# --- Find executable files (macOS + Linux compatible) ---
	find . -maxdepth 1 -type f -perm +111 -print | while IFS= read -r file; do
		# Remove ./ prefix
		filename="${file#./}"
		src_path="$(pwd)/$filename"
		link_path="$target_dir/$filename"

		# Create symbolic link (force overwrite)
		ln -sf "$src_path" "$link_path" &&
			echo "Linked: $filename → $link_path"
	done

	return 0
}

#  FOR COMMIT THE COMMIT WITH GPG
export GPG_TTY=$(tty)

#  IP / MACID ALIAS AND FUNCTIONS
alias ipinfo="command curl https://raw.githubusercontent.com/jarun/nnn/master/plugins/ipinfo 2> /dev/null | sh | $PAGER"
alias wanip="command curl -s http://checkip.dyndns.org/ | sed 's/[a-zA-Z<>/ :]//g'"                                                         # will print the loal ipv4 in termial.
alias macid="command ifconfig -a | grep ether | grep -oE '([0-9][0-9]:[a-z][0-9]:[a-z][a-z]:[a-z][a-z]:[0-9][0-9]:[0-9][0-9])' | head -n 1" # will print the return the macid of the computer
alias lanip="command ifconfig -a | egrep -A 7 '^en0' | grep inet | grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])' | head -n 1"

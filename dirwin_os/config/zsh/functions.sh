# printf "Importing \t %s \n" "$HOME/.config/zsh/functions.sh"

# ===========================================================================
# This shell script contains a collection of utility functions
# and tools to enhance productivity and streamline workflows.
# It includes functions for notifications, managing proxy settings,
# interacting with Google Drive via rclone, downloading files using
# wget and aria2c, taking screenshots, managing vcpkg libraries,
# and more. Each function is designed to handle specific tasks
# efficiently, with options for customization and flexibility.
# ===========================================================================


# ------------ Utility Functions ------------
# Download file from clipboard URL using wget
function notify() {
	local msg="$1"
	local title="${2:-Notification}"
	local type="${3:-info}" # info | error | log

	# Check for --help option
	if [[ $msg == "--help" ]]; then
		echo "Usage: notify <message> [title] [type]"
		echo "  <message>: The notification message to display."
		echo "  [title]:   Optional. The title of the notification. Default is 'Notification'."
		echo "  [type]:    Optional. The type of notification. Can be 'info', 'error', or 'log'. Default is 'info'."
		return 0
	fi

	# Choose sound based on type
	local sound="default"
	case "$type" in
	error)
		sound="Basso"
		;; # macOS built-in alert
	log)
		sound="Pop"
		;; # subtle sound
	info)
		sound="default"
		;; # generic notification
	esac

	# Send notification
	osascript -e "display notification \"$msg\" with title \"$title\" sound name \"$sound\"" 2 &>/dev/null
}


function message() {
	local msg="$1"
	local title="${2:-Notification}"
	local type="${3:-info}"

	# Check for --help option
	if [[ $msg == "--help" ]]; then
		echo "Usage: message <message> [title] [type]"
		echo "  <message>: The notification message to display."
		echo "  [title]:   Optional. The title of the notification. Default is 'Notification'."
		echo "  [type]:    Optional. The type of notification. Can be 'info', 'error', or 'log'. Default is 'info'."
		return 0
	fi

	case "$type" in
	error)
		osascript -e "display alert \"$title\" message \"$msg\" as critical" 2 &>/dev/null
		;;
	warning)
		osascript -e "display alert \"$title\" message \"$msg\" as warning" 2 &>/dev/null
		;;
	info | *)
		osascript -e "display alert \"$title\" message \"$msg\" as informational" 2 &>/dev/null
		;;
	esac
}


function wireproxy-start() {
	# Start wireproxy in background if not already running
	if pgrep -x wireproxy >/dev/null; then
		echo "wireproxy is already running (PID: $(pgrep wireproxy))."

		printf 'Kill it and restart? (y/n): '
		read -k 1 -r choice
		echo

		case "$choice" in
		[nN])
			# Overring proxy environment variables in current shell
			echo "Proxy environment variables are now override for this session."
			eval "export http_proxy="http://127.0.0.1:8080""
			eval "export https_proxy="http://127.0.0.1:8080""
			eval "export all_proxy="socks5://127.0.0.1:1080""
			eval "export WIREPROXY_HTTP="http://127.0.0.1:8080""
			eval "export WIREPROXY_SOCKET="socks5://127.0.0.1:1080""
			return 0
			;;
		[yY])
			echo "Killing wireproxy (PID: $(pgrep wireproxy))."
			echo "Unseting variables"
			unset http_proxy https_proxy all_proxy WIREPROXY_HTTP WIREPROXY_SOCKET
			pkill wireproxy
			return $?
			;;
		esac
	fi

	wireproxy -d -c ~/.config/wireproxy/wireproxy.conf -i "127.0.0.1:9080"

	# Check if wireproxy actually started successfully
	if [[ $? -eq 0 ]]; then
		echo "wireproxy started successfully: $(pgrep wireproxy)"
		echo "Ports: HTTP → 8080    SOCKS5 → 1080"
		echo "To stop later: pkill wireproxy"

		# Set proxy environment variables in current shell
		eval "export http_proxy="http://127.0.0.1:8080""
		eval "export https_proxy="http://127.0.0.1:8080""
		eval "export all_proxy="socks5://127.0.0.1:1080""
		eval "export WIREPROXY_HTTP="http://127.0.0.1:8080""
		eval "export WIREPROXY_SOCKET="socks5://127.0.0.1:1080""

		echo "Proxy environment variables are now set for this session."
	fi
}


function findDuplicate() {
	find . -type f -size +1M -exec cksum {} \; |
		tee /tmp/filelist.tmp |
		cut -f 1,2 -d ' ' |
		sort |
		uniq -d |
		grep -hif - /tmp/filelist.tmp |
		sort -nrk2
}


function gDrive() {
	# Check if at least one argument (a source) is provided.
	if [ -z "$1" ]; then
		echo "Usage: gDrive <source_path> [<source_path>...]"
		return 1
	fi

	# Define the destination directory. The trailing slash is important
	# to ensure rclone treats it as a directory.
	local dest="Gdrive:/rclone/$(hostname -s)/"

	echo "Copying files to $dest"

	# Loop through every argument provided to the function.
	num=0
	for source in "$@"; do
		echo -e "\033[1;36m==> [ \033[1;33mCopy to Google drive: \033[1;35m$source\033[1;36m ] <==\033[0m"
		command rclone copy "$source" "$dest" -vP
		local rclone_exti=$!
		if [[ $rclone_exti -eq 0 ]]; then
			((num++))
		fi
	done

	if [[ $rclone_exti -eq 0 ]]; then
		notify "Move $num items" "Rclone" "into"
	else
		notify "Fail" "Rclone" "error"
	fi
}


function ww() {
	# --no-check-certificate \
	command wget \
		-c "$(pbpaste)"
}


# List all Makefile targets
function _make_() {
	command make -qp | awk -F':' '/^[a-zA-Z0-9][^$#\/\t=]*:([^=]|$)/ {split($1,A,/ /);for(i in A)print A[i]}' | command sort -u
}


# Open documentation file using fzf
function doc() {
	local doc=$(sk <$LIBS_DIR/doc.txt)
	open "file://$doc"
}


# Take a screenshot with shadow
function ss() {
	screencapture -w "./Screen–short–$(date +"%Y-%b-%d_at_%H.%M.%S").png"
}


# Take a screenshot without shadow
function sss() {
	screencapture -s "./Screen–short–$(date +"%Y-%b-%d_at_%H.%M.%S").png"
}
# --------------------------------------------------


# ------------ Aria2c Function ---------------
# Function to download content using aria2c
function ari() {
	# Display download information
	echo -e "\033[1;36m==> [ \033[1;33mURL: \033[1;35m$(pbpaste)\033[1;36m ] <==\033[0m"

	# Execute aria2c command
	command aria2c \
		--input-file="" \
		--force-sequential=true \
		--remove-control-file \
		--dir="$PWD" \
		"$@" "$(pbpaste)"
}

function streem-aria2c() {
	# Display download information
	echo -e "\033[1;36m==> [ \033[1;33mStreem URL: \033[1;35m$(pbpaste)\033[1;36m ] <==\033[0m"

	# --on-download-complete
	# --select-file=1,5-7 <TORRENT>

	# Execute aria2c command
	command aria2c \
		-Z \
		"$@" "$(pbpaste)"
}
# ---------------------------------------------


# ------------ Vcpkg Function -----------------
# Function to manage vcpkg libraries with smart triplet handling
function vcpkg() {
	local VCPKG="/usr/local/bin/vcpkg" # Full path to the vcpkg executable

	if [[ $1 == "install" ]]; then
		shift # Remove 'install'
		for lib in "$@"; do
			# Install library for Debug (Dynamic)
			echo "===[ Installing $lib (Debug → Dynamic, debug-only)...    ]==="
			echo "===> vcpkg install $lib --triplet arm64-osx-dynamic <==="
			VCPKG_BUILD_TYPE=debug "$VCPKG" install "$lib" --triplet arm64-osx-dynamic

			# Install library for Release (Static)
			echo "===[ Installing $lib (Release → Static, Release-only)... ]==="
			echo "===> vcpkg install $lib --triplet arm64-osx <==="
			VCPKG_BUILD_TYPE=release "$VCPKG" install "$lib" --triplet arm64-osx
		done
	elif [[ $1 == "rem" ]]; then
		shift # Remove 'rem'
		for lib in "$@"; do
			# Remove library for Debug (Dynamic)
			echo "===[ Removing $lib (Debug → Dynamic, debug-only)...    ]==="
			echo "===> vcpkg remove $lib --triplet arm64-osx-dynamic <==="
			"$VCPKG" remove "$lib" --triplet arm64-osx-dynamic

			# Remove library for Release (Static)
			echo "===[ Removing $lib (Release → Static, Release-only)... ]==="
			echo "===> vcpkg remove $lib --triplet arm64-osx <==="
			"$VCPKG" remove "$lib" --triplet arm64-osx
		done
	else
		# Forward all other commands to vcpkg
		"$VCPKG" "$@"
	fi

	# add this at the top of the file     $CMAKE_TOOLCHAIN_FILE
	# if(CMAKE_BUILD_TYPE STREQUAL "Debug")
	#   set(VCPKG_TARGET_TRIPLET "arm64-osx-dynamic")
	# else()
	#   set(VCPKG_TARGET_TRIPLET "arm64-osx")
	# endif()
}
# --------------------------------------------------


# ------------ Gallery-dl Function ------------
# Function to download content using gallery-dl
function gg() {
	# Default destination directory
	local dest="$HOME/Downloads/yt_dlp/posts"
	# local fileName="{category}-{username}-{date:%Y-%m-%d}-{num}.{extension}"

	# If first argument is '-', use the current directory as destination
	if [[ $1 == "-" ]]; then
		dest="$PWD"
		shift # Remove the '-' from $@
	fi

	# If first argument is 'xx', modify destination path
	if [[ $1 == "xx" ]]; then
		dest+="/../.dlpxx/post"
		shift # Remove 'xx' from $@
	fi

	# Display download information
	echo -e "\033[1;36m===[ gallery-dl \033[1;33mDownloading to: \033[1;35m$dest\033[1;36m ]===\033[0m"
	echo -e "\033[1;36m===[ \033[1;33mURL: \033[1;35m$(pbpaste)\033[1;36m ]===\033[0m"

	# Execute gallery-dl command
	gallery-dl --cookies-from-browser firefox --destination "$dest" "$@" "$(pbpaste)"
}
# ---------------------------------------------


# ------------ Link Executables Function -------
# Function to create symbolic links for executables in a target directory
function link_item() {
	local target_dir="$1"

	# Validate input
	if [[ -z $target_dir ]]; then
		echo "Usage: link_executables <target_directory>"
		return 1
	fi

	# Expand ~ and get absolute path
	target_dir="${target_dir/#\~/$HOME}"
	target_dir="$(cd "$(dirname "$target_dir")" >/dev/null 2>&1 && pwd)/$(basename "$target_dir")"

	# Check if target directory exists
	if [[ ! -d $target_dir ]]; then
		echo "Error: Directory '$target_dir' does not exist."
		return 1
	fi

	# Find executable files and create symbolic links
	# find . -maxdepth 1 -type f -perm +111 -print | while IFS= read -r file; do
	find . -maxdepth 1 -print | while IFS= read -r file; do
		filename="${file#./}" # Remove './' prefix
		src_path="$(pwd)/$filename"
		link_path="$target_dir/$filename"

		# Skip "." and ""
		if [[ $filename == "." || -z $filename ]]; then
			continue
		fi

		# Create symbolic link (force overwrite)
		ln -sf "$src_path" "$link_path"
		echo -e "ln -sf: \033[0;31m $filename \033[0m → \033[1;33m $link_path \033[0m"
	done

	return 0
}
# ---------------------------------------------


# Initialize C/C++ project templates
function clanginit {
	if [[ $# -eq 0 ]]; then
		echo "Usage: $1 <c, cxx, c++, ard>  <project name>"
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
	ard)
		COMMAND="   cp -rp  $DOT_FILE/global/embedded/arduino-cli-uno/ $2; \
		            mv '$2/arduino-cli-uno.ino' '$2/$2.ino' "
		;;
	*)
		echo "Unsupported: <c cxx c++ ard>: $1"
		return 1
		;;
	esac

	eval "$COMMAND"
}


# ------------ YT-DLP Functions ------------
function yt() {
	local URL=$(pbpaste)
	local command=""

	# Check if URL is empty
	if [[ -z $URL ]]; then
		echo "Clipboard is empty or does not contain a URL."
		return 1
	fi

	# Regex to check if the string is a valid HTTP/HTTPS URL
	if ! [[ $URL =~ ^https?:// ]]; then
		echo "Clipboard does not contain a valid URL.: \a \033[31m$URL\033[0m"
		return 1
	fi

	if [[ $URL == https://www.youtube.com/watch* ]]; then
		command="yt-dlp $* \"$URL\""
	elif [[ $URL == https://www.youtube.com/playlist* ]]; then
		command="yt-dlp --pList $* \"$URL\""
	elif [[ $URL == https://www.youtube.com/shorts* ]]; then
		command="yt-dlp --st $* \"$URL\""
	elif [[ $URL == https://www.instagram.com* ]]; then
		command="yt-dlp --st $* \"$URL\""
	elif [[ $URL == https://www.jiosaavn.com* ]]; then
		command="yt-dlp --savan $* \"$URL\""
	elif [[ $URL == https://music.youtube.com* ]]; then
		command="yt-dlp --ysong $* \"$URL\""
	else
		command="yt-dlp $* \"$URL\""
	fi

	printf "\033[1;32m%s@%s\033[0m:\033[1;34m%s\033[0m\$ %s\n" "$USER" "$(hostname -s)" "${PWD/#$HOME/~}" "$command"

	eval "$command"

	# Check if yt-dlp command was successful
	if [[ $? -eq 0 ]]; then
		notify "Download completed successfully." "yt-dlp" "info"
	else
		notify "Download failed." "yt-dlp" "error"
		return $?
	fi
}
# -------------------------------------------------------


# ------------ Github cli Functions ------------
function gh() {
	if [[ $1 == "init" ]]; then
		# Check if inside git repo
		if [[ ! -d .git ]]; then
			echo "❌ Not a git repository. Run: git init"
			return 1
		fi

		# Ask privacy
		echo "📦 Public or Private? (p/P=public, any key=private)"
		read -r choice

		privacy="--private"
		if [[ $choice =~ ^[pP]$ ]]; then
			privacy="--public"
		fi

		# Optional description prompt
		echo "📝 Enter repository description (or leave empty):"
		read -r description
		desc_flag=""
		if [[ -n $description ]]; then
			desc_flag="--description='$description'"
		fi

		# Create repo using folder name
		repo_name=$(basename "$PWD")

		command gh repo create "$repo_name" \
			"$privacy" \
			--source . \
			--remote=origin \
			--push \
			--disable-wiki \
			"$desc_flag" \
			--disable-issues

		echo "🚀 Done! Linked and pushed to GitHub."
	elif [[ $1 == "info" ]]; then
		command gh repo view \
		hyprwm/Hyprland \
		--json name,description,stargazerCount
	else
		command gh "$@"
	fi
}

function aboutrepo() {
	gh repo view "$@" --json name,description,stargazerCount
}

# ---------------------------------------------


# ------------ Miscellaneous Functions ------------
# Colorized diff output
function diff {
	command diff -u --color=always "$@" | less -r -
}


# Pretty-print media file metadata using ffprobe and jq
function hhhh() {
	command ffprobe -v quiet -print_format json -show_format -show_streams "$@" | jq
}


# Copy absolute file path to clipboard
function pc {
	local file="${1:-}"
	if [[ $file != /* ]]; then
		file="$PWD/$file"
	fi
	local abs_path=$(realpath "$file")
	# Escape special characters in the path
	abs_path=$(printf "\"%s\"" "$abs_path")
	printf "$abs_path" | pbcopy
	# echo -e "\033[1;36m==> [ \033[1;33mCopy to clipboard: \033[1;35m$abs_path\033[1;36m ] <==\033[0m"
}
# ---------------------------------------------

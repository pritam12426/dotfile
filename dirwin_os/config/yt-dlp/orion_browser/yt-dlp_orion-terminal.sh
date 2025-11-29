#!/bin/sh

export PATH="$HOME/.local/bin:$PATH"
LOG_FILE="$HOME/.local/share/yt-dlp/orion_broser.log"

function yt () {
	local URL="$1"
	local CC="yt-dlp"
	local command="yt-dlp  --newline "

	if ! [[ $URL =~ ^https?:// ]]; then
		message "Not a url" "Orion" "error"
		return 1
	fi

	if [[ $URL == https://www.youtube.com/watch* ]]; then
		command+=" $* \"$URL\""
	elif [[ $URL == https://www.youtube.com/playlist* ]]; then
		command+="--pList $* \"$URL\""
	elif [[ $URL == https://www.youtube.com/shorts* ]]; then
		command+=" --st $* \"$URL\""
	# elif [[ $URL == https://www.youtube.com/playlist* ]]; then #   ,,,,,,
	# 	command+="--pList $* \"$URL\""
	elif [[ $URL == https://www.instagram.com* ]]; then
		command+="--st $* \"$URL\""
	elif [[ $URL == https://www.jiosaavn.com* ]]; then
		command+=" --savan $* \"$URL\""
	elif [[ $URL == https://music.youtube.com* ]]; then
		command+=" --ysong $* \"$URL\""
	else
		command+=" $* \"$URL\""
	fi

	echo "=== Executing command: $command ==="
	eval "$command"
}

echo "=========== Starting yt-dlp with Orion Browser $(date +"%Y-%b-%d %Ih:%Mm:%Ss %p") ======================="
yt  "$@"

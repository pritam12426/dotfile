#!/bin/bash

OUTPUT_DIR="$HOME/.config/pandoc/templates/"
mkdir -p "$OUTPUT_DIR" || true
cd "$OUTPUT_DIR" || true

download_and_log() {
	local cmd="$1"
	local message="$2"

	echo -e "\033[1;36m==> \033[1;33m$message\033[1;36m <==\033[0m"
	if ! eval "$cmd"; then
		echo -e "\033[1;31mFailed: $cmd\033[0m"
		return 1
	fi
	printf '%*s\n' "$(tput cols)" '' | tr ' ' '-' >&2
}

# Use an indexed array with pairs: command, message, command, message...
downloads=(
	"Installing github-markdown-light.css" "wget -q --show-progress -c 'https://raw.githubusercontent.com/sindresorhus/github-markdown-css/refs/heads/main/github-markdown-light.css'"
	"Installing github-markdown-dark.css"  "wget -q --show-progress -c 'https://raw.githubusercontent.com/sindresorhus/github-markdown-css/refs/heads/main/github-markdown-dark.css'"
	"Installing github-markdown.css"       "wget -q --show-progress -c 'https://raw.githubusercontent.com/sindresorhus/github-markdown-css/refs/heads/main/github-markdown.css'"
)

# Loop through array in pairs
for ((i = 0; i < ${#downloads[@]}; i += 2)); do
	download_and_log "${downloads[i + 1]}" "${downloads[i]}" || exit 1
done

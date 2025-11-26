#!/bin/bash
# https://aria2.github.io/manual/en/html/aria2c.html#event-hook

# echo "Called with [$1] [$2] [$3]"
# $1 ==> GID
# $2 ==> Number of file   (Bit torrent have multiple files in it)
# $3 ==> full file path

#!/bin/bash

HISTORY_FILE="$HOME/Library/Caches/yt-dlp/yt-dlp_aira2_download-history.txt"

# FIX 1: The condition to check if the file does NOT exist.
# -x checks if a file is EXECUTABLE.
# ! -e checks if a file does NOT EXIST, which is what you want.
if [[ ! -e "$HISTORY_FILE" ]]; then
	(
		# FIX 2: Corrected formatting for 5 distinct columns.
		# This ensures "File" and "Path" are separate, aligned columns.
		printf "%-18s | %-28s | %-5s | %-120s | %s\n" "GID" "Date" "Num" "File" "Path"

		# BEST PRACTICE: A separator line that exactly matches the header widths.
		# This is better than a hardcoded line of dashes.
		printf "%-18s | %-28s | %-5s | %-120s | %s\n" \
			"------------------" "----------------------------" "-----" "------------------------------------------------------------------------------------------------------------------------" "-----------"
	) > "$HISTORY_FILE"
fi


(
	printf "%-18s | %-28s | %-5lld | %-120s | %s\n" "$1" "$(date +"%Y-%b-%d %Ih:%Mm:%Ss %p")" "$2" "$(basename "$3")" "$(dirname "$3")"
) >> "$HISTORY_FILE"


# Remove the *.aria2 file -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# Check if the file exists and is a regular file
if [[ -f "$3.aria2" ]]; then
	rm -f "$3.aria2"
fi
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=


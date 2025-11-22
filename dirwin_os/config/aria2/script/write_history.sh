#!/bin/bash
# https://aria2.github.io/manual/en/html/aria2c.html#event-hook

# echo "Called with [$1] [$2] [$3]"
# $1 ==> GID
# $2 ==> Number of file   (Bit torrent have multiple files in it)
# $3 ==> full file path

(
	printf " %s | %s | %lld | %s\n" "$1" "$(date +"%Y-%b-%d %Ih:%Mm:%Ss %p")" "$2"  "$(basename $3)"
) >> "$HOME/Downloads/aria2/download-history.txt"

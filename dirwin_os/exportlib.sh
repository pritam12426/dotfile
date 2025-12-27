#!/bin/bash

CPP_LIB_DIR="/usr/local/big_library"
file="$CPP_LIB_DIR/env"

# Clear the file before writing new values
>"$file"

parse() {
	{
		printf "export %s=" "$2"
		printf "%s" "$(echo "$1" | sed 's/:/:\\\n/g')"
		printf "\n\$%s\n\n\n" "$2"
	} >>"$file"
}

find_dirs() {
	find "$CPP_LIB_DIR" -type d -name "$1" -print0 | tr '\0' ':'
}


__MANPATH="$(find_dirs 'man')$__MANPATH"
echo "Adding the man pages ..."

parse "$__MANPATH" "MANPATH"

printf 'export PATH=/usr/local/big_library-bin:$PATH' >> "$file"

echo "Updating the index ..."
echo "$CPP_LIB_DIR" > "/tmp/data.txt"
echo "/usr/local/boost-1.87.0" >> "/tmp/data.txt"
find "$PWD" -type d -d 1 >> "/tmp/data.txt"
sudo cp -p "/tmp/data.txt" "$CPP_LIB_DIR/index.txt"

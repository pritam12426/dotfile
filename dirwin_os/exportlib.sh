#!/bin/bash

lib="/usr/local/big_library"
file="$lib/env"

# Clear the file before writing new values
> "$file"

parse() {
	{
		printf "export %s=" "$2"
		printf "%s" "$(echo "$1" | sed 's/:/:\\\n/g')"
		printf "\n\$%s\n\n\n" "$2"
	} >> "$file"
}

find_dirs() {
	find "$lib" -type d -name "$1" -print0 | tr '\0' ':'
}

__PATH="$(find_dirs 'bin')$__PATH"
__MANPATH="$(find_dirs 'man')$__MANPATH"
__PKG_CONFIG_PATH="$(find_dirs 'pkgconfig')$__PKG_CONFIG_PATH"
__DYLD_LIBRARY_PATH="$(find_dirs 'lib')$__DYLD_LIBRARY_PATH"
__CMAKE_PREFIX_PATH="$(find_dirs 'cmake')$__CMAKE_PREFIX_PATH"

parse "$__PATH" "PATH"
parse "$__MANPATH" "MANPATH"
parse "$__PKG_CONFIG_PATH" "PKG_CONFIG_PATH"
parse "$__DYLD_LIBRARY_PATH" "DYLD_LIBRARY_PATH"
parse "$__CMAKE_PREFIX_PATH" "CMAKE_PREFIX_PATH"

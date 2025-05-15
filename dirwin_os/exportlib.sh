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

find /usr/local/big_library -type f -name '*.pc'     -exec ln -sf {} /usr/local/lib/pkgconfig/ \;
find /usr/local/big_library -d 3 -path '*/include/*' -exec ln -sf {} /usr/local/include/ \;
find /usr/local/big_library -d 3 -type f -path '*/lib/*'  -exec ln -sf {} /usr/local/lib/ \;
find /usr/local/big_library -type f -name '*.cmake'  -exec ln -sf {} /usr/local/lib/cmake/ \;
find /usr/local/big_library -type f -path "*/bin/*"  -exec ln -sf {} /usr/local/big_library-bin/ \;

__MANPATH="$(find_dirs 'man')$__MANPATH"
# __PATH="$(find_dirs 'bin')$__PATH"
# __PKG_CONFIG_PATH="$(find_dirs 'pkgconfig')$__PKG_CONFIG_PATH"
# __DYLD_LIBRARY_PATH="$(find_dirs 'lib')$__DYLD_LIBRARY_PATH"
# __CMAKE_PREFIX_PATH="$(find_dirs 'cmake')$__CMAKE_PREFIX_PATH"

parse "$__MANPATH" "MANPATH"
# parse "$__PATH" "PATH"
# parse "$__PKG_CONFIG_PATH" "PKG_CONFIG_PATH"
# parse "$__DYLD_LIBRARY_PATH" "LIBRARY_PATH"
# parse "$__DYLD_LIBRARY_PATH" "DYLD_LIBRARY_PATH"
# parse "$__CMAKE_PREFIX_PATH" "CMAKE_PREFIX_PATH"

printf "export PATH=/usr/local/big_library-bin:\$PATH" >> "$file"

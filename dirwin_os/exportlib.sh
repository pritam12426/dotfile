lib="/usr/local/big_library"
file=$lib/env

cat /dev/null > $file

parse() {
	local input="$1"
	local prefix="$2"
	{
		printf "export %s=" "$prefix"
		printf "%s" "$(echo "$input" | sed 's/:/:\\\n/g')" # Remove trailing newline
		printf "\n\$%s" "$prefix"
		printf "\n\n\n"
	} >> $file
}

__PATH="$(             find $lib -type 'd' -name 'bin'       | tr '\n' ':')$__PATH"
__MANPATH="$(          find $lib -type 'd' -name 'man'       | tr '\n' ':')$__MANPATH"
__PKG_CONFIG_PATH="$(  find $lib -type 'd' -name 'pkgconfig' | tr '\n' ':')$__PKG_CONFIG_PATH"
__DYLD_LIBRARY_PATH="$(find $lib -type 'd' -name 'lib'       | tr '\n' ':')$__DYLD_LIBRARY_PATH"
__CMAKE_PREFIX_PATH="$(find $lib -type 'd' -name 'cmake'     | tr '\n' ':')$__CMAKE_PREFIX_PATH"


parse $__PATH              "PATH"
parse $__MANPATH           "MANPATH"
parse $__PKG_CONFIG_PATH   "PKG_CONFIG_PATH"
parse $__DYLD_LIBRARY_PATH "DYLD_LIBRARY_PATH"
parse $__CMAKE_PREFIX_PATH "CMAKE_PREFIX_PATH"

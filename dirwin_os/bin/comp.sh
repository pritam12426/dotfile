#!/bin/sh

set -e

file="$1"

file=`realpath $file`

path=$(dirname "$file")
filename=$(basename "$file")

run_command=""

# Checking file type and setting up the run command
case "$file" in
	*.c)
		run_command+="$CC -std=c17 "
		;;
	*.cpp)
		run_command+="$CXX -std=c++20 "
		;;
	*.rs)
		run_command+="cargo run -q "
		;;
	*.pl)
		run_command+="perl $file "
		;;
	[Mm]akefile)
		run_command+="make -c $path -f $file "
		;;
	*.html)
		run_command+="open $file "
		;;
	*.d2)
		run_command+="d2 $file "
		;;
	*.cal)
		run_command+="bc -lf $file "
		;;
	*.py)
		run_command+="python3 $file "
		;;
	*.go)
		run_command+="go run $file "
		;;
	*.zig)
		run_command+="zig run $file "
		;;
	*.sql)
		run_command+="sqlite3 -table -bail < $file "
		;;
	*.cs)
		run_command+="dotnet run "
		;;
	*.java)
		run_command+="javac $file "
		;;
	*.js)
		run_command+="node $file "
		;;
	*.sh)
		run_command+="bash $file "
		;;
	*)
		shebang=$(head -n 1 "$file" | cut -c 3-)
		if [[ -x "$(command -v "$shebang")" ]]; then
			"$shebang" "$file"
			exit $?
		else
			echo "Unknown file type: '$file'"
			exit 1
		fi
		;;
esac

RUN=0


if [[ ! $run_command =~ ^/usr/bin/clang ]]; then
	echo $run_command >&2; printf '%*s\n' `tput cols` '' | tr ' ' '─' >&2
	eval $run_command
	exit $?
fi

if [[ "$2" == '-' ]]; then
	RUN=1
	TMPDIR="$path/"
	shift 1
fi

run_command+="-pedantic -Wall -arch arm64 $2 $3 $4 $5 $6 $7 $8 $9 '$path/$filename' -o '$TMPDIR${filename//./-}.out'"

# Execute the run command
echo $run_command >&2; printf '%*s\n' `tput cols` '' | tr ' ' '─' >&2
eval $run_command

if [[ $RUN == 1 ]]; then
	exit $?
fi

# Run the compiled output if compilation was successful
if [[ $? -eq 0 ]]; then
	# /usr/bin/time -h "$TMPDIR${filename//./-}.out"
	"$TMPDIR${filename//./-}.out"
fi

exit $?

#!/bin/sh

set -e

file="$1"

file=$(realpath $file)

path=$(dirname "$file")
filename=$(basename "$file")
file_without_extension="${filename%.*}"

run_command=""

# Checking file type and setting up the run command
case "$file" in
*.c)
	run_command+="$CC -std=c17 $file "
	;;
*.cpp)
	run_command+="$CXX -std=c++20 $file "
	;;
*.rs)
	run_command+="cargo run -q "
	;;
*.pl)
	run_command+="perl $file "
	;;
*[Mm]akefile*)
	run_command+="make -C $path -f $file "
	;;
*.html)
	run_command+="open $file "
	;;
*.d2)
	run_command+="d2 $file "
	;;
*.cal)
	run_command+="bc -liqf $file "
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
	# run_command+="sqlite3 -header -table -bail -nullvalue "󰟢" $path/$file_without_extension.sqlite3 < $file "
	run_command+="sqlite3 -header -table -bail -nullvalue "󰟢" < $file "
	;;
*.cs)
	run_command+="dotnet run "
	;;
*.java)
	run_command+="java $file "
	;;
*.js)
	run_command+="node $file "
	;;
*.sh)
	run_command+="bash -x $file "
	;;
*)
	./$file
	;;
esac

RUN=0

if [[ ! $run_command =~ ^/usr/bin/clang ]]; then
	echo $run_command >&2; printf '%*s\n' $(tput cols) '' | tr ' ' '─' >&2
	eval $run_command
	exit $?
fi

if [[ "$2" == '-' ]]; then
	RUN=1
	TMPDIR="$path/"
	shift 1
fi

run_command+="-pedantic -Wall -arch arm64 $2 $3 $4 $5 $6 $7 $8 $9 -o '$TMPDIR${filename//./-}.out'"

# Execute the run command
echo $run_command >&2; printf '%*s\n' $(tput cols) '' | tr ' ' '─' >&2
eval $run_command

if [[ $RUN == 1 ]]; then
	exit $?
fi

# Run the compiled output if compilation was successful
if [[ $? -eq 0 ]]; then
	strip "$TMPDIR${filename//./-}.out"
	# /usr/bin/time -h "$TMPDIR${filename//./-}.out"
	"$TMPDIR${filename//./-}.out"
fi

exit $?

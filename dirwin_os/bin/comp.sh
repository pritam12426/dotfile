#!/bin/sh

set -e

# Default file path if no argument is provided
if [[ $# -eq 0 ]]; then
	if [[ -f "main.c" ]]; then
		file="main.c"
	elif [[ -f "main.cpp" ]]; then
		file="main.cpp"
	elif [[ -f "main.py" ]]; then
		file="main.py"
	elif [[ -f "main.rs" ]]; then
		file="main.rs"
	else
		echo "$0 : missing operand"
		exit 1
	fi
else
	file="$1"
fi

file=`realpath $file`

path=$(dirname "$file")
filename=$(basename "$file")

# Checking file type and setting up the run command
case "$file" in
	*.c)
		run_command="$CC -std=c2x "
		;;
	*.cpp)
		run_command="$CXX -std=c++2b "
		;;
	*.rs)
		cargo run -q
		exit $?
		;;
	*.pl)
		perl "$file"
		exit $?
		;;
	[Mm]akefile)
		make -C "$path" -f "$file"
		exit $?
		;;
	*.html)
		open "$file"
		exit $?
		;;
	*.d2)
		d2 "$file"
		exit $?
		;;
	*.cal)
		bc -lf "$file"
		exit $?
		;;
	*.py)
		python3 "$file"
		exit $?
		;;
	*.go)
		go run "$file"
		exit $?
		;;
	*.zig)
		zig run "$file"
		exit $?
		;;
	*.sql)
		sqlite3 < "$file"
		exit $?
		;;
	*.cs)
		dotnet run
		exit $?
		;;
	*.java)
		java "$file"
		exit $?
		;;
	*.js)
		node "$file"
		exit $?
		;;
	*.sh)
		bash "$file"
		exit $?
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

if [[ "$2" == '-' ]]; then
	RUN=1
	TMPDIR="$path/"
	shift 1
fi


if [[ "$path" == "$HOME/Developer/leedcode"* ]]; then
	run_command+="$INC_FLAGS $LDLIB "
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
	if [[ "$path" == "$HOME/Developer/leedcode"* ]]; then
		/usr/bin/time -h "$TMPDIR${filename//./-}.out" < ~/Developer/leedcode/input.txt
	else
		# /usr/bin/time -h "$TMPDIR${filename//./-}.out"
		"$TMPDIR${filename//./-}.out"
	fi
	exit $?
else
	exit $?
fi

#!/usr/local/bin/python3 -u

import argparse
from pathlib import Path
from itertools import chain

class Color:
	# Colors
	BLACK      = '\033[0;30m'
	RED        = '\033[0;31m'
	GREEN      = '\033[0;32m'
	YELLOW     = '\033[0;33m'
	BLUE       = '\033[0;34m'
	MAGENTA    = '\033[0;35m'
	CYAN       = '\033[0;36m'
	WHITE      = '\033[0;37m'

	# Bright Colors
	BRIGHT_BLACK   = '\033[1;30m'
	BRIGHT_RED     = '\033[1;31m'
	BRIGHT_GREEN   = '\033[1;32m'
	BRIGHT_YELLOW  = '\033[1;33m'
	BRIGHT_BLUE    = '\033[1;34m'
	BRIGHT_MAGENTA = '\033[1;35m'
	BRIGHT_CYAN    = '\033[1;36m'
	BRIGHT_WHITE   = '\033[1;37m'

	# Background Colors
	BG_BLACK      = '\033[40m'
	BG_RED        = '\033[41m'
	BG_GREEN      = '\033[42m'
	BG_YELLOW     = '\033[43m'
	BG_BLUE       = '\033[44m'
	BG_MAGENTA    = '\033[45m'
	BG_CYAN       = '\033[46m'
	BG_WHITE      = '\033[47m'

	# Bright Background Colors
	BG_BRIGHT_BLACK   = '\033[100m'
	BG_BRIGHT_RED     = '\033[101m'
	BG_BRIGHT_GREEN   = '\033[102m'
	BG_BRIGHT_YELLOW  = '\033[103m'
	BG_BRIGHT_BLUE    = '\033[104m'
	BG_BRIGHT_MAGENTA = '\033[105m'
	BG_BRIGHT_CYAN    = '\033[106m'
	BG_BRIGHT_WHITE   = '\033[107m'

	# Text Modifiers
	BOLD       = '\033[1m'
	DIM        = '\033[2m'
	ITALIC     = '\033[3m'
	UNDERLINE  = '\033[4m'
	BLINK      = '\033[5m'
	REVERSE    = '\033[7m'  # Swap foreground and background colors
	HIDDEN     = '\033[8m'
	STRIKETHROUGH = '\033[9m'

	# Reset
	RESET      = '\033[0m'  # Resets all text formatting

CPP_LIB_DIR: Path = Path("/usr/local/big_library")
BIN       = (CPP_LIB_DIR / "../big_library-bin").resolve()
INCLUDE   = (CPP_LIB_DIR / "../include").resolve()
LIB       = (CPP_LIB_DIR / "../lib").resolve()
CMAKE     = (CPP_LIB_DIR / "../lib/cmake").resolve()
PKGCONFIG = (CPP_LIB_DIR / "../lib/pkgconfig").resolve()

def argparseInit() -> argparse.Namespace:
	parser = argparse.ArgumentParser(
		description="A CLI tool for exporting lib to the system."
	)

	parser.add_argument(
		"lib_name",
		nargs="*",
		type=Path,
		help=f'Name of lib inside \
		"{Color.BRIGHT_RED}{Color.UNDERLINE}{CPP_LIB_DIR}{Color.RESET}" <lib_name>'
	)

	# Parse arguments
	args = parser.parse_args()
	return args


def _safe_symlink(target: Path, link: Path) -> None:
	# link.parent.mkdir(parents=True, exist_ok=True)

	if link.is_symlink():
		if link.resolve() == target.resolve():
			return
		link.unlink()

	elif link.exists():
		print(f"  ! Skip existing file: {link}")
		return

	link.symlink_to(target)


def _link_lib_subsections(lib_dir: Path) -> None:
	extras = {
		# todo: add *-config.cmake
		"cmake": ("**/*Config.cmake", CMAKE),
		"pkgconfig": ("**/*.pc", PKGCONFIG),
	}

	for folder, (pattern, dest_base) in extras.items():
		sub = lib_dir / folder
		if not sub.is_dir():
			continue

		print(f'\nLinking {Color.BRIGHT_YELLOW}{folder}{Color.RESET} "{Color.BRIGHT_MAGENTA}{sub}{Color.RESET}"')

		for idx, f in enumerate(sub.glob(pattern), 1):
			link = dest_base / f.name
			_safe_symlink(f, link)
			print(f"{idx:>4} {f.name}")


def install_links(new_lib_dir: Path) -> None:
	sections = {
		"bin": (lambda p: p.iterdir(), BIN),
		"include": (lambda p: p.iterdir(), INCLUDE),
		"lib": (lambda p: chain(p.glob("*.dylib"), p.glob("*.a")), LIB),
	}

	for name, (file_iter, dest_base) in sections.items():
		section_dir = new_lib_dir / name
		if not section_dir.is_dir():
			continue

		print(
			f'\nLinking {Color.BRIGHT_RED}{name}{Color.RESET} "{Color.BRIGHT_CYAN}{section_dir}{Color.RESET}"'
		)

		for idx, f in enumerate(file_iter(section_dir), 1):
			link = dest_base / f.name
			_safe_symlink(f, link)
			print(f"{idx:>4} {f.name}")

		if name == "lib":
			_link_lib_subsections(section_dir)


ARGS: argparse.Namespace = argparse.Namespace()
ARGS = argparseInit()
lib_name: Path = ARGS.lib_name[0].resolve()
if lib_name.parent != CPP_LIB_DIR and not lib_name.exists():
	print("Error")
	exit(1)

install_links(lib_name)

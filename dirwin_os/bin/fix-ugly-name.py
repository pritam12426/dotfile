#!/usr/bin/env python3 -u

import argparse
# import git   # pip install GitPython
import logging
import os
import re  # Regular expression
import string
import unicodedata


def format_string(text: str) -> str:
	# Normalize unicode: é → e, ü → u, ñ → n, etc.
	text = unicodedata.normalize("NFKD", text).encode("ascii", "ignore").decode()

	# Replace whitespace with underscores, collapse multiple _
	text = re.sub(r"[ \t]+", "_", text)
	text = re.sub(r"_+", "_", text)

	# Allow only alphanumerics + punctuation
	text = re.sub(rf"[^\w{re.escape(string.punctuation)}]+", "_", text)

	# Normalize hyphens to underscores
	text = re.sub(r"-+", "_", text)

	# Remove underscore around punctuation, collapse repeated punctuation
	punctuation = re.escape(string.punctuation)
	text = re.sub(rf"_([{punctuation}])", r"\1", text)
	text = re.sub(rf"([{punctuation}])_", r"\1", text)
	text = re.sub(r"([!.,?;:\-])\1+", r"\1", text)

	# Convert dots to underscores, strip trailing/leading underscores
	text = text.replace(".", "_").strip("_")

	# Lowercase result
	text = text.lower()

	# Ensure it’s never empty (optional)
	return text or "_"


def rename_file(old_name: str, old_abs_path: str) -> str:
	split_name: list[str] = old_name.rsplit(".", maxsplit=1)
	if len(split_name) == 2:
		return f"{format_string(split_name[0])}.{split_name[1]}".lower()
	else:
		return f"{format_string(split_name[0])}".lower()


def argparseInit() -> argparse.Namespace:
	parser: argparse.ArgumentParser = argparse.ArgumentParser(
		description="A tool for fixing ugly [ file / folder ] names",
	)

	parser.add_argument(
		"--dry-run", "-n",
		action="store_true",
		help="Show what would be changed without making any changes",
	)

	parser.add_argument(
		"--summary", "-s",
		action="store_true",
		help="Show what would be changed without making any changes",
	)

	parser.add_argument(
		"--force", "-f",
		action="store_true",
		help="Work with home user folder",
	)

	parser.add_argument(
		"--verbose", "-v",
		action="store_true",
		help="Enable verbose output"
	)

	parser.add_argument(
		"--ignore", "-i",
		nargs="+",
		help="Add file and folder you want ignore"
	)

	parser.add_argument(
		"paths",
		nargs="+",
		help="Files or directories to fix"
	)

	args = parser.parse_args()

	return args


# Setup logging add color to it
logging.basicConfig(
	level=logging.INFO,
	# format="\033[92m%(asctime)s\033[0m - %(levelname)s - %(message)s",
	format="%(message)s",
	datefmt="%Y-%m-%d %H:%M:%S"
)


IGNORE_PATH: list[str] = ["CMakeCache.txt", "CMakeLists.txt",]

HOME_PATH: str = os.getenv("HOME") or ""
USER_NAME: str = os.getenv("USER") or ""
PWD: str       =  os.getenv("PWD") or ""
IS_HOME: bool  = False

# Summary variables
RENAMED_HOME_ITEM:     int = 0
RENAMED_FILES_COUNT:   int = 0
SKIPPED_HIDDEN_COUNT:  int = 0
SKIPPED_IGNORED_COUNT: int = 0
RENAMED_FOLDERS_COUNT: int = 0


# Initialize arguments
args: argparse.Namespace = argparseInit()

for ignore_item in (args.ignore or []):
	IGNORE_PATH.append(ignore_item)

for path in args.paths:
	old_abs_path: str = os.path.abspath(path)

	if not os.path.exists(old_abs_path):
		logging.warning(f"Path does not exist: {old_abs_path}")
		continue

	old_dir_name: str = os.path.dirname(old_abs_path)
	old_base_name: str = os.path.basename(old_abs_path)

	if (old_base_name.startswith(".")):
		SKIPPED_HIDDEN_COUNT += 1
		if args.dry_run is True:
			logging.info(f"Skipping hidden file/folder: {old_abs_path}")
		continue


	# =============================================
	# todo: Use you Brain so hardo
	if (old_dir_name == HOME_PATH):
		if IS_HOME is False:
			IS_HOME = not IS_HOME
			# Tdo: Add summary option

		if args.force is not True:
			if args.dry_run is True:
				logging.warning("Refusing to work in home directory without --force")
		else:
			RENAMED_HOME_ITEM += 1
		continue
	# ======================================================

	# todo: Add git check here later

	for i in IGNORE_PATH:
		if (old_base_name == i):
			SKIPPED_IGNORED_COUNT += 1
			if args.dry_run is True:
				logging.info(f"Skipping ignored file/folder: {old_base_name}")
			continue

	if (os.path.isfile(old_abs_path)):
		if (new_file_base_name := rename_file(old_base_name, old_abs_path)) != old_base_name:
			new_abs_path: str = os.path.join(old_dir_name, new_file_base_name)

			if args.verbose is True:
				logging.info(f"Renamed file:   {old_base_name} → {new_file_base_name}")
			if args.dry_run is True:
				logging.warning(f"Renameding file: {old_base_name} → {new_file_base_name}")

			RENAMED_FILES_COUNT += 1

			if args.dry_run is not True:
				os.rename(old_abs_path, new_abs_path)

		elif args.dry_run is True:
			logging.info(f"No change for file: {old_base_name}")

	elif (os.path.isdir(old_abs_path)):
		if (new_folder_name := format_string(old_base_name)) != old_base_name:
			new_abs_path: str = os.path.join(old_dir_name, new_folder_name)

			if args.verbose is True:
				logging.info(f"Renamed folder: {old_base_name} → {new_folder_name}")
			if args.dry_run is True:
				logging.warning(f"Renameding folder: {old_base_name} → {new_folder_name}")

			RENAMED_FOLDERS_COUNT += 1

			if args.dry_run is not True:
				os.rename(old_abs_path, new_abs_path)

		elif args.dry_run is True:
			logging.info(f"No change for folder: {old_base_name}")

# summary option todo
if args.summary is True:
	print("\n===== Summary =====")
	print(f"Renamed files:          {RENAMED_FILES_COUNT}")
	print(f"Renamed folders:        {RENAMED_FOLDERS_COUNT}")
	print(f"Skipped hidden items:   {SKIPPED_HIDDEN_COUNT}")
	print(f"Skipped ignored items:  {SKIPPED_IGNORED_COUNT}")
	print(f"Renamed home items:     {RENAMED_HOME_ITEM}")
	print("=====================")

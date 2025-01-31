#!/usr/bin/python3

import os
import re  # Regular expression
from sys import argv

if os.getcwd() == os.getenv("HOME"):
	print("This is 'HOME' directory.\a")
	exit(1)

if(os.getenv("HOME") not in os.getcwd() and "/T7" not in os.getcwd()):
	print("This is 'ROOT' directory.\a")
	exit(1)


def get_max_len(file_content: list[str]) -> int:
	_file_content: str = sorted(file_content, key=len)[-1]
	return len(_file_content)


def formate_string(_text: str) -> str:
	_new_text: str = re.sub(r"[^\x00-\x7F]+", "", _text)
	_new_text: str = re.sub(r"_+", "_", _new_text)
	_new_text: str = re.sub(r" +", "_", _new_text)
	# _new_text: str = re.sub(r'(?<=\b\w)\.(?=\w\b)(?!\.\d)', "_", _new_text)

	for _i in list(r"!#$%&'()*,-./:;<=>?@[]^_`{|}~"):
		if f"_{_i}" in _new_text:
			_new_text: str = _new_text.replace(f"_{_i}", f"{_i}")

		if f"{_i}_" in _new_text:
			_new_text: str = _new_text.replace(f"{_i}_", f"{_i}")

		if f"{_i + _i}" in _new_text:
			_new_text: str = _new_text.replace(f"{_i + _i}", _i)

	return _new_text.removesuffix("_").removeprefix("_").lower().replace(".", "_")


def rename_file(old_name: str) -> str:
	split_name: list[str] = old_name.rsplit(".", maxsplit=1)
	return f"{formate_string(split_name[0])}.{split_name[1]}".lower()


def get_dict(_list_of_content: list[str]) -> dict:
	_result: dict = {}

	_file: int = 0
	_folder: int = 0
	_hidden_file: int = 0
	_hidden_folder: int = 0
	_unknown: int = 0
	_untouched: int = 0

	for _i in _list_of_content:
		if not _i.startswith("."):
			if os.path.isfile(_i):
				if _i.lower().startswith("readme"):
					_new_name: str = _i.split(".")[0].upper() + "." + _i.split(".")[1]
					if _i != _new_name:
						_result |= {_i: _new_name}
						_file += 1
					else:
						_untouched += 1
				elif _i.lower() == "makefile":
					_new_name: str = "Makefile"
					if _i != _new_name:
						_result |= {_i: _new_name}
						_file += 1
					else:
						_untouched += 1
				elif _i.lower() == "cmakelists.txt":
					_new_name: str = "CMakeLists.txt"
					if _i != _new_name:
						_result |= {_i: _new_name}
						_file += 1
					else:
						_untouched += 1
				elif "." in _i:
					file = rename_file(_i)
					_new_name: str = file
					if _i != _new_name:
						_result |= {_i: _new_name}
						_file += 1
					else:
						_untouched += 1
				else:
					_unknown += 1
			elif os.path.isdir(_i):
				_new_name: str = formate_string(_i)
				if _i != _new_name:
					_result |= {_i: _new_name}
					_folder += 1
				else:
					_untouched += 1
		else:
			_untouched += 1
			if os.path.isfile(_i):
				_hidden_file += 1
			else:
				_hidden_folder += 1

		_result |= {
			"int_value": {
				"total_rename": _file + _folder,
				"renamed_file": _file,
				"renamed_folder": _folder,
				"hidden": _hidden_file + _hidden_folder,
				"hidden_file": _hidden_file,
				"hidden_folder": _hidden_folder,
				"unknown": _unknown,
				"untouched": _untouched,
				"total": len(_list_of_content)
			}
		}
	return _result


all_file: list[str] = sorted(argv[1:])

if len(all_file) == 0:
	print("No file")
	exit(0)

new_name: dict = get_dict(all_file)
int_value: dict = new_name.pop("int_value")
keys_new_name: list[str] = list(new_name.keys())

if len(keys_new_name) == 0:
	print(f"Nothing to change in '{int_value.get('total')}' items.\a")
	exit(0)

if ".git" in os.listdir("."):
	maximum: int = get_max_len(keys_new_name)
	print("Sorry! This is a 'git-REPOSITORY'.\a")
	print(f" {int_value.get('renamed_file')} files, and {int_value.get('renamed_folder')} folder, will get effected.")
	for i in keys_new_name:
		print(f"  ● {i:{maximum}} 🠪 {new_name.get(i)}")

	if input("\nWants to continue? [y/n] ").casefold() != "y":
		print("ABORT RENAMING PWD\a")
		exit(0)
	else:
		print("\n")

for i in keys_new_name:
	os.rename(i, new_name.get(i))
	# print(i, new_name.get(i))

if len(all_file) >= 2:
	print(
		f"{'RENAMED:':13}{int_value.get('total_rename')}\n\t{'☶  File:':12}{int_value.get('renamed_file')}\n"
		f"\t{'󰉋  Folder:':12}{int_value.get('renamed_folder')}\n"
		f"{'HIDDEN:':13}{int_value.get('hidden')}\n\t{'☶  File:':12}{int_value.get('hidden_file')}\n"
		f"\t{'󰉋  Folder:':12}{int_value.get('renamed_folder')}\n\n"
		f"{'Untouched:':13}{int_value.get('untouched')}\n"
		f"{'Unknown:':13}{int_value.get('unknown')}\n"
		f"{'Total:':13}{int_value.get('total')}".expandtabs(1)
	)

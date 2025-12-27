#!/usr/bin/env -S python -u

from json import load
from pathlib import Path
from subprocess import run

SYNC_DATA: Path    = Path("~/.config/rclone/backup_scripts/sync_data.json").expanduser()
REMOTE_NAME: str   = "Gdrive"
REMOTE_FOLDER: str = "/rclone/Dhanno/"

if not SYNC_DATA.exists():
	print(f'Not found "{SYNC_DATA}" file')
	exit(1)

with SYNC_DATA.open() as f:
	SYNC_DATA_OBJECT: list[dict[str, str]] = load(f)

def sync(data: dict[str, str]) -> None:
	local: Path      = Path(data.get("local", "")).expanduser()
	remote_dir: str  = data.get("remote", "")
	remote_path: str = f"{REMOTE_NAME}:{REMOTE_FOLDER}{remote_dir}"

	print(f"---- {local} -> {remote_path}")
	run(
		[
			"rclone",
			"sync",
			"-Pv",
			local,
			remote_path
		]
	)

total_data: int = len(SYNC_DATA_OBJECT)
for idx, i in enumerate(SYNC_DATA_OBJECT):
	print(f"☁️  Syncing item {(idx + 1):> 2}/{total_data: 2}")
	sync(i)

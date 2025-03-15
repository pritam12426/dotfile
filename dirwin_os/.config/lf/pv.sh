#!/bin/sh

file_type=$(file --mime-type -b "$1")

if [[ $file_type == text/* ]]; then
	bat --paging=never --style=numbers --wrap=never --terminal-width $(($2-5)) -f "$1" || true
else
	exiftool -FileSize -FilePermissions -FileType -CreateDate -ModifyDate -TimeScale -Duration -TrackCreateDate -TrackModifyDate -MediaLanguageCode -HandlerType -ImageSize "$1"
fi

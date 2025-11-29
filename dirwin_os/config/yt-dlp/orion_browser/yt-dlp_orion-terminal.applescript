#!/usr/bin/osascript

tell application "Orion"
	activate
	set theURL to URL of current tab of first window
end tell

tell application "Terminal"
	activate

	-- If Terminal is not running, it will open a new window automatically
	if not (exists window 1) then
		do script "" -- opens a new window
		delay 0.3
	end if

	delay 0.3
	-- Run the command in the frontmost Terminal window/tab
	do script "/Users/pritam/.config/yt-dlp/orion_browser/yt-dlp_orion-terminal.sh " & quoted form of theURL in front window
end tell

return "Downloading → opened in Terminal"

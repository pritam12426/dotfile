#!/usr/bin/osascript

tell application "Orion"
    set theURL to URL of current tab of front window
end tell

tell application "Terminal"
	activate
	log "yt-dlp started → " & theURL
	do shell script "/Users/pritam/.config/yt-dlp/orion_browser/yt-dlp_with_orion_browser.sh " & quoted form of theURL
	log "yt-dlp done → " & theURL
end tell

return "Downloading with full yt-dlp output in Terminal"

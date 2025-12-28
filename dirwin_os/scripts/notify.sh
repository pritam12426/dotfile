#!/bin/bash


msg="$1"
title="${2:-Notification}"
type="${3:-info}" # info | error | log

# Check for --help option
if [[ $msg == "--help" ]]; then
	echo "Usage: notify <message> [title] [type]"
	echo "  <message>: The notification message to display."
	echo "  [title]:   Optional. The title of the notification. Default is 'Notification'."
	echo "  [type]:    Optional. The type of notification. Can be 'info', 'error', or 'log'. Default is 'info'."
	return 0
fi

# Choose sound based on type
sound="default"
case "$type" in
error)
	sound="Basso"
	;; # macOS built-in alert
log)
	sound="Pop"
	;; # subtle sound
info)
	sound="default"
	;; # generic notification
esac

# Send notification
osascript -e "display notification \"$msg\" with title \"$title\" sound name \"$sound\"" 2 &>/dev/null

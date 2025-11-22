#!/bin/bash

function notify() {
	local msg="$1"
	local title="${2:-Notification}"
	local type="${3:-info}" # info | error | log

	# Check for --help option
	if [[ $msg == "--help" ]]; then
		echo "Usage: notify <message> [title] [type]"
		echo "  <message>: The notification message to display."
		echo "  [title]:   Optional. The title of the notification. Default is 'Notification'."
		echo "  [type]:    Optional. The type of notification. Can be 'info', 'error', or 'log'. Default is 'info'."
		return 0
	fi

	# Choose sound based on type
	local sound="default"
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
}

function message() {
	local msg="$1"
	local title="${2:-Notification}"
	local type="${3:-info}"

	# Check for --help option
	if [[ $msg == "--help" ]]; then
		echo "Usage: message <message> [title] [type]"
		echo "  <message>: The notification message to display."
		echo "  [title]:   Optional. The title of the notification. Default is 'Notification'."
		echo "  [type]:    Optional. The type of notification. Can be 'info', 'error', or 'log'. Default is 'info'."
		return 0
	fi

	case "$type" in
	error)
		osascript -e "display alert \"$title\" message \"$msg\" as critical" 2 &>/dev/null
		;;
	warning)
		osascript -e "display alert \"$title\" message \"$msg\" as warning" 2 &>/dev/null
		;;
	info | *)
		osascript -e "display alert \"$title\" message \"$msg\" as informational" 2 &>/dev/null
		;;
	esac
}

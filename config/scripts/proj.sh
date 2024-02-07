#!/usr/bin/env bash

main() {
	if [[ $1 == "ta" ]]; then
		launch athena ~/Code/touramigo/athena-app && sleep 1
		launch hermes ~/Code/touramigo/hermes-app && sleep 1
		launch admin ~/Code/touramigo/admin-scripts
	fi

	if [[ $1 == "ib" ]]; then
		launch issuebear ~/Code/teamweb/issuebear
		launch mgmt ~/Code/teamweb/issuebear-management
	fi
}

function set-title() {
	echo -ne "\033]0;"$*"\007"
}

function launch() {
	title="$1"
	location="$2"

	if command -v kitty >/dev/null; then
		kitty @ launch --tab-title "$title" --type tab --cwd "$location" --keep-focus
	elif [[ "$TERM_PROGRAM" == "iTerm.app" ]]; then
		open -a iterm "$location"
		osascript \
		-e 'tell application "iTerm" to activate' \
		-e 'tell application "System Events" to tell process "iTerm" to keystroke "r" using {command down, shift down}' \
		-e "tell application \"System Events\" to tell process \"iTerm\" to keystroke \"${title}\"" \
		-e 'tell application "System Events" to tell process "iTerm" to key code 52'
	else
		echo "Unknown terminal, cannot open projects."
		exit 1
	fi
}

main $@

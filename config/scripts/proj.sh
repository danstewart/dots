#!/usr/bin/env bash

main() {
	if [[ $1 == "ta" ]]; then
		launch athena ~/tw/touramigo/athena-app
		launch hermes ~/tw/touramigo/hermes-app
		launch admin ~/tw/touramigo/admin-scripts
	fi

	if [[ $1 == "ib" ]]; then
		launch issuebear ~/tw/issuebear/issuebear
		launch mgmt ~/tw/issuebear/issuebear-management
	fi
}

function launch() {
	title="$1"
	location="$2"

	kitty @ launch --tab-title "$title" --type tab --cwd "$location" --keep-focus
}

main $@

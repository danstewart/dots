#!/usr/bin/bash

status=$(cat "$HOME/.timeout")
[[ -z $status ]] && status="on"

if [[ $1 == 1 ]]; then
	[[ $status == "on" ]] && status="off" || status="on"

	xset s $status
	echo $status > "$HOME/.timeout"
fi

echo "Timeout: $status"


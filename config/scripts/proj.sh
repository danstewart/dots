#!/usr/bin/env bash


if [[ $1 == "ta" ]]; then
	kitty @ launch --tab-title athena --type tab --cwd ~/tw/touramigo/athena-app
	kitty @ launch --tab-title hermes --type tab --cwd ~/tw/touramigo/hermes-app
	kitty @ launch --tab-title admin --type tab --cwd ~/tw/touramigo/admin-scripts
fi

if [[ $1 == "ib" ]]; then
	kitty @ launch --tab-title issuebear --type tab --cwd ~/tw/issuebear/issuebear
	kitty @ launch --tab-title mgmt --type tab --cwd ~/tw/issuebear/issuebear-management
fi

#!/usr/bin/env bash

# Installs the glow terminal markdown viewer
# https://github.com/charmbracelet/glow

DISTRO=$(cat /etc/os-release | grep "^ID=" | cut -d= -f2)

if [[ $DISTRO != 'fedora' ]]; then
    echo "This script only supports fedora"
    exit 1
fi

download_url=$(curl --silent https://api.github.com/repos/charmbracelet/glow/releases | jq --raw-output ".[0].assets[] | select(first(.name | endswith(\"_linux_amd64.rpm\"))) .browser_download_url")

echo "Downloading $download_url"
[[ -e /tmp/glow.rpm ]] && rm -f /tmp/glow.rpm
curl --silent -L "$download_url" --output /tmp/glow.rpm

echo "Installing glow"
sudo dnf install /tmp/glow.rpm

echo "Installed!"

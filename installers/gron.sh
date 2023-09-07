#!/usr/bin/env bash

# Installs the gron JSON parsing tool
# https://github.com/tomnomnom/gron

download_url=$(curl --silent https://api.github.com/repos/tomnomnom/gron/releases | jq --raw-output '.[0].assets[] | select(first(.name | contains("-linux-amd64"))) .browser_download_url')

echo "Downloading $download_url"
[[ -e /tmp/gron.tgz ]] && rm -f /tmp/gron.tgz
curl --silent -L "$download_url" --output /tmp/gron.tgz
tar -xf /tmp/gron.tgz -C ~/bin

echo "Installed!"


#!/usr/bin/env bash

# This script will download the latest version of the Github CLI and install it using DNF
# Requires:
# - curl
# - jq

function main() {
    DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}

    echo "Fetching latest compose binary..."
    download_file "docker-compose-linux-x86_64" $DOCKER_CONFIG/compose
    echo "Done! Now using $(docker compose version)."
}

function download_file() {
    file_end="$1"
    location="$2"

    download_url=$(curl --silent https://api.github.com/repos/docker/compose/releases | jq --raw-output ".[0].assets[] | select(first(.name | endswith(\"$file_end\"))) .browser_download_url")

    if [[ -z $download_url || $download_url == "" ]]; then
        echo "Failed to fetch download URL for '$file_end'"
        exit 1
    fi

    [[ -f "$location" ]] && rm -f "$location"
    curl --silent -L "$download_url" --output "$location"
}

main


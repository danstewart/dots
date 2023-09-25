#!/usr/bin/env bash

# This script will download the latest version of docker compose and put it in the docker plugins directory
# Requires:
# - curl
# - jq

function main() {
    DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
    mkdir -p $DOCKER_CONFIG/cli-plugins

    echo "Fetching latest compose binary..."
    download_file "docker-compose-linux-$(uname -m)" $DOCKER_CONFIG/cli-plugins/docker-compose
    chmod 755 $DOCKER_CONFIG/cli-plugins/docker-compose
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


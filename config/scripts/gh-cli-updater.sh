#!/usr/bin/env bash

# This script will download the latest version of the Github CLI and install it using DNF
# Requires:
# - curl
# - jq
# - dnf
# - sha256sum
# - sudo

function main() {
    echo "Fetching checksums..."
    download_file "checksums.txt" /tmp/gh-cli-checksums.txt

    echo "Fetching latest RPM..."
    download_file "_linux_amd64.rpm" /tmp/gh-cli.rpm

    echo "Validating checksum..."
    sum=$(sha256sum /tmp/gh-cli.rpm | awk '{print $1}')

    if ! grep -q "$sum" /tmp/gh-cli-checksums.txt; then
        echo "Checksum validation failed!"
        exit 1
    fi

    echo "Installing..."
    sudo dnf install -y /tmp/gh-cli.rpm
    echo "Done!"
}

function download_file() {
    file_end="$1"
    location="$2"

    download_url=$(curl --silent https://api.github.com/repos/cli/cli/releases | jq --raw-output ".[0].assets[] | select(first(.name | endswith(\"$file_end\"))) .browser_download_url")

    if [[ -z $download_url || $download_url == "" ]]; then
        echo "Failed to fetch download URL for '$file_end'"
        exit 1
    fi

    [[ -f "$location" ]] && rm -f "$location"
    curl --silent -L "$download_url" --output "$location"
}

main

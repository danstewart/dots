#!/usr/bin/env bash

pattern="$1"

if [[ $pattern == "--help" || -z $pattern ]]; then
    echo "Usage: $0 <pattern>"
    echo ""
    echo "Removes all running docker containers matching the given pattern."
    exit 0
fi

echo "Removing docker containers matching $pattern..."
docker container ls --filter name="$pattern" --format json | jq --raw-output '.Names' | xargs docker rm -f
echo "Done."

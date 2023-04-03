#!/usr/bin/env bash

pattern="$1"

if [[ $pattern == "--help" || -z $pattern ]]; then
    echo "Usage: $0 <pattern>"
    echo ""
    echo "Removes all running docker containers matching the given pattern."
    echo "See https://docs.docker.com/engine/reference/commandline/ps/#filter"
    exit 0
fi

echo "Removing docker containers matching $pattern..."
docker container ls --filter $pattern --format json | jq --raw-output '.Names' | xargs docker rm -f
echo "Done."

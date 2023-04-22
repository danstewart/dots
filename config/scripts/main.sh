#!/usr/bin/env bash

# Git main branch helper

subcommand="$!"

# Settings
merge=0
stash=0
help=0

# Arg parse
while [[ "$#" -gt 0 ]]; do
	case "$1" in
		--merge) merge=1 ;;
		--stash) stash=1 ;;
		-h|--help) help=1 ;;
		--) shift; break ;;
	esac

	shift
done

if [[ -z $subcommand || $help == 1 ]]; then
    echo "$0 <command> [--merge] [--stash]"
    echo ""
    echo "Commands:"
    echo "  merge"
fi

# Run the subcommand
if command -v $subcommand >/dev/null 2>&1; then
    args=""

    # Run the command
    $subcommand "$@"
else
    echo "Unknown subcommand: $subcommand"
    exit 1
fi

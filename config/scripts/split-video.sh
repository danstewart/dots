#!/usr/bin/env bash

# Requires:
# - ffmpeg

set -euo pipefail

help=0
input=""
output=""
start=""
end=""
while [[ "$#" -gt 0 ]]; do
	case "$1" in
		--input) input=$2; shift ;;
        --output) output=$2; shift ;;
        --start) start=$2; shift ;;
        --end) end=$2; shift ;;
		-h|--help) help=1 ;;
		--) shift; break ;;
	esac

	shift
done

if [[ -n $help || -z $input || -z $output || -z $start || -z $end ]]; then
    echo "$0 --input <file> --output <file> --start <timestamp> --end <timestamp>"
    echo ""
    echo "Cut up a video into a smaller video at set timestamps"
    echo ""
    echo "--input:  Path to the original video file"
    echo "--output: Path to the new video file"
    echo "--start:  The start time stamp in the format 00:00:00"
    echo "--end:    The end time stamp in the format 00:00:00"

    exit 1
fi

ffmpeg -ss "$start" -to "$end" -i "$input" -c copy "$output"

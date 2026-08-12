#!/usr/bin/env bash

# Requires:
# - jq
# - git
# - GitHub CLI
# - perl

set -euo pipefail

help=0
simple=0
project=""
since=""
while [[ "$#" -gt 0 ]]; do
	case "$1" in
		--project) project=$2; shift ;;
        --since) since=$2; shift ;;
        --simple) simple=1 ;;
		-h|--help) help=1 ;;
		--) shift; break ;;
	esac

	shift
done

if [[ $help == 1 || -z $project || -z $since ]]; then
    echo "Usage: $0 --project <project> --since <commit>"
    echo ""
    echo "Generates a changelog from git history"
    echo ""
    echo "--project: The path to the git project locally"
    echo "--since:   The commit to start the changelog from"
    echo "--simple:  Only print out the change commit lines"

    exit 1
fi

cd "$project"
rows="$(git log --oneline --decorate $since..main)"

repo=""
origin="$(git config --get remote.origin.url)"
if [[ "$origin" =~ github.com:(.*).git ]]; then
    repo="${BASH_REMATCH[1]}"
fi

# Regex patterns
re_commit_hash="^([a-z0-9]{8})\s"
re_pr="\s*\(#([0-9]+)\)"
re_shortcut_link="(https:\/\/app\.shortcut\.com\/[a-z0-9-]+\/story\/[0-9]+)"

# Go through each log row and format as markdown
formatted=()
while IFS= read -r line; do
    if [[ $simple == 1 ]]; then
        echo "$line"
        continue
    fi

    formatted+=("## $line\n\n")

    if [[ "$line" =~ ${re_commit_hash} ]]; then
        formatted+=("Commit: \`#${BASH_REMATCH[1]}\`  \n")
    fi

    if [[ "$line" =~ ${re_pr} ]]; then
        pr_number="${BASH_REMATCH[1]}"
        if [[ -n "$repo" ]]; then
            formatted+=("PR: https://github.com/${repo}/pull/${pr_number}  \n")
        fi

        story_comment="$(gh pr view ${pr_number} --comments --json comments | jq -r '.comments[] | select(.author.login == "shortcut-integration") | .body')"
        if [[ $story_comment =~ $re_shortcut_link ]]; then
            shortcut_link="${BASH_REMATCH[1]}"
            formatted+=("Story: ${shortcut_link}  \n")
        fi

        # Grab initial comment on PR
        initial_comment="$(gh pr view ${pr_number} --json body | jq -r '.body')"

        # Resize headers to be smaller
        initial_comment="${initial_comment//##/####}"

        # Throw away the reminder section
        initial_comment=$(echo "$initial_comment" | perl -0pe 's/#### Reminder.*$//gsm')

        formatted+=("\n$initial_comment\n")
    fi

    formatted+=("\n---\n\n")
done <<< "$rows"

echo -e "${formatted[*]}" | perl -p -e 's/^\s+([^\s])/$1/g'

#!/usr/bin/env bash

# Spit out a random timeflake UUID

count="$1"
[[ -z $count ]] && count=1

python3 -c "import timeflake" >/dev/null 2>&1
if [[ $? != 0 ]]; then
	echo "Timeflake is not installed, install? [Y/N] "
	read -r install
	
	[[ "$install" != "y" && "$install" != "Y" ]] && exit 0
	pip3 install timeflake
fi

for (( i=0; i<count; i++ )); do
	python3 -c "import timeflake; print(timeflake.random().hex.lower())"
done

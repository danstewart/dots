#!/usr/bin/env bash

# Usage
# --
# ./xmlformat.sh file.xml [ gedit ]
# ./xmlformat.sh ./glob/*.xml [ gedit ]
#
# Description
# --
# Trims leading hyphens and formats XML documents
# The 2nd argument will print the output instead of updating the file.

#gedit=$2

while [[ $1 ]]; do
  tidied=$(perl -p -e 's/^(-|\s)//g' $1 | tidy -xml -i -q -w 0)

  if [[ -n $gedit ]]; then
  	printf "$tidied";
  else 
  	printf "$tidied" > /tmp/tmp.xml
  	[[ $(cat /tmp/tmp.xml) != "" ]] && mv /tmp/tmp.xml $1
  fi

  shift
done


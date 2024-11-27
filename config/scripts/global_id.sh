#!/usr/bin/env bash

# Decode
if [[ $# == 1 ]]; then
    printf $1 | base64 --decode

# Encode
else
    printf "$1:$2" | base64
fi

#!/usr/bin/env bash

# Decode
if [[ $# == 1 ]]; then
    printf $1 | base64 --decode

# Encode
elif [[ $# == 2 ]]; then
    printf "$1:$2" | base64

else
    echo "Usage:"
    echo "   global_id.sh <ModelName> <ID>        Encodes a model name and ID into a global ID"
    echo "   global_id.sh <GlobalID>              Decodes a global ID into a model name and ID"
fi

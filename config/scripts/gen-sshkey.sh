#!/usr/bin/env bash

EMAIL="$1"
FILENAME="$2"

[[ -z $EMAIL ]] && { echo "./$0 <email> [filename]"; exit 1; }
[[ -z $FILENAME ]] && FILENAME="id_rsa"

ssh-keygen -t rsa -b 4096 -C "$EMAIL" -f "$HOME/.ssh/$FILENAME" -N ''
eval "$(ssh-agent -s)"
ssh-add "$HOME/.ssh/$FILENAME"
cat "$HOME/.ssh/${FILENAME}.pub"


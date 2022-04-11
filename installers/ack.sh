#!/usr/bin/env bash

set -e

[[ ! -d ~/bin ]] && mkdir ~/bin
curl --silent https://beyondgrep.com/ack-v3.5.0 -o ~/bin/ack
chmod 0755 ~/bin/ack

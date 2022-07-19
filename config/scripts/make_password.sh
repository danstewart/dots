#!/usr/bin/env bash

# Spit out a random secure password

length="${1:-32}"

pwgen --secure --symbols --num-passwords=1 $length

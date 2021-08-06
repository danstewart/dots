#!/usr/bin/env bash

set -e

curl --silent https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy -o ~/bin/diff-so-fancy
chmod 0755 ~/bin/diff-so-fancy

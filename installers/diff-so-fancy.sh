#!/usr/bin/env bash

set -e

[[ ! -d ~/bin ]] && mkdir ~/bin
[[ ! -d ~/bin/lib ]] && mkdir ~/bin/lib
curl --silent https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/diff-so-fancy -o ~/bin/diff-so-fancy
curl --silent https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/lib/DiffHighlight.pm -o ~/bin/lib/DiffHighlight.pm
chmod 0755 ~/bin/diff-so-fancy

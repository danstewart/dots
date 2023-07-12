#!/usr/bin/env bash

# Run a git diff through difft and upload to seashells.io for easy sharing
# NOTE: Will only persist for 1 day
DFT_COLOR=always GIT_EXTERNAL_DIFF=difft git --no-pager diff $@ | nc seashells.io 1337

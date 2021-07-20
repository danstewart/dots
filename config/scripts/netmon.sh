#!/usr/bin/env bash

# Monitors all outgoing network requests to ports 80 or 443
sudo tcpdump -i wlo1 dst port 80 or port 443


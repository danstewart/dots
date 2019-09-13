#!/usr/bin/env bash

mount_to=$1
quiet=$2
[[ -z $mount_to || $mount_to =~ 'help' ]] && { echo "Usage: rmnt mount_point"; exit; }

function say() {
  string=$1
  [[ -z $quiet ]] && echo $string
}

if [[ $(stat -c %U $mount_to ) == 'root' && $(whoami) != 'root' ]]; then
    say "$mount_to was mounted as root, rerun me with sudo"
    exit 1;
fi

# Unmount server and delete $mntdir
if [[ -e "$mount_to" ]]; then
  fusermount -u "$mount_to" 
  rmdir "$mount_to"
  say "$mount_to has been disconnected"
else
  say "$mount_to does not exist, nothing to do"
fi


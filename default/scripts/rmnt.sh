#!/usr/bin/env bash

server=$1
mount_point=$2
mount_to=$3
sudo=$4
user=$(who am i | awk '{print $1}')

if [[ -z $mount_point || -z $mount_to || $server =~ 'help' ]]; then
	echo "Usage: ./rmnt.sh <server> <mount point> <mount to> [sudo]"
	exit 1
fi

# Remove this mount if it exists
if [[ -e $mount_to ]]; then
	echo "$mount_to exists: Calling runmnt.sh"
  /home/dstewart/scripts/runmnt.sh $mount_to quiet
fi

if [[ ! -d $mount_to ]]; then
    mkdir $mount_to
	
    sshfs -o allow_other -oIdentityFile=/home/dstewart/.ssh/id_rsa ${user}@${server}:$mount_point $mount_to

else
  echo "$mount_to already exists, is it stuck? Try running: fusermount -u $mount_to, or sudo umount -l $mount_to"
fi

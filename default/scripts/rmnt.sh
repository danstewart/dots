#!/usr/bin/env bash

server=$1
[[ -z $server || $server =~ 'help' ]] && { echo "Usage: rmnt server mount_point mount_to [user]"; exit; }

mount_point=$2
mount_to=$3
sudo=$4
user=$(who | awk '{print $1}')

# Remove this mount if it exists
if [[ -e $mount_to ]]; then
    /home/dstewart/scripts/rumnt.sh $mount_to 'quiet'
fi

if [[ ! -d $mount_to ]]; then
    mkdir $mount_to
	
	# NOTE: Can't remember why I added this but it doesn't work with playground...
    #if [[ $(whoami) == 'root' ]]; then
        #sudo sshfs -o sftp_server="/usr/bin/sudo /usr/lib/openssh/sftp-server" -o allow_other -oIdentityFile=/home/dstewart/.ssh/id_rsa ${user}@${server}:$mount_point $mount_to
    #else
        sshfs -o allow_other -oIdentityFile=/home/dstewart/.ssh/id_rsa ${user}@${server}:$mount_point $mount_to
    #fi 

else
  echo "$mount_to already exists, is it stuck? Try fusermount -u $mount_to"
fi

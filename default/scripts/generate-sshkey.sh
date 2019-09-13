#!/usr/bin/env bash

server=$1
user=$(whoami)

# Generate a key if we don't have one
if [[ ! -f  "$HOME/.ssh/id_rsa.pub" ]]; then
	echo "Generating an SSH key"
	ssh-keygen -t rsa -N ""
fi

# Copy the key to the server
cat "$HOME/.ssh/id_rsa.pub" | ssh "$user@${server}" '
  [[ ! -d "$HOME/.ssh" ]] && mkdir -p "$HOME/.ssh"; 
  cat >> "$HOME/.ssh/authorized_keys"; 
  chmod 700 "$HOME/.ssh"; 
  chmod 740 "$HOME/.ssh/authorized_keys";
'

echo "Finished, try running 'ssh $user@$server' and you shouldn't need a password"

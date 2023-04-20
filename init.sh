#!/usr/bin/env bash

# Does some fresh system set up

# Figure out our distro
DISTRO=$(cat /etc/os-release | grep "^ID=" | cut -d= -f2)

# First install some dependency packages we need
if [[ $DISTRO == 'ubuntu' || $DISTRO == 'elementary' || $DISTRO == 'debian' ]]; then
	sudo apt-get install -qq -y libjson-perl
elif [[ $DISTRO == 'fedora' ]]; then
	sudo dnf install -y perl-JSON
elif [[ $DISTRO == 'arch' ]]; then
	sudo pacman --noconfirm -S perl-json
else
	echo "Unsupported distro '$DISTRO'"
	exit 1
fi

# Install misc commands
[[ ! -d ~/bin ]] && mkdir ~/bin
for installer in ./installers/*; do
	prog_name=$(basename $installer .sh)
	echo "Installing $prog_name"
	bash $installer
done

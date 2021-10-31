#!/usr/bin/env bash

# Does some fresh system set up

# Figure out our distro
DISTRO=$(cat /etc/os-release | grep "^ID=" | cut -d= -f2)

# First install some common packages we need
# TODO: Check $DISTRO on Fedora and Arch/Manjaro
if [[ $DISTRO == 'ubuntu' || $DISTRO == 'elementary' ]]; then
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

# apt programs
if [[ $DISTRO == 'ubuntu' ]]; then
	sudo apt-get -qq -y update && sudo apt-get -qq -u upgrade
	sudo apt-get install -qq -y git curl vim fzf gnupg2 jq python3-venv python3-pip bat fd-find npm fzf
	sudo npm -g --silent install tldr
fi

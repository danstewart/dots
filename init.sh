#!/usr/bin/env bash

# Does some fresh system set up

# Figure out our distro
DISTRO=$(cat /etc/os-release | grep "^ID=" | cut -d= -f2)

# First install some common packages we need
# TODO: Check $DISTRO on Fedora and Arch/Manjaro
if [[ $DISTRO == 'ubuntu' ]]; then
	sudo apt-get install -y libjson-perl git vim
elif [[ $DISTRO == 'fedora' ]]; then
	sudo dnf install -y perl-JSON git vim
elif [[ $DISTRO == 'arch' ]]; then
	sudo pacman --noconfirm -S perl-json git vim
else
	echo "Unsupported distro '$DISTRO'"
	exit 1
fi

# Install misc commands
mkdir ~/bin
curl https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy -o ~/bin/diff-so-fancy && chmod 0755 ~/bin/diff-so-fancy
curl https://beyondgrep.com/ack-v3.5.0 -o ~/bin/ack && chmod 0755 ~/bin/ack

# apt programs
if [[ $DISTRO == 'ubuntu' ]]; then
	sudo apt-get -y update && sudo apt-get -u upgrade
	sudo apt-get install -y git curl vim fzf gnupg2 jq python3-venv python3-pip bat fd-find npm fzf
	sudo npm -g install tldr
fi

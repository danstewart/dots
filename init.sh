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

# Install diff-so-fancy
mkdir ~/bin
curl -o ~/bin/diff-so-fancy https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy
chmod 755 ~/bin/diff-so-fancy

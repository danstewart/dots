#!/usr/bin/perl

use strict;
use warnings;
use feature qw/say/;
use File::Basename qw/fileparse/;
use File::Path qw/make_path remove_tree/;
use Cwd;

# TODO:
# - Use Getopt::Long
# - Add arg to pick which files to link
# - Improve file sharing (eg. work and windows have the same bash_aliases but the file is duplicated)

# List of machines this script is used for
my @machines = (
	'fedora',    # Fedora 29 personal machine (using neovim)
	'other',     # Other machine (using vim instead of neovim)
	'traveltek', # Misc traveltek servers
);

# Build regex
my $regex = join('|', map { qq|^${_}\$| } @machines);

my $home      = $ENV{HOME};
my ($machine) = grep { $regex } @ARGV;
my $force     = grep { /--force/ } @ARGV;

die("Needs machine arg (" . join(", ", @machines) . ")")unless $machine;

# Links shared across all machines
my %commonlinks = (
	# Bash
	"bash/bashrc"        => "$home/.bashrc",
	"bash/bash_aliases"  => "$home/.bash_aliases",
	"bash/sensible.bash" => "$home/.sensible.bash",

	# Misc
	"gitconfig"  => "$home/.gitconfig",
	"dircolors"  => "$home/.dircolors",
	"ssh/config" => "$home/.ssh/config",

	# scripts
	"scripts/" => "$home/scripts"
);

# Machine link mapping
my %links = (
	# Personal linux machine
	fedora => {
		%commonlinks,
		"prettierrc" => "$home/.prettierrc",
		"nvimrc" => "$home/.config/nvim/init.vim",
		"redshift.conf" => "$home/.config/redshift.conf",
	},

	# Core config files to be used for servers
	traveltek => {
		%commonlinks,
		"vim/vimrc" => "$home/.vimrc"
	},

	# Other machines
	other => {
		%commonlinks,
		"nvimrc" => "$home/.config/nvim/init.vim",
	},
);

# Go through our links hash and symlink them into the correct places
while (my ($file, $target) = each %{$links{$machine}}) {
	# Use file in machine dir and fallback to default file
	$file = find_file($machine, $file) || next;

	# Delete existing target
	unlink $target if $force and -f $target;
	unlink $target if -l $target;

	# If the target still exists then we want to keep it
	if (-e $target) {
		say "$target already exists - skipping";
		next;
	}

	# Create target path if it doensn't exist
	my ($name, $path) = fileparse($target);
	make_path($path) unless -e $path;

	symlink($file, $target) or say "Error creating symlink $target: $!";
}

# If sublime is installed and Dropbox is setup then copy our config file
my $sublime = "$home/.config/sublime-text-3";
if (-e $sublime && -e "$home/Dropbox") {
	# Link our config to Dropbox if not already done
	if (! -l "$sublime/Packages/User") {
		remove_tree("$sublime/Packages/User/");
		symlink("/home/Dropbox/Sublime3/User", "$sublime/Packages/User");
	}
}

sub file_type {
	my ($path) = @_;

	return 'link' if -l $path;
	return 'file' if -f $path;
	return 'dir' if -d $path;

	return;
}

sub find_file {
	my ($machine, $file) = @_;

	my $cwd = getcwd();
	my @options = ("$home/dots/$machine/$file", "$home/dots/default/$file", "$cwd/$machine/$file", "$cwd/default/$file");

	foreach my $file (@options) {
		if (-e $file) {
			return $file;
		}
	}

	return;
}

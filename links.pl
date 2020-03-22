#!/usr/bin/env perl

use strict;
use warnings;
use feature qw/say/;
use File::Basename qw/fileparse/;
use File::Path qw/make_path remove_tree/;
use Cwd;
use Data::Dumper;

# TODO:
# - Use Getopt::Long
# - Add arg to pick which files to link
# - Add help text
# - Create logic for files pulling from each other (eg. bashrc.base which adds in bashrc.local - or something)

# List of machines this script is used for
my @machines = (
	'local',    # Local fedora machine
	'remote',   # My Servers
	'work',     # Work servers
);

# Build regex
my $regex = join('|', map { qq|^${_}\$| } @machines);

my $home      = $ENV{HOME};
my ($machine) = grep { $regex } @ARGV;
my $force     = grep { /--force/ } @ARGV;

die("Needs machine arg (" . join(", ", @machines) . ")")unless $machine;

#------------

# Setup the symlinks from the dots repo
setup_links($machine, Source->new('Git'));

# If running on local machine then try get dots from Dropbox too
if ($machine eq 'local' && -d "$home/Dropbox") {
	setup_links($machine, Source->new('Dropbox'));
}

#------------

sub setup_links {
	my ($machine, $source) = @_;

	my %links = Links::load($machine, $source);

	# Go through our links hash and symlink them into the correct places
	while (my ($file, $target) = each %links) {
		# Use file in machine dir and fallback to default file
		$file = find_file($machine, $file, $source) || next;

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
}

sub file_type {
	my ($path) = @_;

	return 'link' if -l $path;
	return 'file' if -f $path;
	return 'dir' if -d $path;

	return;
}

sub find_file {
	my ($machine, $file, $source) = @_;
	$source ||= Source->new('Git');

	my $cwd = getcwd();
	my @options = ("$source->{path}/$machine/$file", "$source->{path}/default/$file", "$cwd/$machine/$file", "$cwd/default/$file");

	foreach my $file (@options) {
		if (-e $file) {
			return $file;
		}
	}

	return;
}


package Links;

	# Returns the links needed for a specific machine
	sub load {
		my ($machine, $source) = @_;

		if ($source->{name} eq 'Dropbox') {
			return Links::dropbox();
		}

		my %links = (
			# Local machine
			local => {
				Links::common(),
				"prettierrc" => "$home/.prettierrc",
				"nvimrc" => "$home/.config/nvim/init.vim",
				"redshift.conf" => "$home/.config/redshift.conf",
			},

			# Core config files to be used for servers
			remote => {
				Links::common(),
				"vim/vimrc" => "$home/.vimrc"
			},
		);

		return %{$links{$machine}};
	}

	# Links added to all machines
	sub common {
		return (
			# Bash
			"bash/bashrc"        => "$home/.bashrc",
			"bash/bash_aliases"  => "$home/.bash_aliases",
			"bash/sensible.bash" => "$home/.sensible.bash",

			# Misc
			"gitconfig" => "$home/.gitconfig",
			"dircolors" => "$home/.dircolors",

			# scripts
			"scripts/" => "$home/scripts",
		);
	}

	# Links that are stored in Dropbox
	sub dropbox {
		return (
			"ssh/config" => "$home/.ssh/config",
		);
	}

1;


package Source;

sub new {
	my $class  = shift;
	my $source = shift || 'Git';

	my %sources = (
		'Git' => {
			path => "$ENV{HOME}/dots",
			name => 'Git',
		},
		'Dropbox' => {
			path => "$ENV{HOME}/Dropbox/dots",
			name => 'Dropbox',
		}
	);

	if (not exists $sources{$source}) {
		die "Invalid source '$source' provided";
	}

	return bless $sources{$source}, $class;
}

1;

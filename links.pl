#!/usr/bin/env perl

use strict;
use warnings;
use lib './src';
use feature qw{say};

use Linker;
use ConfigBuilder;
use Util qw{parse_jsonc script_dir};
use Data::Dumper;

my $CONFIG_FILE = script_dir() . "/config.jsonc";

my $args = arg_parse(@ARGV);
my $tags = $args->{tags} || [];

if (scalar @$tags == 0) {
	say 'Usage: ./links.pl --tag1 --tag2 [--force] [--test]';
	say '--tag:   The tag(s) you want to link (from config.jsonc)';
	say '--force: Overwrite existing files';

	exit 0;
}

my $config  = parse_jsonc($CONFIG_FILE);
my $builder = ConfigBuilder->new;

# Go through all tags we want to set up links for
foreach my $tag (@$tags) {
	if (not exists $config->{$tag}) {
		say "WARNING: Tag '$tag' not found in config.jsonc";
		next;
	}

	# Handles includes
	unwrap_includes($config, $tag);

	# Add this section into our config builder
	$builder->push($config->{$tag});
}

# Load the config and create the symlinks
Linker
	->new($builder->get)
	->force($args->{force})
	->test($args->{test})
	->create;


# Unwraps the 'include' references into the raw config
# Takes the full $config and the current $tag
sub unwrap_includes {
	my ($config, $tag) = @_;

	my $includes = delete $config->{$tag}->{'&include'};

	# Load any &include sections
	if ($includes) {
		$includes = [ $includes ] if ref $includes ne 'ARRAY';

		foreach my $inc (@$includes) {
			if (not exists $config->{$inc}) {
				say "WARNING: Attempted to &include '$inc' but it does not exist";
				next;
			}

			# Recurse to resolve nested includes
			unwrap_includes($config, $inc);

			# Add this into the config
			$builder->push($config->{$inc}, 1);
		}
	}
}

# Parses args... shock!
sub arg_parse {
	my (@args) = @_;

	my %flags = ( force => 0, test => 0);
	my @tags  = ();

	foreach my $arg (@args) {
		$arg =~ s/^--//g;

		if (exists $flags{$arg}) {
			say "Enabling '$arg' mode";
			$flags{$arg} = 1;
			next;
		}

		push @tags, $arg;
	}

	return {
		%flags,
		tags => \@tags,
	};
}

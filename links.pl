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
	say 'Usage: ./links.pl --tag1 --tag2 [--force]';
	say '--tag:   The tag(s) you want to link (from config.jsonc)';
	say '--force: Overwrite existing files';

	exit 0;
}

my $config  = parse_jsonc($CONFIG_FILE);
my $builder = ConfigBuilder->new;

# Go through all tags we want to set up links for
foreach my $tag (@$tags) {
	next unless exists $config->{$tag};

	my $includes = delete $config->{$tag}->{'&include'};

	# Add this section into our config builder
	$builder->push($config->{$tag});

	# Load any &include sections
	if ($includes) {
		$includes = [ $includes ] if ref $includes ne 'ARRAY';

		foreach my $inc (@$includes) {
			if (not exists $config->{$inc}) {
				say "WARNING: Attempted to &include '$inc' but it does not exist";
				next;
			}

			$builder->push($config->{$inc}, 1);
		}
	}
}

# Load the config and create the symlinks
Linker->new($builder->get)->force($args->{force})->create;


sub arg_parse {
	my (@args) = @_;

	my $force = 0;
	my @tags  = ();

	foreach my $arg (@args) {
		$arg =~ s/^--//g;

		if ($arg eq 'force') {
			$force = 1;
			next;
		}

		push @tags, $arg;
	}

	return {
		force => $force,
		tags  => \@tags,
	};
}

package Util;

use strict;
use warnings;

require Exporter;
our @ISA = qw{Exporter};
our @EXPORT_OK = qw{parse_json script_dir};

sub script_dir {
	require Cwd;
	require File::Basename;
	return File::Basename::dirname(Cwd::abs_path($0));
}

sub parse_json {
	my ($filepath) = @_;

	my $file_contents = do {
		open my $fh, '<', $filepath or die "Failed to open config file: $!";
		local $/;
		<$fh>;
	};

	require JSON;
	my $config = JSON->new->relaxed->decode($file_contents);
	return $config;
}

1;

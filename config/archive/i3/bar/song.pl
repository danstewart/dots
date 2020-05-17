#!/usr/bin/perl

use strict;
use warnings;

exit unless `pidof spotify`;

my $click = shift || 0;
`playerctl play-pause` if $click == 1;

my %data;
my @fields = ("metadata title", "metadata artist", "status");
foreach (@fields) {
	my $x     = `playerctl $_` =~ s/\n//r;
	$x        = substr($x, 0, 45) =~ s/\s+$//r . "..." if length $x > 45;
	$data{$_} = $x;
}

print "$data{'metadata title'} - $data{'metadata artist'}  ";
print $data{status} eq "Playing" ? "" : "";

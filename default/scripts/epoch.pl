#!/usr/bin/perl
use feature qw/say/;
my $stamp = $ARGV[0] || time;
say scalar localtime $stamp;

#!/usr/bin/env perl

use strict;
use warnings;
use POSIX qw/strftime/;

my $click   = $ENV{BLOCK_BUTTON} || 0;
my $format  = $ENV{BLOCK_INSTANCE};
my $tz_file = shift || "$ENV{HOME}/.tz";

my $current_tz;
my $default_tz = get_default_tz();
if ($click == 1) {
	$current_tz = get_tz();

	# List of timezones. Make sure the list loops back to itself.
	# Entries must be present in /usr/share/zoneinfo (Olson DB).
	my %tzmap = (
		""                   => $default_tz,
		$default_tz          => "Australia/Brisbane",
		"Australia/Brisbane" => "Pacific/Auckland",
		"Pacific/Auckland"   => "Brazil/East",
		"Brazil/East"        => "Asia/Calcutta",
		"Asia/Calcutta"      => $default_tz,
	);

	if (exists $tzmap{$current_tz}) {
		set_tz($tzmap{$current_tz});
		$current_tz = $tzmap{$current_tz};
	}
}

# How each timezone will be displayed in the bar.
my %display_map = (
	$default_tz          => "UK",
	"Brazil/East"        => "Brazil",
	"Australia/Brisbane" => "AU",
	"Pacific/Auckland"   => "NZ",
	"Asia/Calcutta"      => "Hyderabad",
);

$ENV{TZ}       = $current_tz || get_tz();
my $tz_display = $display_map{$ENV{TZ}} || $ENV{TZ};

my $time = $format ? strftime($format, localtime()) : localtime();
print "$time ($tz_display)";


sub get_tz {
	my $current_tz;

	if (-f "$ENV{HOME}/.tz") {
		open my $fh, '<', $tz_file;
		$current_tz = <$fh>;
		chomp $current_tz;
		close $fh;
	}

	return $current_tz || get_default_tz();
}

sub set_tz {
	my $tz = shift;

	open my $fh, '>', $tz_file;
	print $fh $tz;
	close $fh;
}

sub get_default_tz {
	my $tz = "Europe/London";

	if (-f "/etc/timezone") {
		open my $fh, '<', "/etc/timezone";
		$tz = <$fh>;
		chomp $tz;
		close $fh;
	} elsif (-l "/etc/localtime") {
		$tz = readlink "/etc/localtime";
		$tz = (split /zoneinfo\//, $tz)[-1];
	}

	return $tz;
}

#!/usr/bin/perl

use strict;
use warnings;

my $click = shift || 0;
my $icon;

my %clickmap = (1 => "pactl set-sink-mute 1 toggle", 4 => "pactl set-sink-volume 1 +5%", 5 => "pactl set-sink-volume 1 -5%");
`$clickmap{$click}` if $click;

my ($volume, $status) = ($1, $2) if (`amixer get Master` =~ /\[(\d+)%\]\s+\[(\w+)\]/);
$icon = "" if $status eq "off";
$icon ||= $volume >= 75 ? "" : "";
print "$icon $volume%";

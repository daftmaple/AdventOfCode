#!/usr/bin/perl
use strict;
use warnings;

open F, "q12_input.txt" or die;
chomp(my @nav = <F>);
close F;

my $x = 0;
my $y = 0;

# Use degree in maths
my $deg = 0;

foreach my $move (@nav) {
    my ($dir, $dig) = $move =~ /(\w)(\d+)/;

    if ($dir eq 'N') {
        $y += $dig;
    } elsif ($dir eq 'S') {
        $y -= $dig;
    } elsif ($dir eq 'E') {
        $x += $dig;
    } elsif ($dir eq 'W') {
        $x -= $dig;
    } elsif ($dir eq 'L') {
        $deg = ($deg + $dig) % 360;
    } elsif ($dir eq 'R') {
        $deg = ($deg - $dig) % 360;
    } elsif ($dir eq 'F') {
        if ($deg == 0) {
            $x += $dig;
        } elsif ($deg == 90) {
            $y += $dig;
        } elsif ($deg == 180) {
            $x -= $dig;
        } elsif ($deg == 270) {
            $y -= $dig;
        } else {
            die "Not covered: $deg\n";
        }
    }
}

my $result = abs($x) + abs($y);
print "$result\n";

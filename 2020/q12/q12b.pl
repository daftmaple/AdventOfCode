#!/usr/bin/perl
use strict;
use warnings;

open F, "q12_input.txt" or die;
chomp(my @nav = <F>);
close F;

my $x = 0;
my $y = 0;

my $wpx = 10;
my $wpy = 1;

# Use degree in maths
my $wpdeg = 0;

foreach my $move (@nav) {
    my ($dir, $dig) = $move =~ /(\w)(\d+)/;

    my ($npx, $npy) = ($wpx, $wpy);

    if ($dir eq 'N') {
        $wpy += $dig;
    } elsif ($dir eq 'S') {
        $wpy -= $dig;
    } elsif ($dir eq 'E') {
        $wpx += $dig;
    } elsif ($dir eq 'W') {
        $wpx -= $dig;
    } elsif ($dir eq 'L') {
        if ($dig == 0) {
            # Do nothing
        } elsif ($dig == 90) {
            $wpx = -1 * $npy;
            $wpy = $npx;
        } elsif ($dig == 180) {
            $wpx = -1 * $npx;
            $wpy = -1 * $npy;
        } elsif ($dig == 270) {
            $wpx = $npy;
            $wpy = -1 * $npx;
        } else {
            die "Not covered: $dig\n";
        }
    } elsif ($dir eq 'R') {
        if ($dig == 0) {
            # Do nothing
        } elsif ($dig == 90) {
            $wpx = $npy;
            $wpy = -1 * $npx;
        } elsif ($dig == 180) {
            $wpx = -1 * $npx;
            $wpy = -1 * $npy;
        } elsif ($dig == 270) {
            $wpx = -1 * $npy;
            $wpy = $npx;
        } else {
            die "Not covered: $dig\n";
        }
    } elsif ($dir eq 'F') {
        $x += $wpx * $dig;
        $y += $wpy * $dig;
    }
}

my $result = abs($x) + abs($y);
print "$result\n";

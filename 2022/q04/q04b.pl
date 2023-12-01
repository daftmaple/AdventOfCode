#!/usr/bin/perl
use strict;
use warnings;

open F, "q04_input.txt" or die;
chomp(my @input = <F>);
close F;

my $sum = 0;

foreach my $line (@input) {
    my @range = $line =~ /(\d+)-(\d+),(\d+)-(\d+)/;

    if ($range[0] >= $range[2] && $range[0] <= $range[3]) {
        $sum += 1;
    } elsif ($range[1] >= $range[2] && $range[1] <= $range[3]) {
        $sum += 1;
    } elsif ($range[2] >= $range[0] && $range[2] <= $range[1]) {
        $sum += 1;
    } elsif ($range[3] >= $range[0] && $range[3] <= $range[1]) {
        $sum += 1;
    }
}

print "$sum\n";

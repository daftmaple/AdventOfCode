#!/usr/bin/perl
use strict;
use warnings;

use Data::Dumper;

open F, "q06_input.txt" or die;
chomp(my @input = <F>);
close F;

my @lanternFishes = ($input[0] =~ /(\d+)/g);

my $remainingDays = 80;

# Probably not the most optimised method since this can be done mathematically
foreach my $day (0..($remainingDays - 1)) {
    # The amount of 8s need to be appended to the end of array
    my $appendCount = 0;

    for (my $i = 0; $i < scalar(@lanternFishes); $i++) {
        if ($lanternFishes[$i] == 0) {
            $appendCount++;
            $lanternFishes[$i] = 6;
        } else {
            $lanternFishes[$i]--;
        }
    }

    foreach my $append (0..($appendCount - 1)) {
        push @lanternFishes, 8;
    }
}

printf "%d\n", scalar(@lanternFishes);

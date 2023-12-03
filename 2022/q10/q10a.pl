#!/usr/bin/perl
use strict;
use warnings;

open F, "q10_input.txt" or die;
chomp(my @input = <F>);
close F;

my $registerX = 1;
my $addInTwoCycles = 0;
my $addInOneCycle = 0;

my $cycle = 1;

my $sum = 0;

foreach my $line (@input) {
    my ($op, $value) = $line =~ /(\w+)\s?(-?\d+)?/g;

    if ($op eq "addx") {
        for (my $i = 0; $i < 2; $i++) {
            checkCycle();
            $cycle++;
        }
        $registerX += $value;
    } else {
        checkCycle();
        $cycle++;
    }


    last if ($cycle > 220);
}

print "$sum\n";

sub checkCycle {
    if (grep( /^$cycle$/, (20, 60, 100, 140, 180, 220) )) {
        $sum += ($registerX * $cycle);
    }
}
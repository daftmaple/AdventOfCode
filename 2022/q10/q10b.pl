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
}

sub checkCycle {
    my $cycleRow = $cycle % 40;
    if ($cycleRow >= $registerX and $cycleRow <= $registerX + 2) {
        print "#";
    } else {
        print ".";
    }
    print "\n" if ($cycleRow == 0); 
}
#!/usr/bin/perl
use strict;
use warnings;

open F, "q02_input.txt" or die;
chomp(my @input = <F>);
close F;

my $sum = 0;

foreach my $line (@input) {
    my ($gameDigit, $combinationString) = $line =~ /Game (\d+): (.*)/g;
    my @combinations = split/; /, $combinationString;

    my %bag = ('red', 0, 'green', 0, 'blue', 0);
    foreach my $combination (@combinations) {
        my (@countColours) = $combination =~ /(\d+ \w+)/g;

        foreach my $countColour (@countColours) {
            my ($count, $colour) = $countColour =~ /(\d+) (\w+)/;

            $bag{$colour} = $count if !defined $bag{$colour} or $bag{$colour} < $count;
        }
    }

    if ($bag{'red'} <= 12 and $bag{'green'} <= 13 and $bag{'blue'} <= 14) {
        $sum += $gameDigit;
    }
}

print "$sum\n";

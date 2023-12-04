#!/usr/bin/perl
use strict;
use warnings;

use List::Util qw/sum/;

open F, "q04_input.txt" or die;
chomp(my @input = <F>);
close F;

my $sum = 0;

my $index = 1;

my @array = (0);

foreach my $line (@input) {
    $array[$index] += 1;

    my ($sequence1, $sequence2) = $line =~ /Card\s+\d+:\s+(.*)\s+\|\s+(.*)/g;
    my @winningNumbers = split ' ', $sequence1;
    my @numbers = split ' ', $sequence2;

    my $match = 0;
    foreach my $x (@winningNumbers) {
        foreach my $y (@numbers) {
            if ($x == $y) {
                $match++;
            }
        }
    }
    
    if ($match > 0) {
        for (my $i = 0; $i < $match; $i++) {
            $array[$index + $i + 1] += $array[$index];
        }
    }

    $index++;
}

my $result = eval join '+', @array;

print "$result\n";


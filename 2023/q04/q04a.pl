#!/usr/bin/perl
use strict;
use warnings;

open F, "q04_input.txt" or die;
chomp(my @input = <F>);
close F;

my $sum = 0;

foreach my $line (@input) {
    my ($sequence1, $sequence2) = $line =~ /Card\s+\d+:\s+(.*)\s+\|\s+(.*)/g;
    my @winningNumbers = split ' ', $sequence1;
    my @numbers = split ' ', $sequence2;

    my $point = 0;
    foreach my $x (@winningNumbers) {
        foreach my $y (@numbers) {
            if ($x == $y) {
                $point *= 2 if $point > 0;
                $point = 1 if $point == 0;
            }
        }
    }
    
    $sum += $point;
}

print "$sum\n";


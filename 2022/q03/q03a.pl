#!/usr/bin/perl
use strict;
use warnings;

open F, "q03_input.txt" or die;
chomp(my @input = <F>);
close F;

my $sum = 0;

foreach my $line (@input) {
    my @rucksackItems = split(//, $line);
    my $commonCharacter;
    my %map;

    foreach my $i (0 .. $#rucksackItems) {
        my $char = $rucksackItems[$i];
        if ($i < scalar(@rucksackItems) / 2) {
            $map{$char} = 1;
        } else {
            if (defined $map{$char} && $map{$char} == 1) {
                $map{$char} = 2;
            }
        }

        $commonCharacter = $char if (defined $map{$char} && $map{$char} == 2);
    }
    
    my $asciiDecimal = ord($commonCharacter);

    my $digit = 0;

    if ($asciiDecimal > 96) {
        $digit = $asciiDecimal - 96;
    } else {
        $digit = $asciiDecimal - 64 + 26;
    }

    $sum += $digit;
}

print "$sum\n";

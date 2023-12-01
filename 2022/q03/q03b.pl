#!/usr/bin/perl
use strict;
use warnings;

open F, "q03_input.txt" or die;
chomp(my @input = <F>);
close F;

my $sum = 0;

foreach my $i (0 .. scalar(@input) / 3 - 1) {
    my @rucksackItems1 = split(//, $input[$i * 3]);
    my @rucksackItems2 = split(//, $input[$i * 3 + 1]);
    my @rucksackItems3 = split(//, $input[$i * 3 + 2]);
    my $commonCharacter;
    my %map;

    foreach my $char (@rucksackItems1) {
        $map{$char} = 1;
    }
    foreach my $char (@rucksackItems2) {
        $map{$char} = 2 if defined $map{$char} and $map{$char} == 1;
    }
    foreach my $char (@rucksackItems3) {
        $commonCharacter = $char if defined $map{$char} and $map{$char} == 2;
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

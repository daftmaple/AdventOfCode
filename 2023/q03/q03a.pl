#!/usr/bin/perl
use strict;
use warnings;

open F, "q03_input.txt" or die;
chomp(my @input = <F>);
close F;

my @array = ();

my $result = 0;

foreach my $line (@input) {
    my @lineArray = $line =~ /(.)/g;
    push @array, \@lineArray;
}

for (my $x = 0; $x < scalar(@array); $x++) {
    for (my $y = 0; $y < scalar(@{$array[$x]}); $y++) {
        next if $array[$x][$y] !~ m/\d/;
        my $digitSequence = "";
        my $isAdjacentToSymbol = 0;

        while (defined $array[$x][$y] and $array[$x][$y] =~ m/\d/) {
            $digitSequence .= $array[$x][$y];
            $isAdjacentToSymbol = 1 if isAdjacentToSymbol($x, $y);
            $y++;
        }
       
        $result += int($digitSequence) if $isAdjacentToSymbol;
    }
}

print "$result\n";

sub isAdjacentToSymbol {
    my ($xCheck, $yCheck) = @_;

    my $isAdjacentToSymbol = 0;

    for (my $x = $xCheck - 1; $x <= $xCheck + 1; $x++) {
        next if !defined $array[$x];
        for (my $y = $yCheck - 1; $y <= $yCheck + 1; $y++) {
            next if !defined $array[$x][$y];
            next if $array[$x][$y] =~ m/\d/ or $array[$x][$y] =~ m/\./;
            $isAdjacentToSymbol = 1;
            last;
        }
        last if $isAdjacentToSymbol;
    }

    return $isAdjacentToSymbol;
}

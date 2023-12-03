#!/usr/bin/perl
use strict;
use warnings;

open F, "q03_input.txt" or die;
chomp(my @input = <F>);
close F;

my @array = ();
my %symbolRegister;

my $result = 0;

foreach my $line (@input) {
    my @lineArray = $line =~ /(.)/g;
    push @array, \@lineArray;
}

for (my $x = 0; $x < scalar(@array); $x++) {
    for (my $y = 0; $y < scalar(@{$array[$x]}); $y++) {
        next if $array[$x][$y] !~ m/\d/;
        my $originalY = $y;

        my $digitSequence = getDigitSequence($x, $y);
        my $hasBeenStored = 0;

        while (defined $array[$x][$y] and $array[$x][$y] =~ m/\d/) {
            if (!$hasBeenStored) {
                $hasBeenStored = storeToSymbol($x, $y, int($digitSequence));
            }
            $y++;
        }
    }
}

foreach my $key (keys %symbolRegister) {
    if (scalar(@{$symbolRegister{$key}}) == 2) {
        $result += ($symbolRegister{$key}[0] * $symbolRegister{$key}[1]);
    }
}

print "$result\n";

sub getDigitSequence {
    my ($x, $y) = @_;

    my $digitSequence = "";
    
    while (defined $array[$x][$y] and $array[$x][$y] =~ m/\d/) {
        $digitSequence .= $array[$x][$y];
        $y++;
    }

    return $digitSequence;
}


sub storeToSymbol {
    my ($xCheck, $yCheck, $digit) = @_;

    my $storedToSymbol = 0;

    for (my $x = $xCheck - 1; $x <= $xCheck + 1; $x++) {
        next if !defined $array[$x];
        for (my $y = $yCheck - 1; $y <= $yCheck + 1; $y++) {
            next if !defined $array[$x][$y];
            next if $array[$x][$y] !~ m/\*/;
            
            if (!defined $symbolRegister{"$x.$y"}) {
                my @store = ($digit);
                $symbolRegister{"$x.$y"} = \@store;
            } else {
                push @{$symbolRegister{"$x.$y"}}, $digit;
            }

            $storedToSymbol = 1;
            last;
        }
        last if $storedToSymbol;
    }

    return $storedToSymbol;
}

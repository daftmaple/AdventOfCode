#!/usr/bin/perl
use strict;
use warnings;

open F, "q01_input.txt" or die;
chomp(my @input = <F>);
close F;

my $elf = 0;
my @calories = ();

my $highestCalories = 0;

while (@input) {
    my $cal = shift (@input);

    # Increment elf count if empty
    if ($cal eq "") {
        if ($highestCalories < $calories[$elf]) {
            $highestCalories = $calories[$elf];
        }
        $elf++;
    }

    # Add calories to current elf if not empty
    $calories[$elf] += $cal if ($cal ne "");
}

print "$highestCalories\n";

#!/usr/bin/perl
use strict;
use warnings;

open F, "q01_input.txt" or die;
chomp(my @input = <F>);
close F;

my $elf = 0;
my @calories = ();

while (@input) {
    my $cal = shift (@input);

    # Increment elf count if empty
    $elf++ if ($cal eq "");

    # Add calories to current elf if not empty
    $calories[$elf] += $cal if ($cal ne "");
}

# Sort numerically
my @sortedCalories = sort  { $b <=> $a } @calories;

my $topThreeCalories = $sortedCalories[0] + $sortedCalories[1] + $sortedCalories[2];

print "$topThreeCalories\n";

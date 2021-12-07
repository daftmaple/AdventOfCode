#!/usr/bin/perl
use strict;
use warnings;

use Data::Dumper;

open F, "q15_input.txt" or die;
chomp(my @input = <F>);
close F;

my @spokenNumbers = ($input[0] =~ /(\d+)/g);

my $turn = scalar(@spokenNumbers);
my $lastSpoken = $spokenNumbers[@spokenNumbers - 1];

# Need memoisation since appending array would be too expensive

# Map<SpokenNumber, SecondLastSpokenIndex>
my %hashSpokenNumbersWithoutLast;

foreach my $numberIndex (0..(@spokenNumbers - 2)) {
    $hashSpokenNumbersWithoutLast{$spokenNumbers[$numberIndex]} = $numberIndex + 1;
}

my $target = 30000000;

while ($turn < $target) {
    # Get number of current turn
    my $currentTurnSpoken = getCurrentlySpokenNumber();

    # Store last spoken number and turn number to hash
    $hashSpokenNumbersWithoutLast{$lastSpoken} = $turn;

    # Store current turn spoken to lastSpoken and increment turn
    $lastSpoken = $currentTurnSpoken;
    $turn++;
}

print "$lastSpoken\n";

# return number
sub getCurrentlySpokenNumber {
    return 0 if (!defined($hashSpokenNumbersWithoutLast{$lastSpoken}));

    return abs($hashSpokenNumbersWithoutLast{$lastSpoken} - $turn);
}

#!/usr/bin/perl
use strict;
use warnings;

use Data::Dumper;

open F, "q15_input.txt" or die;
chomp(my @input = <F>);
close F;

my @spokenNumbers = ($input[0] =~ /(\d+)/g);

my $target = 2020;

while (scalar(@spokenNumbers) < $target) {
    if (!lastNumberHasBeenSpokenPreviously()) {
        push @spokenNumbers, 0;
    } else {
        push @spokenNumbers, diffSpoken()
    }

    # print Dumper @spokenNumbers;
    # exit;
}

my $lastSpoken = $spokenNumbers[@spokenNumbers - 1];

print "$lastSpoken\n";

# return boolean
sub lastNumberHasBeenSpokenPreviously {
    my $lastSpokenIndex = scalar(@spokenNumbers) - 1;

    foreach my $numbers (@spokenNumbers[0..($lastSpokenIndex - 1)]) {
        return 1 if ($numbers == $spokenNumbers[$lastSpokenIndex]);
    }

    return 0;
}

# return number
sub diffSpoken {
    my $lastSpokenIndex = scalar(@spokenNumbers) - 1;
    my $secondLastSpokenIndex = 0;
    foreach my $i (@0..($lastSpokenIndex - 1)) {
        if ($spokenNumbers[$i] == $spokenNumbers[$lastSpokenIndex]) {
            $secondLastSpokenIndex = $i;
        }
    }

    return $lastSpokenIndex - $secondLastSpokenIndex;
}

#!/usr/bin/perl
use strict;
use warnings;

use Data::Dumper;

open F, "q07_input.txt" or die;
chomp(my @input = <F>);
close F;

my @positions = sort { $a <=> $b } ($input[0] =~ /(\d+)/g);

my $lowerBound = $positions[0];
my $upperBound = $positions[scalar(@positions) - 1];

my $result = findResult($lowerBound, $upperBound);

print "$result\n";

sub findResult {
    my ($lowerBound, $upperBound) = @_;

    my $median = int(($lowerBound + $upperBound) / 2);

    my $sumDistanceMedian = sumDistance($median);
    my $sumDistanceMedianUp = sumDistance($median + 1);
    my $sumDistanceMedianDown = sumDistance($median - 1);
    

    if ($sumDistanceMedianDown < $sumDistanceMedian) {
        return findResult($lowerBound, $median);
    } elsif ($sumDistanceMedianUp < $sumDistanceMedian) {
        return findResult($median, $upperBound);
    }

    return $sumDistanceMedian;
}

# arg1 Ref<Array<number>>
# return number
sub avg {
    my ($arrayRef) = @_;

    my $total = 0;
    $total += $_ foreach @$arrayRef;
    return $total / scalar(@$arrayRef);
}

# arg1 number
# return number
sub round {
    return sprintf('%.0f', $_[0]);
}

# arg1 Position (number)
sub sumDistance {
    my ($point) = @_;
    my $result = 0;

    foreach my $position (@positions) {
        my $diff = abs($point - $position);
        $result += abs($diff * ($diff + 1) / 2);
    }

    return $result;
}

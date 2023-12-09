#!/usr/bin/perl
use strict;
use warnings;

open F, "q08_input.txt" or die;
chomp(my @input = <F>);
close F;

my $sequence = shift @input;
my @sequenceArray = split //, $sequence;
shift @input;

my %steps;

foreach my $line (@input) {
    my ($point, $left, $right) = $line =~ /(\w+) = \((\w+), (\w+)\)/;
    my %direction = ('L' => $left, 'R' => $right);
    $steps{$point} = \%direction;
}

my $found = 0;
my $steps = 0;
my $current = 'AAA';

while (!$found) {
    my $dir = $sequenceArray[$steps % scalar(@sequenceArray)];

    my $next = $steps{$current}{$dir};
    
    $steps += 1;

    if ($next ne 'ZZZ') {
        $current = $next;
    } else {
        $found = 1;
    }
}

print "$steps\n";

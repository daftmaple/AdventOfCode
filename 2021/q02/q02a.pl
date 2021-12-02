#!/usr/bin/perl
use strict;
use warnings;

open F, "q02_input.txt" or die;
chomp(my @input = <F>);
close F;

my $position = 0;
my $depth = 0;

foreach my $string (@input) {
    my ($move, $count) = ($string =~ /^(\w+) (\d+)$/);

    if ($move eq "forward") {
        $position += $count;
    }
    if ($move eq "up") {
        $depth -= $count;
    }
    if ($move eq "down") {
        $depth += $count;
    }
}

my $result = $position * $depth;

print "$result\n";

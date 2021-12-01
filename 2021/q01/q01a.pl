#!/usr/bin/perl
use strict;
use warnings;

open F, "q01_input.txt" or die;
chomp(my @input = <F>);
close F;

my $count = 0;
my $current;

while (@input) {
    my $number = shift (@input);

    if (defined $current and $number > $current) {
        $count++;
    }
    
    $current = $number;
}

print "$count\n";

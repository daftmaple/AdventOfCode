#!/usr/bin/perl
use strict;
use warnings;

open F, "q01_input.txt" or die;
chomp(my @input = <F>);
close F;

my $count = 0;
my $current;

for (my $i = 0; $i <= ($#input - 2); $i++) {
    my $number = $input[$i] + $input[$i + 1] + $input[$i + 2];

    if (defined $current and $number > $current) {
        $count++;
    }

    $current = $number;
}

print "$count\n";

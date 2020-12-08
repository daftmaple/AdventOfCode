#!/usr/bin/perl
use strict;
use warnings;

open F, "<q01_input.txt" or die;
chomp(my @a = <F>);
close F;

my $size = scalar @a;
my $i = 0;

while ($i < $size - 1) {
    my $j = $i + 1;
    while ($j < $size) {
        if ($a[$i] + $a[$j] == 2020) {
            my $result = $a[$i] * $a[$j];
            print "$result\n";
            exit;
        }
        $j++;
    }
    $i++;
}

die "Could not find result\n";

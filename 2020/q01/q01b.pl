#!/usr/bin/perl
use strict;
use warnings;

open F, "<q01_input.txt" or die;
chomp(my @a = <F>);
close F;

my $size = scalar @a;
my $i = 0;

while ($i < $size - 2) {
    my $j = $i + 1;
    while ($j < $size - 1) {
        my $k = $j + 1;
        while ($k < $size) {
            if ($a[$i] + $a[$j] + $a[$k] == 2020) {
                my $result = $a[$i] * $a[$j] * $a[$k];
                print "$result\n";
                exit;
            }
            $k++;
        }
        $j++;
    }
    $i++;
}

die "Could not find result\n";

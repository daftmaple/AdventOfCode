#!/usr/bin/perl
use strict;
use warnings;

open F, "<q01_input.txt" or die;
while (<F>) {
    chomp;
    push @a, $_;
}
close F;

$size = scalar @a;
$i = 0;

while ($i < $size - 2) {
    $j = $i + 1;
    while ($j < $size - 1) {
        $k = $j + 1;
        while ($k < $size) {
            if ($a[$i] + $a[$j] + $a[$k] == 2020) {
                $result = $a[$i] * $a[$j] * $a[$k];
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

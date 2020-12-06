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

while ($i < $size - 1) {
    $j = $i + 1;
    while ($j < $size) {
        if ($a[$i] + $a[$j] == 2020) {
            $result = $a[$i] * $a[$j];
            print "$result\n";
            exit;
        }
        $j++;
    }
    $i++;
}

die "Could not find result\n";

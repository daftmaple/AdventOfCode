#!/usr/bin/perl
use strict;
use warnings;

open F, "<q08_input.txt" or die;
$str = <F>;
close F;

@arr = ();

$layer = 25 * 6;

$i = 0;
while ($i < length($str) / $layer) {
    $input = substr($str, $i * $layer, $layer);
    push @arr, $input;
    $i++;
}

$i = 0;

@overall = (2) x $layer;

foreach $k (@arr) {
    @chopped = split //, $k;
    $j = 0;
    while ($j < (@chopped)) {
        $overall[$j] = $chopped[$j] if $overall[$j] == 2;
        $j++;
    }
    $i++;
}

$i = 0;
while ($i < (@overall)) {
    if ($overall[$i] == 1) {
        print '#';
    } else {
        print ' ';
    }
    $i++;
    print "\n" if $i % 25 == 0; 
}

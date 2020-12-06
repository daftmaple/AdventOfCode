#!/usr/bin/perl
use strict;
use warnings;

open F, "<q01_input.txt" or die;
@a = split //, <F>;
close F;

$a = 0;
$b = 0;

foreach $c (@a) {
    $a++ if $c eq '(';
    $b++ if $c eq ')';
}

print $a - $b;
print "\n";

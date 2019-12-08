#!/usr/bin/perl -w

open F, "<q01_input.txt" or die;
@a = split //, <F>;
close F;

$a = 0;
$b = 0;
$i = 1;

foreach $c (@a) {
    $a++ if $c eq '(';
    $b++ if $c eq ')';
    last if $b > $a;
    $i++;
}

print "$i\n";

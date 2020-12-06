#!/usr/bin/perl
use strict;
use warnings;

open F, "<q01_input.txt" or die;
my @a = split //, <F>;
close F;

my $a = 0;
my $b = 0;

foreach $c (@a) {
    $a++ if $c eq '(';
    $b++ if $c eq ')';
}

print $a - $b;
print "\n";

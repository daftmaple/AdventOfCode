#!/usr/bin/perl
use strict;
use warnings;

open F, "<q01_input.txt" or die;

my $a = 0;

while (<F>) {
    my $t = int($_ / 3) - 2;
    $a += $t if $t >= 0;
}
close F;

print "$a\n";

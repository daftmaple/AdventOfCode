#!/usr/bin/perl -w

open F, "<q01_input.txt" or die;

$a = 0;

while (<F>) {
    my $t = int($_ / 3) - 2;
    $a += $t if $t >= 0;
}
close F;

print "$a\n";

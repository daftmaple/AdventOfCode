#!/usr/bin/perl
use strict;
use warnings;


open F, "q01_input.txt" or die;
chomp(my @input = <F>);
close F;

my $sum = 0;

foreach my $line (@input) {
    my @firstDigit = $line =~ /(\d).*/;
    my @lastDigit = $line =~ /.*(\d)/;

    my $lineDigit = join '', ($firstDigit[0], $lastDigit[0]);
    $sum = $sum + $lineDigit;
}

print "$sum\n";

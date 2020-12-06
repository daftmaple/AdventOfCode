#!/usr/bin/perl
use strict;
use warnings;

open F, "<q03_input.txt" or die;
my @methods = split //, <F>;
close F;

my %coord;

my $currX = 0;
my $currY = 0;

$coord{$currX}{$currY}++;

foreach my $method (@methods) {
    $currX-- if $method eq '<';
    $currX++ if $method eq '>';
    $currY++ if $method eq '^';
    $currY-- if $method eq 'v';
    $coord{$currX}{$currY}++;
}

my $c = 0;
foreach my $X (keys %coord) {
    foreach my $v (values %{$coord{$X}}) {
        $c++;
    }
}

print "$c\n";

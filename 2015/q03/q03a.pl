#!/usr/bin/perl
use strict;
use warnings;

open F, "<q03_input.txt" or die;
@methods = split //, <F>;
close F;

%coord;

$currX = 0;
$currY = 0;

$coord{$currX}{$currY}++;

foreach my $method (@methods) {
    $currX-- if $method eq '<';
    $currX++ if $method eq '>';
    $currY++ if $method eq '^';
    $currY-- if $method eq 'v';
    $coord{$currX}{$currY}++;
}

$c = 0;
foreach my $X (keys %coord) {
    foreach my $v (values %{$coord{$X}}) {
        $c++;
    }
}

print "$c\n";

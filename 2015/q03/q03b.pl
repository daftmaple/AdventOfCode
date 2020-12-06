#!/usr/bin/perl
use strict;
use warnings;

open F, "<q03_input.txt" or die;
my @methods = split //, <F>;
close F;

my %coord;

my $currXa = 0;
my $currYa = 0;
my $currXb = 0;
my $currYb = 0;

$coord{$currXa}{$currYa}++;

my $bin = 0;
foreach my $method (@methods) {
    if ($bin) {
        $bin = 0;
        $currXa-- if $method eq '<';
        $currXa++ if $method eq '>';
        $currYa++ if $method eq '^';
        $currYa-- if $method eq 'v';
        $coord{$currXa}{$currYa}++;
    } else {
        $bin = 1;
        $currXb-- if $method eq '<';
        $currXb++ if $method eq '>';
        $currYb++ if $method eq '^';
        $currYb-- if $method eq 'v';
        $coord{$currXb}{$currYb}++;
    }
}

my $c = 0;
foreach my $X (keys %coord) {
    foreach my $v (values %{$coord{$X}}) {
        $c++;
    }
}

print "$c\n";

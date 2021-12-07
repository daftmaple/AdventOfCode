#!/usr/bin/perl
use strict;
use warnings;

use Data::Dumper;

open F, "q05_input.txt" or die;
chomp(my @input = <F>);
close F;

my %map;

foreach my $line (@input) {
    my ($originX, $originY, $destinationX, $destinationY) = ($line =~ /(\d+),(\d+) -> (\d+),(\d+)/);

    if ($originY == $destinationY) {
        my $y = $originY;

        if ($originX > $destinationX) {
            my $temp = $destinationX;
            $destinationX = $originX;
            $originX = $temp;
        }

        foreach my $x ($originX..$destinationX) {
            $map{$x}{$y}++;
        }
    }

    if ($originX == $destinationX) {
        my $x = $originX;

        if ($originY > $destinationY) {
            my $temp = $destinationY;
            $destinationY = $originY;
            $originY = $temp;
        }

        foreach my $y ($originY..$destinationY) {
            $map{$x}{$y}++;
        }
    }
}

my $count = 0;
foreach my $x (keys %map) {
    foreach my $y (keys %{$map{$x}}) {
        $count++ if ($map{$x}{$y} > 1);
    }
}

print "$count\n";

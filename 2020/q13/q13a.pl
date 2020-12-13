#!/usr/bin/perl
use strict;
use warnings;

open F, "q13_input.txt" or die;
chomp(my @input = <F>);
close F;

my ($timestamp, $ids) = @input;

my @id = grep { $_ ne "x" } split /,/, $ids;

my $bid;
my $diff;
foreach my $busID (@id) {
    my $mod = $busID - ($timestamp + $busID) % $busID;
    if (!defined $diff or $diff > $mod) {
        $diff = $mod;
        $bid = $busID;
    }
}

my $result = $bid * $diff;
print "$result\n";

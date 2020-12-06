#!/usr/bin/perl

use strict;
use warnings;

my @array = ();
my @count = ();
my $index = 0;
open F, "q06_input.txt" or die;
while (<F>) {
    chomp $_;
    if (length($_) == 0) {
        $index++;
    } else {
        $array[$index] .= $_;
        $count[$index]++;
    }
}
close F;

my $count = 0;
for (my $idx = 0; $idx < scalar(@array); $idx++) {
    my $str = $array[$idx];
    my %hash;
    foreach my $char (split('', $str)) {
        $hash{$char}++;
    }
    my $ct = 0;
    for my $i ("a".."z") {
        $ct++ if defined $hash{$i} and $hash{$i} == $count[$idx];
    }
    $count += $ct;
}

print "$count\n";
